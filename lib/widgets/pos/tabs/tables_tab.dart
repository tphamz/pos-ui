import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/edit_mode_provider.dart';
import '../../../providers/pos_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/blueprint_provider.dart';
import '../../../providers/entity_providers.dart';
import '../../../utils/snackbar_helper.dart';

/// Tables/Stations/Registers tab
class TablesTab extends ConsumerStatefulWidget {
  const TablesTab({super.key});

  @override
  ConsumerState<TablesTab> createState() => _TablesTabState();
}

class _TablesTabState extends ConsumerState<TablesTab> {
  List<Map<String, dynamic>> _tables = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTables();
  }

  Future<void> _loadTables() async {
    final authState = ref.read(authProvider);
    final businessId = authState.currentBusinessId;
    
    if (businessId == null) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _tables = [];
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
      final tables = await entityService.get('table');
      
      if (mounted) {
        setState(() {
          _tables = tables;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _tables = [];
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final editMode = ref.watch(editModeProvider);
    
    // Get table label from blueprint
    final labelMappings = ref.watch(labelMappingsProvider);
    final tableLabel = (labelMappings['tables'] as String?) ?? 'Table';

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
                  onPressed: () => _showAddTableDialog(context),
                  icon: const Icon(Icons.add, size: 20),
                  label: Text('Add $tableLabel'),
                ),
              ],
            ),
          ),
        // Tables grid or empty state
        Expanded(
          child: _tables.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.table_restaurant_outlined,
                        size: 64,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No tables yet',
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        editMode
                            ? 'Tap "Add $tableLabel" to create your first $tableLabel'
                            : 'Enable edit mode to add $tableLabel',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1.2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: _tables.length,
                    itemBuilder: (context, index) {
                      final table = _tables[index];
                      final status = table['status'] as String;
                      final isAvailable = status == 'available';

                      return _TableCard(
                        table: table,
                        isAvailable: isAvailable,
                        onEdit: editMode ? () => _showEditTableDialog(context, table) : null,
                        onDelete: editMode ? () => _showDeleteTableDialog(context, table) : null,
                        onTap: () {
                          // Select ticket for this table
                          ref.read(posProvider.notifier).selectTicketByTable(table['number'] as String);
                        },
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }

  void _showAddTableDialog(BuildContext context) async {
    final authState = ref.read(authProvider);
    final businessId = authState.currentBusinessId;
    if (businessId == null) return;

    final labelMappings = ref.read(labelMappingsProvider);
    final tableLabel = (labelMappings['tables'] as String?) ?? 'Table';

    showDialog(
      context: context,
      builder: (context) => _TableDialog(
        tableLabel: tableLabel,
        onSave: (table) async {
          try {
            final entityService = ref.read(entityServiceProvider(businessId));
            // Use generic save() - TableLocalRepository.execute() handles list manipulation
            await entityService.save(
              resourceName: 'table',
              id: table['id'] as String? ?? table['number'] as String,
              data: table,
              isCreate: true,
            );
            setState(() {
              _tables.add(table);
            });
            if (mounted) {
              Navigator.of(context).pop();
            }
          } catch (e) {
            if (mounted) {
              showErrorSnackBar(context, 'Failed to add table: $e');
            }
          }
        },
      ),
    );
  }

  void _showEditTableDialog(BuildContext context, Map<String, dynamic> table) async {
    final labelMappings = ref.read(labelMappingsProvider);
    final tableLabel = (labelMappings['tables'] as String?) ?? 'Table';
    final authState = ref.read(authProvider);
    final businessId = authState.currentBusinessId;
    if (businessId == null) return;

    showDialog(
      context: context,
      builder: (context) => _TableDialog(
        tableLabel: tableLabel,
        table: table,
        onSave: (updatedTable) async {
          try {
            final entityService = ref.read(entityServiceProvider(businessId));
            final tableId = table['id'] as String;
            // Use generic save() - TableLocalRepository.execute() handles list manipulation
            await entityService.save(
              resourceName: 'table',
              id: tableId,
              data: updatedTable,
              isCreate: false,
            );
            setState(() {
              final index = _tables.indexWhere((t) => t['id'] == table['id']);
              if (index != -1) {
                _tables[index] = updatedTable;
              }
            });
            if (mounted) {
              Navigator.of(context).pop();
            }
          } catch (e) {
            if (mounted) {
              showErrorSnackBar(context, 'Failed to update table: $e');
            }
          }
        },
      ),
    );
  }

  void _showDeleteTableDialog(BuildContext context, Map<String, dynamic> table) async {
    final authState = ref.read(authProvider);
    final businessId = authState.currentBusinessId;
    if (businessId == null) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Table'),
        content: Text('Are you sure you want to delete "Table ${table['number']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              try {
                final entityService = ref.read(entityServiceProvider(businessId));
                final tableId = table['id'] as String;
                // Use generic delete() - TableLocalRepository.execute() handles list manipulation
                await entityService.delete('table', tableId);
                setState(() {
                  _tables.removeWhere((t) => t['id'] == table['id']);
                });
                if (mounted) {
                  Navigator.of(context).pop();
                }
              } catch (e) {
                if (mounted) {
                  showErrorSnackBar(context, 'Failed to delete table: $e');
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

class _TableCard extends StatelessWidget {
  final Map<String, dynamic> table;
  final bool isAvailable;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const _TableCard({
    required this.table,
    required this.isAvailable,
    this.onEdit,
    this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      child: Stack(
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isAvailable
                      ? Theme.of(context).colorScheme.primary
                      : Colors.red,
                  width: 2,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.table_restaurant,
                      size: 32,
                      color: isAvailable
                          ? Theme.of(context).colorScheme.primary
                          : Colors.red,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Table ${table['number']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isAvailable
                            ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                            : Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        isAvailable ? 'Available' : 'Occupied',
                        style: TextStyle(
                          fontSize: 12,
                          color: isAvailable
                              ? Theme.of(context).colorScheme.primary
                              : Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
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
}

/// Dialog for adding/editing tables
class _TableDialog extends StatefulWidget {
  final String tableLabel;
  final Map<String, dynamic>? table;
  final Function(Map<String, dynamic>) onSave;

  const _TableDialog({
    required this.tableLabel,
    this.table,
    required this.onSave,
  });

  @override
  State<_TableDialog> createState() => _TableDialogState();
}

class _TableDialogState extends State<_TableDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _numberController;
  late TextEditingController _capacityController;
  String _status = 'available';

  @override
  void initState() {
    super.initState();
    _numberController = TextEditingController(text: widget.table?['number'] ?? '');
    _capacityController = TextEditingController(text: widget.table?['capacity']?.toString() ?? '4');
    _status = widget.table?['status'] ?? 'available';
  }

  @override
  void dispose() {
    _numberController.dispose();
    _capacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.table != null;

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
                    isEdit ? 'Edit ${widget.tableLabel}' : 'Add ${widget.tableLabel}',
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
              // Number field
              TextFormField(
                controller: _numberController,
                decoration: InputDecoration(
                  labelText: '${widget.tableLabel} Number *',
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a table number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Capacity field
              TextFormField(
                controller: _capacityController,
                decoration: const InputDecoration(
                  labelText: 'Capacity *',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a capacity';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Status dropdown
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'available', child: Text('Available')),
                  DropdownMenuItem(value: 'occupied', child: Text('Occupied')),
                  DropdownMenuItem(value: 'reserved', child: Text('Reserved')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _status = value;
                    });
                  }
                },
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
                        final table = {
                          'id': widget.table?['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
                          'number': _numberController.text,
                          'capacity': int.parse(_capacityController.text),
                          'status': _status,
                        };
                        widget.onSave(table);
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
}
