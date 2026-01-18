import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../theme/pos_theme.dart';
import '../../../providers/edit_mode_provider.dart';
import '../../../providers/pos_provider.dart';
import '../../../models/pos/ticket.dart';

/// Products tab
class ProductsTab extends ConsumerStatefulWidget {
  const ProductsTab({super.key});

  @override
  ConsumerState<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends ConsumerState<ProductsTab> {
  String _searchQuery = '';
  String? _selectedCategory;

  // Mock data - will be replaced with actual data from backend
  final List<Map<String, dynamic>> _categories = [
    {'id': '1', 'name': 'All'},
    {'id': '2', 'name': 'Haircuts'},
    {'id': '3', 'name': 'Color'},
    {'id': '4', 'name': 'Styling'},
  ];

    final List<Map<String, dynamic>> _products = [
      {
        'id': '1',
        'name': 'Haircut',
        'price': 25.00,
        'category': 'Haircuts',
        'duration': 30,
        'image': null, // Can be replaced with image URL
      },
      {
        'id': '2',
        'name': 'Hair Color',
        'price': 75.00,
        'category': 'Color',
        'duration': 120,
        'image': null,
      },
      {
        'id': '3',
        'name': 'Blow Dry',
        'price': 35.00,
        'category': 'Styling',
        'duration': 45,
        'image': null,
      },
      {
        'id': '4',
        'name': 'Hair Mask',
        'price': 15.00,
        'category': 'Add-ons',
        'duration': 15,
        'image': null,
      },
      {
        'id': '5',
        'name': 'Deep Conditioning',
        'price': 20.00,
        'category': 'Add-ons',
        'duration': 20,
        'image': null,
      },
    ];

  List<Map<String, dynamic>> get _filteredProducts {
    return _products.where((product) {
      final category = product['category']?.toString().toLowerCase() ?? '';
      final isAddOn = category == 'add-ons';
      // Exclude add-ons from regular products
      if (isAddOn) return false;
      
      final matchesSearch = product['name']
          .toString()
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == null ||
          _selectedCategory == 'All' ||
          product['category'] == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  List<Map<String, dynamic>> get _filteredAddOns {
    return _products.where((product) {
      final category = product['category']?.toString().toLowerCase() ?? '';
      final isAddOn = category == 'add-ons';
      // Only include add-ons
      if (!isAddOn) return false;
      
      final matchesSearch = product['name']
          .toString()
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
      return matchesSearch;
    }).toList();
  }

  void _addProductToTicket(String ticketId, Map<String, dynamic> product) {
    final ticketItem = TicketItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      productId: product['id'] as String,
      name: product['name'] as String,
      price: product['price'] as double,
      quantity: 1,
    );
    
    ref.read(posProvider.notifier).addItemToTicket(ticketId, ticketItem);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final editMode = ref.watch(editModeProvider);

    return Column(
      children: [
        // Header with search and add button
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF383838) : const Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      prefixIcon: const Icon(Icons.search, size: 20),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      hintStyle: TextStyle(
                        color: isDark 
                            ? const Color(0xFFA3A3A3) 
                            : const Color(0xFF737373),
                      ),
                    ),
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              if (editMode) ...[
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    _showAddProductDialog(context);
                  },
                  icon: const Icon(Icons.add, size: 20),
                  label: const Text('Add Product'),
                ),
              ],
            ],
          ),
        ),

        // Category Pills
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _CategoryChip(
                label: 'All',
                isSelected: _selectedCategory == null || _selectedCategory == 'All',
                onTap: () {
                  setState(() {
                    _selectedCategory = 'All';
                  });
                },
              ),
              ..._categories
                  .where((c) => c['name'] != 'All')
                  .map((category) => _CategoryChip(
                        label: category['name'] as String,
                        isSelected: _selectedCategory == category['name'],
                        onTap: () {
                          setState(() {
                            _selectedCategory = category['name'] as String;
                          });
                        },
                      )),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Products and Add-ons Grid (shared scroll)
        Expanded(
          child: CustomScrollView(
            slivers: [
              // Products Grid
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = _filteredProducts[index];
                      return _ProductCard(
                        product: product,
                        onEdit: editMode ? () => _showEditProductDialog(context, product) : null,
                        onDelete: editMode ? () => _showDeleteProductDialog(context, product) : null,
                        onAddToOrder: () {
                          final posState = ref.read(posProvider);
                          final currentTicket = posState.currentTicket;
                          
                          if (currentTicket == null) {
                            // Create a new ticket if none exists
                            final newTicket = ref.read(posProvider.notifier).createTicket();
                            if (newTicket != null) {
                              _addProductToTicket(newTicket.id, product);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please complete or clear the current empty order before adding products.'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }
                          } else {
                            _addProductToTicket(currentTicket.id, product);
                          }
                        },
                      );
                    },
                    childCount: _filteredProducts.length,
                  ),
                ),
              ),
              
              // Divider
              if (_filteredAddOns.isNotEmpty)
                SliverToBoxAdapter(
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: isDark ? const Color(0xFF404040) : const Color(0xFFE6E6E6),
                  ),
                ),
              
              // Add-ons Title
              if (_filteredAddOns.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                    child: Text(
                      'Add-ons',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              
              // Add-ons Grid
              if (_filteredAddOns.isNotEmpty)
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      childAspectRatio: 0.85,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final addOn = _filteredAddOns[index];
                        return _ProductCard(
                          product: addOn,
                          onEdit: editMode ? () => _showEditProductDialog(context, addOn) : null,
                          onDelete: editMode ? () => _showDeleteProductDialog(context, addOn) : null,
                          onAddToOrder: () {
                            final posState = ref.read(posProvider);
                            final currentTicket = posState.currentTicket;
                            
                            if (currentTicket == null) {
                              // Create a new ticket if none exists
                              final newTicket = ref.read(posProvider.notifier).createTicket();
                              if (newTicket != null) {
                                _addProductToTicket(newTicket.id, addOn);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please complete or clear the current empty order before adding products.'),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              }
                            } else {
                              _addProductToTicket(currentTicket.id, addOn);
                            }
                          },
                        );
                      },
                      childCount: _filteredAddOns.length,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  void _showAddProductDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _ProductDialog(
        onSave: (product) {
          setState(() {
            _products.add(product);
          });
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _showEditProductDialog(BuildContext context, Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) => _ProductDialog(
        product: product,
        onSave: (updatedProduct) {
          setState(() {
            final index = _products.indexWhere((p) => p['id'] == product['id']);
            if (index != -1) {
              _products[index] = updatedProduct;
            }
          });
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _showDeleteProductDialog(BuildContext context, Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: Text('Are you sure you want to delete "${product['name']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _products.removeWhere((p) => p['id'] == product['id']);
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

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : (isDark ? const Color(0xFF383838) : const Color(0xFFF2F2F2)),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : (isDark ? const Color(0xFF404040) : const Color(0xFFE6E6E6)),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : (isDark ? const Color(0xFFD9D9D9) : const Color(0xFF262626)),
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onAddToOrder;

  const _ProductCard({
    required this.product,
    this.onEdit,
    this.onDelete,
    this.onAddToOrder,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final price = product['price'] as double;
    final duration = product['duration'] as int?;
    final imageUrl = product['image'] as String?;

    return Card(
      child: InkWell(
        onTap: onAddToOrder,
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image placeholder
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isDark 
                            ? const Color(0xFF383838) 
                            : const Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: imageUrl != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return _buildImagePlaceholder(context, isDark);
                                },
                              ),
                            )
                          : _buildImagePlaceholder(context, isDark),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Product name
                  Text(
                    product['name'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Category badge
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
                      product['category'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark 
                            ? const Color(0xFFA3A3A3) 
                            : const Color(0xFF737373),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Price and duration
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      if (duration != null)
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 14,
                              color: isDark 
                                  ? const Color(0xFFA3A3A3) 
                                  : const Color(0xFF737373),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${duration}m',
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark 
                                    ? const Color(0xFFA3A3A3) 
                                    : const Color(0xFF737373),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
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
                            child: Icon(
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
      ),
    );
  }

  Widget _buildImagePlaceholder(BuildContext context, bool isDark) {
    return Center(
      child: Icon(
        Icons.image,
        size: 40,
        color: isDark 
            ? const Color(0xFF737373) 
            : const Color(0xFF9CA3AF),
      ),
    );
  }
}

class _AddOnCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final bool isDark;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onAddToOrder;

  const _AddOnCard({
    required this.product,
    required this.isDark,
    this.onEdit,
    this.onDelete,
    this.onAddToOrder,
  });

  @override
  Widget build(BuildContext context) {
    final price = product['price'] as double;
    final imageUrl = product['image'] as String?;

    return Card(
      child: InkWell(
        onTap: onAddToOrder,
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Image placeholder - fixed height for horizontal scroll
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDark 
                          ? const Color(0xFF383838) 
                          : const Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: imageUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Icon(
                                    Icons.image,
                                    size: 24,
                                    color: isDark 
                                        ? const Color(0xFF737373) 
                                        : const Color(0xFF9CA3AF),
                                  ),
                                );
                              },
                            ),
                          )
                        : Center(
                            child: Icon(
                              Icons.image,
                              size: 24,
                              color: isDark 
                                  ? const Color(0xFF737373) 
                                  : const Color(0xFF9CA3AF),
                            ),
                          ),
                  ),
                  const SizedBox(height: 6),
                  // Product name
                  Text(
                    product['name'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Price
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            if (onEdit != null || onDelete != null)
              Positioned(
                top: 4,
                right: 4,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (onEdit != null)
                      GestureDetector(
                        onTap: onEdit,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: isDark ? Colors.black54 : Colors.white70,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.edit,
                            size: 14,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    if (onDelete != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: GestureDetector(
                          onTap: onDelete,
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: isDark ? Colors.black54 : Colors.white70,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.close,
                              size: 14,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Dialog for adding/editing products
class _ProductDialog extends StatefulWidget {
  final Map<String, dynamic>? product;
  final Function(Map<String, dynamic>) onSave;

  const _ProductDialog({
    this.product,
    required this.onSave,
  });

  @override
  State<_ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<_ProductDialog> {
  final _formKey = GlobalKey<FormState>();
  final _imagePicker = ImagePicker();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _categoryController;
  late TextEditingController _durationController;
  String? _selectedCategory;
  File? _selectedImage;
  String? _imageUrl; // For existing image URL

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product?['name'] ?? '');
    _priceController = TextEditingController(text: widget.product?['price']?.toString() ?? '');
    _categoryController = TextEditingController(text: widget.product?['category'] ?? '');
    _durationController = TextEditingController(text: widget.product?['duration']?.toString() ?? '');
    _selectedCategory = widget.product?['category'];
    _imageUrl = widget.product?['image'] as String?;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _imageUrl = null; // Clear URL when new image is selected
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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isEdit = widget.product != null;

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
                    isEdit ? 'Edit Product' : 'Add Product',
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
              // Image upload section
              Text(
                'Product Image',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF383838) : const Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isDark ? const Color(0xFF404040) : const Color(0xFFE6E6E6),
                    ),
                  ),
                  child: _selectedImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : _imageUrl != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                _imageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return _buildImagePlaceholder(context, isDark);
                                },
                              ),
                            )
                          : _buildImagePlaceholder(context, isDark),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.upload, size: 18),
                  label: Text(_selectedImage != null || _imageUrl != null 
                      ? 'Change Image' 
                      : 'Upload Image'),
                ),
              ),
              const SizedBox(height: 24),
              // Name field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Product Name *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Price field
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Price *',
                  border: OutlineInputBorder(),
                  prefixText: '\$ ',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Category field
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(
                  labelText: 'Category *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Duration field (optional)
              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(
                  labelText: 'Duration (minutes)',
                  border: OutlineInputBorder(),
                  helperText: 'Optional - for services',
                ),
                keyboardType: TextInputType.number,
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
                        final product = {
                          'id': widget.product?['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
                          'name': _nameController.text,
                          'price': double.parse(_priceController.text),
                          'category': _categoryController.text,
                          'duration': _durationController.text.isNotEmpty 
                              ? int.tryParse(_durationController.text) 
                              : null,
                          'image': _selectedImage != null 
                              ? _selectedImage!.path // In real app, upload to server and get URL
                              : _imageUrl,
                        };
                        widget.onSave(product);
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

  Widget _buildImagePlaceholder(BuildContext context, bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image,
            size: 48,
            color: isDark 
                ? const Color(0xFF737373) 
                : const Color(0xFF9CA3AF),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap to upload image',
            style: TextStyle(
              fontSize: 12,
              color: isDark 
                  ? const Color(0xFF737373) 
                  : const Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }
}
