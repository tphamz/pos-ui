import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../providers/edit_mode_provider.dart';
import '../../../providers/pos_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/blueprint_provider.dart';
import '../../../providers/entity_providers.dart';
import '../../../models/auth_models.dart';
import '../../../models/blueprint_models.dart';
import '../../../providers/api_providers.dart';
import '../../../utils/snackbar_helper.dart';

/// Staff tab
class StaffTab extends ConsumerStatefulWidget {
  const StaffTab({super.key});

  @override
  ConsumerState<StaffTab> createState() => _StaffTabState();
}

class _StaffTabState extends ConsumerState<StaffTab> {
  List<Map<String, dynamic>> _staff = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStaff();
  }

  Future<void> _loadStaff() async {
    final authState = ref.read(authProvider);
    final businessId = authState.currentBusinessId;
    
    if (businessId == null) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _staff = [];
        });
      }
      return;
    }

    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    try {
      final entityService = ref.read(entityServiceProvider(businessId));
      final staff = await entityService.get('staff');
      
      if (mounted) {
        setState(() {
          _staff = staff;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _staff = [];
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final editMode = ref.watch(editModeProvider);
    
    // Get staff label from blueprint
    final labelMappings = ref.watch(labelMappingsProvider);
    final staffLabel = (labelMappings['staff'] as String?) ?? 'Staff';

    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        // Header with add button (only in edit mode)
        if (editMode)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _showAddStaffDialog(context),
                  icon: const Icon(Icons.add, size: 20),
                  label: Text('Add $staffLabel'),
                ),
              ],
            ),
          ),
        // Staff grid
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 0.85,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _staff.length,
              itemBuilder: (context, index) {
                final member = _staff[index];
                final memberRole = member['role'] as String? ?? '';
                final isOwner = memberRole.toLowerCase() == 'owner';
                
                return _StaffCard(
                  staffId: member['id'] as String,
                  name: member['full_name'] as String? ?? member['name'] as String? ?? '',
                  role: memberRole.isNotEmpty ? memberRole : 'staff',
                  isActive: member['isActive'] as bool? ?? member['is_active'] as bool? ?? true,
                  avatarUrl: member['avatar'] as String?,
                  // Edit button commented out for now
                  onEdit: null, // editMode ? () => _showEditStaffDialog(context, member) : null,
                  onDelete: editMode && !isOwner ? () => _showDeleteStaffDialog(context, member) : null,
                  onTap: () {
                    // Select ticket for this staff member
                    ref.read(posProvider.notifier).selectTicketByStaff(member['id'] as String);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _showAddStaffDialog(BuildContext context) async {
    final authState = ref.read(authProvider);
    final businessId = authState.currentBusinessId;
    if (businessId == null) return;

    final labelMappings = ref.read(labelMappingsProvider);
    final staffLabel = (labelMappings['staff'] as String?) ?? 'Staff';
    final blueprint = ref.read(currentBlueprintProvider);

    showDialog(
      context: context,
      builder: (context) => _StaffDialog(
        staffLabel: staffLabel,
        businessId: businessId,
        blueprint: blueprint,
        onSave: (userRole) async {
          try {
            // Refresh staff list after adding
            await _loadStaff();
            if (mounted) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Staff member added successfully')),
              );
            }
          } catch (e) {
            if (mounted) {
              showErrorSnackBar(context, 'Failed to add staff: $e');
            }
          }
        },
      ),
    );
  }

  void _showEditStaffDialog(BuildContext context, Map<String, dynamic> staff) async {
    final authState = ref.read(authProvider);
    final businessId = authState.currentBusinessId;
    if (businessId == null) return;

    final labelMappings = ref.read(labelMappingsProvider);
    final staffLabel = (labelMappings['staff'] as String?) ?? 'Staff';
    final blueprint = ref.read(currentBlueprintProvider);

    showDialog(
      context: context,
      builder: (context) => _StaffDialog(
        staffLabel: staffLabel,
        staff: staff,
        businessId: businessId,
        blueprint: blueprint,
        onSave: (userRole) async {
          try {
            // Refresh staff list after updating
            await _loadStaff();
            if (mounted) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Staff member updated successfully')),
              );
            }
          } catch (e) {
            if (mounted) {
              showErrorSnackBar(context, 'Failed to update staff: $e');
            }
          }
        },
      ),
    );
  }

  void _showDeleteStaffDialog(BuildContext context, Map<String, dynamic> staff) async {
    final authState = ref.read(authProvider);
    final businessId = authState.currentBusinessId;
    if (businessId == null) return;

    // Check if user is owner - prevent deletion
    final role = staff['role'] as String? ?? '';
    if (role.toLowerCase() == 'owner') {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cannot delete owner. Owner role cannot be removed.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Staff'),
        content: Text('Are you sure you want to delete "${staff['full_name'] ?? staff['name'] ?? 'this staff member'}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              try {
                final entityService = ref.read(entityServiceProvider(businessId));
                await entityService.delete('staff', staff['id'] as String);
                if (mounted) {
                  setState(() {
                    _staff.removeWhere((s) => s['id'] == staff['id']);
                  });
                  Navigator.of(context).pop();
                }
              } catch (e) {
                if (mounted) {
                  Navigator.of(context).pop();
                  showErrorSnackBar(context, 'Failed to delete staff: $e');
                }
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _StaffCard extends StatelessWidget {
  final String staffId;
  final String name;
  final String role;
  final bool isActive;
  final String? avatarUrl;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const _StaffCard({
    required this.staffId,
    required this.name,
    required this.role,
    required this.isActive,
    this.avatarUrl,
    this.onEdit,
    this.onDelete,
    this.onTap,
  });

  String get _initials {
    return name
        .split(' ')
        .map((n) => n[0])
        .join('')
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      child: Stack(
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Avatar in the middle
                  Expanded(
                    child: Center(
                      child: avatarUrl != null
                          ? ClipOval(
                              child: Image.network(
                                avatarUrl!,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  // Fallback to initials if image fails to load
                                  return _buildAvatar(context, isDark);
                                },
                              ),
                            )
                          : _buildAvatar(context, isDark),
                    ),
                  ),
              
              const SizedBox(height: 12),
              
              // Name at the bottom
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              
              const SizedBox(height: 4),
              
              // Role badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isDark 
                      ? const Color(0xFF383838) 
                      : const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  role,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark 
                        ? const Color(0xFFA3A3A3) 
                        : const Color(0xFF737373),
                  ),
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Active status indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isActive ? Colors.green : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    isActive ? 'Active' : 'Inactive',
                    style: TextStyle(
                      fontSize: 11,
                      color: isActive ? Colors.green : Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
          // Edit and Delete buttons in top right (only in edit mode)
          if (onEdit != null || onDelete != null)
            Positioned(
          top: 8,
          right: 8,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (onEdit != null)
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onEdit,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 32,
                      height: 32,
                      margin: const EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                        color: isDark 
                            ? const Color(0xFF292929).withOpacity(0.9)
                            : Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.edit,
                        size: 16,
                        color: isDark 
                            ? const Color(0xFFD9D9D9) 
                            : const Color(0xFF262626),
                      ),
                    ),
                  ),
                ),
              if (onDelete != null)
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onDelete,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isDark 
                            ? const Color(0xFF292929).withOpacity(0.9)
                            : Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, bool isDark) {
    return CircleAvatar(
      radius: 40,
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Text(
        _initials,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
    );
  }
}

/// Dialog for adding/editing staff
class _StaffDialog extends ConsumerStatefulWidget {
  final String staffLabel;
  final Map<String, dynamic>? staff;
  final String businessId;
  final Blueprint? blueprint;
  final Function(UserBusinessRole) onSave;

  const _StaffDialog({
    required this.staffLabel,
    this.staff,
    required this.businessId,
    this.blueprint,
    required this.onSave,
  });

  @override
  ConsumerState<_StaffDialog> createState() => _StaffDialogState();
}

class _StaffDialogState extends ConsumerState<_StaffDialog> {
  final _formKey = GlobalKey<FormState>();
  final _imagePicker = ImagePicker();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _reenterPasswordController;
  String? _selectedRole;
  bool _isActive = true;
  File? _selectedAvatar;
  String? _avatarUrl; // For existing avatar URL
  bool _isLoading = false;
  String? _errorMessage; // For sticky error display

  List<String> get _availableRoles {
    if (widget.blueprint?.permissions == null) {
      return ['server', 'manager', 'cashier']; // Default roles
    }
    
    final permissions = widget.blueprint!.permissions as Map<String, dynamic>?;
    if (permissions == null) {
      return ['server', 'manager', 'cashier'];
    }
    
    // Extract role names from permissions map
    return permissions.keys.toList()..remove('owner'); // Exclude owner role
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.staff?['name'] ?? '');
    _emailController = TextEditingController(text: widget.staff?['email'] ?? '');
    _phoneController = TextEditingController(text: widget.staff?['phone'] ?? '');
    _passwordController = TextEditingController();
    _reenterPasswordController = TextEditingController();
    _selectedRole = widget.staff?['role'] as String?;
    _isActive = widget.staff?['isActive'] ?? true;
    _avatarUrl = widget.staff?['avatar'] as String?;
    
    // Set default role if available
    if (_selectedRole == null && _availableRoles.isNotEmpty) {
      _selectedRole = _availableRoles.first;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _reenterPasswordController.dispose();
    super.dispose();
  }

  Future<void> _pickAvatar() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 400,
        maxHeight: 400,
        imageQuality: 85,
      );
      if (image != null) {
        setState(() {
          _selectedAvatar = File(image.path);
          _avatarUrl = null; // Clear URL when new avatar is selected
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Error picking image: $e';
        });
      }
    }
  }

  bool get _canEditEmail {
    final existingEmail = widget.staff?['email'] as String?;
    return existingEmail == null || existingEmail.isEmpty;
  }

  bool get _canEditPhone {
    final existingPhone = widget.staff?['phone'] as String?;
    return existingPhone == null || existingPhone.isEmpty;
  }

  Future<void> _assignBusinessRole() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userService = ref.read(userServiceProvider);
      final entityService = ref.read(entityServiceProvider(widget.businessId));
      
      final request = AssignBusinessRoleRequest(
        fullName: _nameController.text,
        email: _emailController.text,
        phoneNumber: _phoneController.text,
        role: _selectedRole!,
        password: _passwordController.text.isNotEmpty ? _passwordController.text : null,
      );

      // assignBusinessRole now uses EntityService - saves locally first, queues for sync
      // The queue will call StaffRemoteRepository.create() which calls assignBusinessRole API
      final userRole = await userService.assignBusinessRole(
        widget.businessId,
        request,
        entityService,
      );

      if (mounted) {
        widget.onSave(userRole);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to add staff: $e';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.staff != null;

    return Dialog(
      child: Container(
        width: 500,
        constraints: const BoxConstraints(maxHeight: 800),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Fixed header
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isEdit ? 'Edit ${widget.staffLabel}' : 'Add ${widget.staffLabel}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            // Scrollable form content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              const SizedBox(height: 24),
              // Avatar upload section
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickAvatar,
                      child: Stack(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2,
                              ),
                            ),
                            child: ClipOval(
                              child: _selectedAvatar != null
                                  ? Image.file(
                                      _selectedAvatar!,
                                      fit: BoxFit.cover,
                                    )
                                  : _avatarUrl != null
                                      ? Image.network(
                                          _avatarUrl!,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return _buildAvatarPlaceholder();
                                          },
                                        )
                                      : _buildAvatarPlaceholder(),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton.icon(
                      onPressed: _pickAvatar,
                      icon: const Icon(Icons.upload, size: 16),
                      label: Text(_selectedAvatar != null || _avatarUrl != null 
                          ? 'Change Avatar' 
                          : 'Upload Avatar'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Name field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Role dropdown
              DropdownButtonFormField<String>(
                value: _selectedRole,
                decoration: const InputDecoration(
                  labelText: 'Role *',
                  border: OutlineInputBorder(),
                ),
                items: _availableRoles.map((role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role[0].toUpperCase() + role.substring(1)), // Capitalize first letter
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a role';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Email field
              TextFormField(
                controller: _emailController,
                enabled: widget.staff == null, // Only editable when adding new staff
                decoration: InputDecoration(
                  labelText: 'Email *',
                  border: const OutlineInputBorder(),
                  helperText: widget.staff != null && !_canEditEmail 
                      ? 'Email cannot be changed once set' 
                      : null,
                ),
                keyboardType: TextInputType.emailAddress,
                readOnly: widget.staff != null,
                validator: widget.staff == null ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email address';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                } : null,
              ),
              const SizedBox(height: 16),
              // Phone field
              TextFormField(
                controller: _phoneController,
                enabled: widget.staff == null, // Only editable when adding new staff
                decoration: InputDecoration(
                  labelText: 'Phone Number *',
                  border: const OutlineInputBorder(),
                  helperText: widget.staff != null && !_canEditPhone 
                      ? 'Phone cannot be changed once set' 
                      : null,
                ),
                keyboardType: TextInputType.phone,
                readOnly: widget.staff != null,
                validator: widget.staff == null ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                } : null,
              ),
              const SizedBox(height: 24),
              // Password fields (for new users)
              if (widget.staff == null) ...[
                // Password field
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password (Optional)',
                    border: OutlineInputBorder(),
                    helperText: 'New users only - leave empty if user exists',
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                // Re-enter password field
                TextFormField(
                  controller: _reenterPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Re-enter Password',
                    border: OutlineInputBorder(),
                    helperText: 'Required if password is provided',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (_passwordController.text.isNotEmpty) {
                      if (value == null || value.isEmpty) {
                        return 'Please re-enter the password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
              ],
              // Active status (only for edit mode)
              if (widget.staff != null) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Active Status'),
                    Switch(
                      value: _isActive,
                      onChanged: (value) {
                        setState(() {
                          _isActive = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
              const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
            // Fixed buttons with overlay error message
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _isLoading ? null : () async {
                          // Clear any previous error
                          setState(() {
                            _errorMessage = null;
                          });
                          
                          if (_formKey.currentState!.validate()) {
                            if (widget.staff == null) {
                              // Add new staff - call assign business role
                              await _assignBusinessRole();
                            } else {
                              // Edit existing staff - use old logic (for now)
                              final staff = {
                                'id': widget.staff!['id'],
                                'name': _nameController.text,
                                'role': _selectedRole,
                                'email': _emailController.text.isNotEmpty 
                                    ? _emailController.text 
                                    : widget.staff?['email'],
                                'phone': _phoneController.text.isNotEmpty 
                                    ? _phoneController.text 
                                    : widget.staff?['phone'],
                                'isActive': _isActive,
                                'avatar': _selectedAvatar != null 
                                    ? _selectedAvatar!.path
                                    : _avatarUrl,
                              };
                              // TODO: Update edit logic to use update user endpoint
                              widget.onSave(UserBusinessRole(
                                id: staff['id'] as String,
                                userId: staff['id'] as String,
                                businessId: widget.businessId,
                                role: staff['role'] as String,
                                isActive: staff['isActive'] as bool,
                                createdAt: DateTime.now(),
                                updatedAt: DateTime.now(),
                              ));
                            }
                          }
                        },
                        child: _isLoading 
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Text(widget.staff == null ? 'Add' : 'Save'),
                      ),
                    ],
                  ),
                ),
                // Overlay error message at bottom
                if (_errorMessage != null)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        border: Border(
                          top: BorderSide(color: Colors.red.shade200, width: 1),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, -2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline, color: Colors.red.shade700, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _errorMessage!,
                              style: TextStyle(
                                color: Colors.red.shade700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, size: 18),
                            color: Colors.red.shade700,
                            onPressed: () {
                              setState(() {
                                _errorMessage = null;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarPlaceholder() {
    final initials = _nameController.text.isNotEmpty
        ? _nameController.text
            .split(' ')
            .map((n) => n[0])
            .join('')
            .toUpperCase()
        : '?';
    
    return Container(
      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
