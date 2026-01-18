import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/pos/business_switcher.dart';
import '../models/pos/ticket.dart';
import '../models/pos/staff.dart';
import '../models/pos/table.dart';
import '../services/ticket_service.dart';

/// POS State containing all POS-related data
class POSState {
  final BusinessType businessType;
  final List<Ticket> tickets;
  final Ticket? currentTicket;
  final List<Staff> staff;
  final List<Table> tables;

  POSState({
    this.businessType = BusinessType.salon,
    List<Ticket>? tickets,
    this.currentTicket,
    List<Staff>? staff,
    List<Table>? tables,
  })  : tickets = tickets ?? [],
        staff = staff ?? [],
        tables = tables ?? [];

  POSState copyWith({
    BusinessType? businessType,
    List<Ticket>? tickets,
    Ticket? Function()? currentTicket,
    List<Staff>? staff,
    List<Table>? tables,
  }) {
    return POSState(
      businessType: businessType ?? this.businessType,
      tickets: tickets ?? this.tickets,
      currentTicket: currentTicket != null ? currentTicket() : this.currentTicket,
      staff: staff ?? this.staff,
      tables: tables ?? this.tables,
    );
  }
}

/// POS Notifier managing POS state
class POSNotifier extends StateNotifier<POSState> {
  POSNotifier() : super(POSState()) {
    _initializeMockData();
  }

  void _initializeMockData() {
    // Mock staff
    final mockStaff = [
      Staff(id: '1', name: 'John Doe', role: 'Stylist', isActive: true),
      Staff(id: '2', name: 'Jane Smith', role: 'Colorist', isActive: true),
      Staff(id: '3', name: 'Bob Johnson', role: 'Manager', isActive: false),
      Staff(id: '4', name: 'Alice Brown', role: 'Stylist', isActive: true),
      Staff(id: '5', name: 'Charlie Wilson', role: 'Assistant', isActive: true),
    ];

    // Mock tables
    final mockTables = List.generate(12, (index) {
      return Table(
        id: '${index + 1}',
        number: '${index + 1}',
        capacity: 4,
        status: index % 3 == 0 ? 'occupied' : 'available',
      );
    });

    state = state.copyWith(
      staff: mockStaff,
      tables: mockTables,
    );
  }

  void setBusinessType(BusinessType type) {
    state = state.copyWith(businessType: type);
  }

  Ticket? createTicket() {
    // Check for ghost order
    final lastTicket = TicketService.getLastTicket(state.tickets);
    if (TicketService.isGhostOrder(lastTicket)) {
      return null; // Prevent creating new ticket if ghost order exists
    }

    final newTicket = Ticket(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      orderNumber: TicketService.generateOrderNumber(),
      items: [],
    );

    state = state.copyWith(
      tickets: [...state.tickets, newTicket],
      currentTicket: () => newTicket,
    );

    return newTicket;
  }

  void assignStaffToTicket(String ticketId, Staff staff) {
    final tickets = state.tickets.map((t) {
      if (t.id == ticketId) {
        return t.copyWith(assigneeId: staff.id);
      }
      return t;
    }).toList();

    final currentTicket = state.currentTicket?.id == ticketId
        ? state.currentTicket?.copyWith(assigneeId: staff.id)
        : state.currentTicket;

    state = state.copyWith(
      tickets: tickets,
      currentTicket: () => currentTicket,
    );
  }

  void assignTableToTicket(String ticketId, String tableNumber) {
    final tickets = state.tickets.map((t) {
      if (t.id == ticketId) {
        return t.copyWith(tableNumber: tableNumber);
      }
      return t;
    }).toList();

    final currentTicket = state.currentTicket?.id == ticketId
        ? state.currentTicket?.copyWith(tableNumber: tableNumber)
        : state.currentTicket;

    state = state.copyWith(
      tickets: tickets,
      currentTicket: () => currentTicket,
    );
  }

  void addItemToTicket(String ticketId, TicketItem item) {
    final tickets = state.tickets.map((t) {
      if (t.id == ticketId) {
        // Check if item already exists, then update quantity
        final existingItemIndex = t.items.indexWhere((i) => i.productId == item.productId);
        if (existingItemIndex != -1) {
          final updatedItems = List<TicketItem>.from(t.items);
          updatedItems[existingItemIndex] = updatedItems[existingItemIndex].copyWith(
            quantity: updatedItems[existingItemIndex].quantity + item.quantity,
          );
          return t.copyWith(items: updatedItems);
        } else {
          return t.copyWith(items: [...t.items, item]);
        }
      }
      return t;
    }).toList();

    final currentTicket = state.currentTicket?.id == ticketId
        ? tickets.firstWhere((t) => t.id == ticketId)
        : state.currentTicket;

    state = state.copyWith(
      tickets: tickets,
      currentTicket: () => currentTicket,
    );
  }

