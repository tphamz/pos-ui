import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../providers/edit_mode_provider.dart';
import '../../../providers/pos_provider.dart';

/// Staff tab
class StaffTab extends ConsumerStatefulWidget {
  const StaffTab({super.key});

  @override
  ConsumerState<StaffTab> createState() => _StaffTabState();
}

class _StaffTabState extends ConsumerState<StaffTab> {

  // Mock data - will be replaced with actual data from backend
  final List<Map<String, dynamic>> _staff = [
      {
        'id': '1',
        'name': 'John Doe',
        'role': 'Stylist',
        'isActive': true,
        'avatar': null, // Can be replaced with image URL
      },
      {
        'id': '2',
        'name': 'Jane Smith',
        'role': 'Colorist',
        'isActive': true,
        'avatar': null,
      },
      {
        'id': '3',
        'name': 'Bob Johnson',
        'role': 'Manager',
        'isActive': false,
        'avatar': null,
      },
      {
        'id': '4',
        'name': 'Alice Brown',
        'role': 'Stylist',
        'isActive': true,
        'avatar': null,
      },
      {
        'id': '5',
        'name': 'Charlie Wilson',
        'role': 'Assistant',
        'isActive': true,
        'avatar': null,
      },
    ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final editMode = ref.watch(editModeProvider);

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
                  label: const Text('Add Staff'),
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
                return _StaffCard(
                  staffId: member['id'] as String,
                  name: member['name'] as String,
                  role: member['role'] as String,
                  isActive: member['isActive'] as bool,
                  avatarUrl: member['avatar'] as String?,
                  onEdit: editMode ? () => _showEditStaffDialog(context, member) : null,
                  onDelete: editMode ? () => _showDeleteStaffDialog(context, member) : null,
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

  void _showAddStaffDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _StaffDialog(
        onSave: (staff) {
          setState(() {
            _staff.add(staff);
          });
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _showEditStaffDialog(BuildContext context, Map<String, dynamic> staff) {
    showDialog(
      context: context,
      builder: (context) => _StaffDialog(
        staff: staff,
        onSave: (updatedStaff) {
          setState(() {
            final index = _staff.indexWhere((s) => s['id'] == staff['id']);
            if (index != -1) {
              _staff[index] = updatedStaff;
            }
          });
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _showDeleteStaffDialog(BuildContext context, Map<String, dynamic> staff) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Staff'),
        content: Text('Are you sure you want to delete "${staff['name']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _staff.removeWhere((s) => s['id'] == staff['id']);
              });
              Navigator.of(context).pop();
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
class _StaffDialog extends StatefulWidget {
  final Map<String, dynamic>? staff;
  final Function(Map<String, dynamic>) onSave;

  const _StaffDialog({
    this.staff,
    required this.onSave,
  });

  @override
  State<_StaffDialog> createState() => _StaffDialogState();
}

class _StaffDialogState extends State<_StaffDialog> {
  final _formKey = GlobalKey<FormState>();
  final _imagePicker = ImagePicker();
  late TextEditingController _nameController;
  late TextEditingController _roleController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  bool _isActive = true;
  File? _selectedAvatar;
  String? _avatarUrl; // For existing avatar URL

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.staff?['name'] ?? '');
    _roleController = TextEditingController(text: widget.staff?['role'] ?? '');
    _emailController = TextEditingController(text: widget.staff?['email'] ?? '');
    _phoneController = TextEditingController(text: widget.staff?['phone'] ?? '');
    _isActive = widget.staff?['isActive'] ?? true;
    _avatarUrl = widget.staff?['avatar'] as String?;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking image: $e')),
        );
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

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.staff != null;

    return Dialog(
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isEdit ? 'Edit Staff' : 'Add Staff',
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
              // Role field
              TextFormField(
                controller: _roleController,
                decoration: const InputDecoration(
                  labelText: 'Role *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a role';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Email field
              TextFormField(
                controller: _emailController,
                enabled: _canEditEmail,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: const OutlineInputBorder(),
                  helperText: widget.staff != null && !_canEditEmail 
                      ? 'Email cannot be changed once set' 
                      : null,
                ),
                keyboardType: TextInputType.emailAddress,
                readOnly: !_canEditEmail,
              ),
              const SizedBox(height: 16),
              // Phone field
              TextFormField(
                controller: _phoneController,
                enabled: _canEditPhone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: const OutlineInputBorder(),
                  helperText: widget.staff != null && !_canEditPhone 
                      ? 'Phone cannot be changed once set' 
                      : null,
                ),
                keyboardType: TextInputType.phone,
                readOnly: !_canEditPhone,
              ),
              const SizedBox(height: 16),
              // Active status
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
              const SizedBox(height: 24),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final staff = {
                          'id': widget.staff?['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
                          'name': _nameController.text,
                          'role': _roleController.text,
                          'email': _emailController.text.isNotEmpty 
                              ? _emailController.text 
                              : widget.staff?['email'],
                          'phone': _phoneController.text.isNotEmpty 
                              ? _phoneController.text 
                              : widget.staff?['phone'],
                          'isActive': _isActive,
                          'avatar': _selectedAvatar != null 
                              ? _selectedAvatar!.path // In real app, upload to server and get URL
                              : _avatarUrl,
                        };
                        widget.onSave(staff);
                      }
                    },
                    child: Text(isEdit ? 'Save' : 'Add'),
                  ),
                ],
              ),
            ],
          ),
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
