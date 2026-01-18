import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/pos_theme.dart';
import '../../providers/pos_provider.dart';
import '../../models/pos/ticket.dart';
import 'business_switcher.dart';

/// Right side ticket/order panel (320px width)
class TicketPanel extends ConsumerWidget {
  const TicketPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? const Color(0xFF404040) : const Color(0xFFE6E6E6);
    final posState = ref.watch(posProvider);
    final currentTicket = posState.currentTicket;

    final subtotal = currentTicket?.items.fold<double>(
          0.0,
          (sum, item) => sum + item.totalPrice,
        ) ??
        0.0;
    final tax = subtotal * 0.08; // 8% tax
    final total = subtotal + tax;

    void _handleNewTicket() {
      final newTicket = ref.read(posProvider.notifier).createTicket();
      if (newTicket == null) {
        // Ghost order detected
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please complete or clear the current empty order before creating a new one.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }

    void _showCloseTicketDialog(BuildContext context, Ticket ticket) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Close Ticket'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('How would you like to close ticket ${ticket.orderNumber}?'),
              const SizedBox(height: 16),
              const Text(
                'Select an option:',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                ref.read(posProvider.notifier).deleteTicket(ticket.id);
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete the ticket'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(posProvider.notifier).closeTicketAsPaid(ticket.id);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: POSTheme.getSuccessColor(isDark),
                foregroundColor: Colors.white,
              ),
              child: const Text('User already paid'),
            ),
          ],
        ),
      );
    }

    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF292929) : Colors.white,
        border: Border(
          left: BorderSide(color: borderColor),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: borderColor),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Current Ticket',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 32,
                        decoration: BoxDecoration(
                          color: isDark 
                              ? const Color(0xFF383838) 
                              : const Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: borderColor),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: currentTicket?.id,
                            isExpanded: true,
                            isDense: true,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            hint: const Text(
                              'Select ticket',
                              style: TextStyle(fontSize: 14),
                            ),
                            items: posState.tickets
                                .where((t) => t.statusOrDefault != 'paid') // Only active orders
                                .toList()
                                .reversed // Reverse so newest is on top
                                .map((ticket) {
                              return DropdownMenuItem<String>(
                                value: ticket.id,
                                child: Text(
                                  ticket.orderNumber,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              if (value != null) {
                                ref.read(posProvider.notifier).setCurrentTicket(value);
                              }
                            },
                            dropdownColor: isDark 
                                ? const Color(0xFF383838) 
                                : const Color(0xFFF2F2F2),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: _handleNewTicket,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      child: const Text('New'),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Assignment Section (table and staff dropdowns)
          if (currentTicket != null) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: borderColor),
                ),
              ),
              child: Column(
                children: [
                  // Staff Assignment
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 32), // Match icon width
                          const SizedBox(width: 12), // Match spacing
                          Expanded(
                            child: Text(
                              'Assignee',
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark 
                                    ? const Color(0xFFA3A3A3) 
                                    : const Color(0xFF737373),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: isDark 
                                  ? const Color(0xFF383838) 
                                  : const Color(0xFFF2F2F2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              Icons.person,
                              size: 16,
                              color: isDark 
                                  ? const Color(0xFFA3A3A3) 
                                  : const Color(0xFF737373),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              height: 32,
                              decoration: BoxDecoration(
                                color: isDark 
                                    ? const Color(0xFF383838) 
                                    : const Color(0xFFF2F2F2),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: borderColor),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: currentTicket.assigneeId,
                                  isExpanded: true,
                                  isDense: true,
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  hint: const Text(
                                    'Select staff',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  items: posState.staff
                                      .where((s) => s.isActive)
                                      .map((staff) {
                                    return DropdownMenuItem<String>(
                                      value: staff.id,
                                      child: Text(
                                        staff.name,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    if (value != null) {
                                      final staff = posState.staff.firstWhere((s) => s.id == value);
                                      ref.read(posProvider.notifier).assignStaffToTicket(
                                        currentTicket.id,
                                        staff,
                                      );
                                    }
                                  },
                                  dropdownColor: isDark 
                                      ? const Color(0xFF383838) 
                                      : const Color(0xFFF2F2F2),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Table Assignment (show for restaurant only)
                  if (posState.businessType == BusinessType.restaurant) ...[
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 32), // Match icon width
                            const SizedBox(width: 12), // Match spacing
                            Expanded(
                              child: Text(
                                'Table',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark 
                                      ? const Color(0xFFA3A3A3) 
                                      : const Color(0xFF737373),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: isDark 
                                    ? const Color(0xFF383838) 
                                    : const Color(0xFFF2F2F2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                Icons.table_restaurant,
                                size: 16,
                                color: isDark 
                                    ? const Color(0xFFA3A3A3) 
                                    : const Color(0xFF737373),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Container(
                                height: 32,
                                decoration: BoxDecoration(
                                  color: isDark 
                                      ? const Color(0xFF383838) 
                                      : const Color(0xFFF2F2F2),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: borderColor),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: currentTicket.tableNumber,
                                    isExpanded: true,
                                    isDense: true,
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    hint: const Text(
                                      'Select table',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    items: posState.tables.map((table) {
                                      return DropdownMenuItem<String>(
                                        value: table.number,
                                        child: Text(
                                          'Table ${table.number}',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      if (value != null) {
                                        ref.read(posProvider.notifier).assignTableToTicket(
                                          currentTicket.id,
                                          value,
                                        );
                                      }
                                    },
                                    dropdownColor: isDark 
                                        ? const Color(0xFF383838) 
                                        : const Color(0xFFF2F2F2),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                    ),
                  ],
                ],
              ),
            ),
          ],

          // Order Items
          Expanded(
            child: currentTicket == null || currentTicket.items.isEmpty
                ? _EmptyState(isDark: isDark)
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: currentTicket.items.length,
                    itemBuilder: (context, index) {
                      final item = currentTicket.items[index];
                      return _OrderItemCard(
                        item: item,
                        onQuantityChange: (newQuantity) {
                          ref.read(posProvider.notifier).updateItemQuantity(
                            currentTicket.id,
                            item.id,
                            newQuantity,
                          );
                        },
                        onDiscountChange: (discount) {
                          ref.read(posProvider.notifier).updateItemDiscount(
                            currentTicket.id,
                            item.id,
                            discount,
                          );
                        },
                        onRemove: () {
                          ref.read(posProvider.notifier).removeItemFromTicket(
                            currentTicket.id,
                            item.id,
                          );
                        },
                      );
                    },
                  ),
          ),

          // Footer - Totals
          if (currentTicket != null && currentTicket.items.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: borderColor),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subtotal',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark 
                              ? const Color(0xFFA3A3A3) 
                              : const Color(0xFF737373),
                        ),
                      ),
                      Text(
                        '\$${subtotal.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tax (8%)',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark 
                              ? const Color(0xFFA3A3A3) 
                              : const Color(0xFF737373),
                        ),
                      ),
                      Text(
                        '\$${tax.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${total.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Pay button - full width row
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Process payment
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: POSTheme.getSuccessColor(isDark),
                        foregroundColor: Colors.white,
                      ),
                      child: Text('Pay \$${total.toStringAsFixed(2)}'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Hold and Close buttons - second row
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // TODO: Hold order
                          },
                          child: const Text('Hold'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _showCloseTicketDialog(context, currentTicket!),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Close'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final bool isDark;

  const _EmptyState({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isDark 
                  ? const Color(0xFF383838) 
                  : const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(
              Icons.credit_card,
              size: 24,
              color: isDark 
                  ? const Color(0xFFA3A3A3) 
                  : const Color(0xFF737373),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'No items yet',
            style: TextStyle(
              fontSize: 14,
              color: isDark 
                  ? const Color(0xFFA3A3A3) 
                  : const Color(0xFF737373),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Select products to add to this ticket',
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

class _OrderItemCard extends ConsumerStatefulWidget {
  final TicketItem item;
  final Function(int) onQuantityChange;
  final Function(double) onDiscountChange;
  final VoidCallback onRemove;

  const _OrderItemCard({
    required this.item,
    required this.onQuantityChange,
    required this.onDiscountChange,
    required this.onRemove,
  });

  @override
  ConsumerState<_OrderItemCard> createState() => _OrderItemCardState();
}

class _OrderItemCardState extends ConsumerState<_OrderItemCard> {

  void _showDiscountDialog() {
    final discountPercent = (widget.item.discount * 100).round();
    final controller = TextEditingController(text: discountPercent.toString());
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Apply Discount'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Discount (%)',
                hintText: '0-100',
                suffixText: '%',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final discountValue = double.tryParse(controller.text);
              if (discountValue != null && discountValue >= 0 && discountValue <= 100) {
                widget.onDiscountChange(discountValue / 100);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final name = widget.item.name;
    final price = widget.item.price;
    final quantity = widget.item.quantity;
    final discount = widget.item.discount;
    final hasDiscount = discount > 0.0;
    final total = widget.item.totalPrice;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '\$${price.toStringAsFixed(2)} each',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark 
                                  ? const Color(0xFFA3A3A3) 
                                  : const Color(0xFF737373),
                            ),
                          ),
                          if (hasDiscount) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '-${(discount * 100).toStringAsFixed(0)}%',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.orange[700],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (hasDiscount)
                      Text(
                        '\$${(price * quantity).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark 
                              ? const Color(0xFFA3A3A3) 
                              : const Color(0xFF737373),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Text(
                      '\$${total.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: hasDiscount ? Colors.orange[700] : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, size: 20),
                        onPressed: () => widget.onQuantityChange(quantity - 1),
                        style: IconButton.styleFrom(
                          padding: const EdgeInsets.all(4),
                          minimumSize: const Size(28, 28),
                        ),
                      ),
                      SizedBox(
                        width: 32,
                        child: Text(
                          '$quantity',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, size: 20),
                        onPressed: () => widget.onQuantityChange(quantity + 1),
                        style: IconButton.styleFrom(
                          padding: const EdgeInsets.all(4),
                          minimumSize: const Size(28, 28),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        hasDiscount ? Icons.discount : Icons.discount_outlined,
                        size: 20,
                        color: hasDiscount ? Colors.orange[700] : null,
                      ),
                      onPressed: _showDiscountDialog,
                      tooltip: hasDiscount 
                          ? 'Discount: ${(discount * 100).toStringAsFixed(0)}%'
                          : 'Apply discount',
                      style: IconButton.styleFrom(
                        padding: const EdgeInsets.all(4),
                        minimumSize: const Size(28, 28),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, size: 20),
                      onPressed: widget.onRemove,
                      color: Colors.red,
                      style: IconButton.styleFrom(
                        padding: const EdgeInsets.all(4),
                        minimumSize: const Size(28, 28),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