  void removeItemFromTicket(String ticketId, String itemId) {
    final tickets = state.tickets.map((t) {
      if (t.id == ticketId) {
        return t.copyWith(items: t.items.where((i) => i.id != itemId).toList());
      }
      return t;
    }).toList();

    final currentTicket = state.currentTicket?.id == ticketId
        ? state.currentTicket?.copyWith(
            items: state.currentTicket!.items.where((i) => i.id != itemId).toList())
        : state.currentTicket;

    state = state.copyWith(
      tickets: tickets,
      currentTicket: () => currentTicket,
    );
  }

  void updateItemQuantity(String ticketId, String itemId, int quantity) {
    if (quantity <= 0) {
      removeItemFromTicket(ticketId, itemId);
      return;
    }

    final tickets = state.tickets.map((t) {
      if (t.id == ticketId) {
        return t.copyWith(
          items: t.items.map((i) {
            if (i.id == itemId) {
              return i.copyWith(quantity: quantity);
            }
            return i;
          }).toList(),
        );
      }
      return t;
    }).toList();

    final currentTicket = state.currentTicket?.id == ticketId
        ? state.currentTicket?.copyWith(
            items: state.currentTicket!.items.map((i) {
              if (i.id == itemId) {
                return i.copyWith(quantity: quantity);
              }
              return i;
            }).toList())
        : state.currentTicket;

      state = state.copyWith(
      tickets: tickets,
      currentTicket: () => currentTicket,
    );
  }

  void updateItemDiscount(String ticketId, String itemId, double discount) {
    // Clamp discount between 0.0 and 1.0 (0% to 100%)
    final clampedDiscount = discount.clamp(0.0, 1.0);

    final tickets = state.tickets.map((t) {
      if (t.id == ticketId) {
        return t.copyWith(
          items: t.items.map((i) {
            if (i.id == itemId) {
              return i.copyWith(discount: clampedDiscount);
            }
            return i;
          }).toList(),
        );
      }
      return t;
    }).toList();

    final currentTicket = state.currentTicket?.id == ticketId
        ? state.currentTicket?.copyWith(
            items: state.currentTicket!.items.map((i) {
              if (i.id == itemId) {
                return i.copyWith(discount: clampedDiscount);
              }
              return i;
            }).toList())
        : state.currentTicket;

      state = state.copyWith(
      tickets: tickets,
      currentTicket: () => currentTicket,
    );
  }

  void setCurrentTicket(String ticketId) {
    if (ticketId.isEmpty) {
      // Clear current ticket
      state = state.copyWith(currentTicket: () => null);
      return;
    }
    final ticket = state.tickets.firstWhere(
      (t) => t.id == ticketId,
      orElse: () => throw Exception('Ticket not found'),
    );
    state = state.copyWith(currentTicket: () => ticket);
  }

  void selectTicketByStaff(String staffId) {
    // Find the first active ticket assigned to this staff
    try {
      final ticket = state.tickets.firstWhere(
        (t) => t.assigneeId == staffId && t.statusOrDefault != 'paid',
      );
      state = state.copyWith(currentTicket: () => ticket);
    } catch (_) {
      // No ticket found for this staff, clear current ticket
      state = state.copyWith(currentTicket: () => null);
    }
  }

  void selectTicketByTable(String tableNumber) {
    // Find the first active ticket assigned to this table
    try {
      final ticket = state.tickets.firstWhere(
        (t) => t.tableNumber == tableNumber && t.statusOrDefault != 'paid',
      );
      state = state.copyWith(currentTicket: () => ticket);
    } catch (_) {
      // No ticket found for this table, clear current ticket
      state = state.copyWith(currentTicket: () => null);
    }
  }

  void closeTicketAsPaid(String ticketId) {
    final tickets = state.tickets.map((t) {
      if (t.id == ticketId) {
        return t.copyWith(status: 'paid');
      }
      return t;
    }).toList();

    // Clear current ticket if it's the one being closed
    final currentTicket = state.currentTicket?.id == ticketId
        ? null
        : state.currentTicket;

    state = state.copyWith(
      tickets: tickets,
      currentTicket: () => currentTicket,
    );
  }

  void deleteTicket(String ticketId) {
    final tickets = state.tickets.where((t) => t.id != ticketId).toList();

    // Clear current ticket if it's the one being deleted
    final currentTicket = state.currentTicket?.id == ticketId
        ? null
        : state.currentTicket;

    state = state.copyWith(
      tickets: tickets,
      currentTicket: () => currentTicket,
    );
  }
}

final posProvider = StateNotifierProvider<POSNotifier, POSState>((ref) {
  return POSNotifier();
});
