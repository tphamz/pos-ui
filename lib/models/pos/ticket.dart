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

  /// Convert Ticket to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderNumber': orderNumber,
      'items': items.map((item) => item.toJson()).toList(),
      'assigneeId': assigneeId,
      'tableNumber': tableNumber,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
    };
  }

  /// Create Ticket from JSON
  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'] as String,
      orderNumber: json['orderNumber'] as String,
      items: (json['items'] as List<dynamic>?)
              ?.map((item) => TicketItem.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      assigneeId: json['assigneeId'] as String?,
      tableNumber: json['tableNumber'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      status: json['status'] as String?,
    );
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

  /// Convert TicketItem to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'discount': discount,
    };
  }

  /// Create TicketItem from JSON
  factory TicketItem.fromJson(Map<String, dynamic> json) {
    return TicketItem(
      id: json['id'] as String,
      productId: json['productId'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
