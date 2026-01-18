/// Ticket model representing an order/service ticket
class Ticket {
  final String id;
  final String orderNumber;
  final List<TicketItem> items;
  final String? assigneeId;
  final String? tableNumber;
  final DateTime createdAt;
  final String? status; // 'draft', 'active', 'paid', 'completed', etc.

  Ticket({
    required this.id,
    required this.orderNumber,
    required this.items,
    this.assigneeId,
    this.tableNumber,
    DateTime? createdAt,
    this.status,
  }) : createdAt = createdAt ?? DateTime.now();

  String get statusOrDefault => status ?? 'draft';

  Ticket copyWith({
    String? id,
    String? orderNumber,
    List<TicketItem>? items,
    String? assigneeId,
    String? tableNumber,
    DateTime? createdAt,
    String? status,
  }) {
    return Ticket(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      items: items ?? this.items,
      assigneeId: assigneeId ?? this.assigneeId,
      tableNumber: tableNumber ?? this.tableNumber,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }

  bool get isEmpty {
    return items.isEmpty && assigneeId == null && tableNumber == null;
  }
}

/// TicketItem model representing an item in a ticket
class TicketItem {
  final String id;
  final String productId;
  final String name;
  final double price;
  final int quantity;
  final double discount; // Discount as percentage (0.0 to 1.0, where 0.1 = 10%)

  TicketItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    this.discount = 0.0,
  });

  TicketItem copyWith({
    String? id,
    String? productId,
    String? name,
    double? price,
    int? quantity,
    double? discount,
  }) {
    return TicketItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      discount: discount ?? this.discount,
    );
  }

  double get discountedPrice {
    return price * (1 - discount);
  }

  double get totalPrice {
    return discountedPrice * quantity;
  }
}
