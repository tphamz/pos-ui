import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../theme/pos_theme.dart';
import '../../../providers/edit_mode_provider.dart';
import '../../../providers/pos_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/blueprint_provider.dart';
import '../../../models/pos/ticket.dart';
import '../../../providers/entity_providers.dart';
import '../../../utils/snackbar_helper.dart';

/// Products tab
class ProductsTab extends ConsumerStatefulWidget {
  const ProductsTab({super.key});

  @override
  ConsumerState<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends ConsumerState<ProductsTab> {
  String _searchQuery = '';
  String? _selectedCategory;
  List<Map<String, dynamic>> _products = [];
  bool _isLoading = true;

  // Get unique categories from products (including "Add-ons")
  // "Add-ons" will always be the last item in the list
  List<String> get _categories {
    final categories = <String>{};
    String? addOnsCategory;
    
    for (final product in _products) {
      final category = product['category']?.toString();
      if (category != null && category.isNotEmpty) {
        final categoryLower = category.toLowerCase();
        if (categoryLower == 'add-ons' || categoryLower == 'add-ons') {
          // Store the original casing of "Add-ons"
          addOnsCategory = category;
        } else {
          categories.add(category);
        }
      }
    }
    
    final sortedCategories = categories.toList()..sort();
    
    // Add "Add-ons" at the end if it exists
    if (addOnsCategory != null) {
      sortedCategories.add(addOnsCategory);
    }
    
    return sortedCategories;
  }

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final authState = ref.read(authProvider);
    final businessId = authState.currentBusinessId;
    
    if (businessId == null) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _products = [];
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
      final products = await entityService.get('product');
      
      if (mounted) {
        setState(() {
          _products = products.isNotEmpty ? products : [];
          _isLoading = false;
        });
      }
    } catch (e) {
      // On error, use empty list
      if (mounted) {
        setState(() {
          _products = [];
          _isLoading = false;
        });
      }
    }
  }

  List<Map<String, dynamic>> get _filteredProducts {
    return _products.where((product) {
      final category = product['category']?.toString().toLowerCase() ?? '';
      final isAddOn = category == 'add-ons';
      
      // If "Add-ons" category is selected, only show add-ons
      if (_selectedCategory == 'Add-ons' || _selectedCategory == 'add-ons') {
        if (!isAddOn) return false;
      } else {
        // Otherwise, exclude add-ons from regular products (they'll show in separate section)
        if (isAddOn) return false;
      }
      
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
    // Don't show add-ons in separate section if "Add-ons" category is selected
    // (they'll be shown in the main grid instead)
    if (_selectedCategory == 'Add-ons' || _selectedCategory == 'add-ons') {
      return [];
    }
    
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
    // Use base_price (matches server response and local DB column)
    final priceValue = product['base_price'] ?? product['price']; // Fallback to price for backward compatibility
    final price = priceValue != null ? (priceValue as num).toDouble() : 0.0;
    final ticketItem = TicketItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      productId: product['id'] as String,
      name: product['name'] as String,
      price: price,
      quantity: 1,
    );
    
    ref.read(posProvider.notifier).addItemToTicket(ticketId, ticketItem);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final editMode = ref.watch(editModeProvider);
    
    // Get product label from blueprint
    final labelMappings = ref.watch(labelMappingsProvider);
    final productLabel = (labelMappings['products'] as String?) ?? 'Product';

    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

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
                  label: Text('Add $productLabel'),
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
              ..._categories.map((category) => _CategoryChip(
                    label: category,
                    isSelected: _selectedCategory == category,
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
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

  void _showAddProductDialog(BuildContext context) async {
    final authState = ref.read(authProvider);
    final businessId = authState.currentBusinessId;
    if (businessId == null) return;

    final labelMappings = ref.read(labelMappingsProvider);
    final productLabel = (labelMappings['products'] as String?) ?? 'Product';

    showDialog(
      context: context,
      builder: (context) => _ProductDialog(
        productLabel: productLabel,
        onSave: (product) async {
          try {
            final entityService = ref.read(entityServiceProvider(businessId));
            final savedProduct = await entityService.save(
              resourceName: 'product',
              id: product['id'] as String,
              data: product,
              isCreate: true,
            );
            setState(() {
              _products.add(savedProduct);
            });
            if (mounted) {
              Navigator.of(context).pop();
            }
          } catch (e) {
            if (mounted) {
              showErrorSnackBar(context, 'Failed to save product: $e');
            }
          }
        },
      ),
    );
  }

  void _showEditProductDialog(BuildContext context, Map<String, dynamic> product) async {
    final authState = ref.read(authProvider);
    final businessId = authState.currentBusinessId;
    if (businessId == null) return;

    final labelMappings = ref.read(labelMappingsProvider);
    final productLabel = (labelMappings['products'] as String?) ?? 'Product';

    showDialog(
      context: context,
      builder: (context) => _ProductDialog(
        productLabel: productLabel,
        product: product,
        onSave: (updatedProduct) async {
          try {
            final entityService = ref.read(entityServiceProvider(businessId));
            final savedProduct = await entityService.save(
              resourceName: 'product',
              id: product['id'] as String,
              data: updatedProduct,
              isCreate: false,
            );
            setState(() {
              final index = _products.indexWhere((p) => p['id'] == product['id']);
              if (index != -1) {
                _products[index] = savedProduct;
              }
            });
            if (mounted) {
              Navigator.of(context).pop();
            }
          } catch (e) {
            if (mounted) {
              showErrorSnackBar(context, 'Failed to update product: $e');
            }
          }
        },
      ),
    );
  }

  void _showDeleteProductDialog(BuildContext context, Map<String, dynamic> product) async {
    final authState = ref.read(authProvider);
    final businessId = authState.currentBusinessId;
    if (businessId == null) return;

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
            onPressed: () async {
              try {
                final entityService = ref.read(entityServiceProvider(businessId));
                await entityService.delete('product', product['id'] as String);
                setState(() {
                  _products.removeWhere((p) => p['id'] == product['id']);
                });
                if (mounted) {
                  Navigator.of(context).pop();
                }
              } catch (e) {
                if (mounted) {
                  showErrorSnackBar(context, 'Failed to delete product: $e');
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
    // Use base_price (matches server response and local DB column)
    final priceValue = product['base_price'] ?? product['price']; // Fallback to price for backward compatibility
    final price = priceValue != null ? (priceValue as num).toDouble() : 0.0;
    // Extract duration and image from metadata
    final metadata = product['metadata'] is Map<String, dynamic>
        ? product['metadata'] as Map<String, dynamic>
        : null;
    final duration = metadata?['duration_minutes'] as int?;
    final imageUrl = metadata?['image'] as String? ?? product['image'] as String?;

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
    // Use base_price (matches server response and local DB column)
    final priceValue = product['base_price'] ?? product['price']; // Fallback to price for backward compatibility
    final price = priceValue != null ? (priceValue as num).toDouble() : 0.0;
    // Extract image from metadata
    final metadata = product['metadata'] is Map<String, dynamic>
        ? product['metadata'] as Map<String, dynamic>
        : null;
    final imageUrl = metadata?['image'] as String? ?? product['image'] as String?;

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
  final String productLabel;
  final Map<String, dynamic>? product;
  final Future<void> Function(Map<String, dynamic>) onSave;

  const _ProductDialog({
    required this.productLabel,
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
  String? _errorMessage; // For sticky error display

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product?['name'] ?? '');
    _priceController = TextEditingController(text: (widget.product?['base_price'] ?? widget.product?['price'])?.toString() ?? '');
    _categoryController = TextEditingController(text: widget.product?['category'] ?? '');
    // Extract duration and image from metadata if present
    final metadataValue = widget.product?['metadata'];
    final metadata = metadataValue is Map<String, dynamic>
        ? metadataValue as Map<String, dynamic>
        : null;
    final durationFromMetadata = metadata?['duration_minutes'];
    _durationController = TextEditingController(text: durationFromMetadata?.toString() ?? '');
    _selectedCategory = widget.product?['category'];
    _imageUrl = metadata?['image'] as String? ?? widget.product?['image'] as String?;
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
        setState(() {
          _errorMessage = 'Error picking image: $e';
        });
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
                    isEdit ? 'Edit ${widget.productLabel}' : 'Add ${widget.productLabel}',
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
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () async {
                          // Clear any previous error
                          setState(() {
                            _errorMessage = null;
                          });
                          
                          if (_formKey.currentState!.validate()) {
                            try {
                              // Build metadata object with duration and image
                              final metadata = <String, dynamic>{};
                              if (_durationController.text.isNotEmpty) {
                                final duration = int.tryParse(_durationController.text);
                                if (duration != null) {
                                  metadata['duration_minutes'] = duration;
                                }
                              }
                              if (_selectedImage != null || _imageUrl != null) {
                                metadata['image'] = _selectedImage != null 
                                    ? _selectedImage!.path // In real app, upload to server and get URL
                                    : _imageUrl;
                              }
                              
                              final product = {
                                'id': widget.product?['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
                                'name': _nameController.text,
                                'price': double.parse(_priceController.text),
                                'category': _categoryController.text,
                                'metadata': metadata.isNotEmpty ? metadata : null,
                              };
                              
                              await widget.onSave(product);
                            } catch (e) {
                              if (mounted) {
                                setState(() {
                                  _errorMessage = 'Failed to save product: $e';
                                });
                              }
                            }
                          }
                        },
                        child: Text(isEdit ? 'Save' : 'Add'),
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
