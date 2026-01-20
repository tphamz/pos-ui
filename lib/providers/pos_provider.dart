import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/pos/business_switcher.dart';
import '../models/pos/ticket.dart';
import '../models/pos/staff.dart';
import '../models/pos/table.dart';
import '../services/ticket_service.dart';
import 'entity_providers.dart';
import 'auth_provider.dart';

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
  final Ref _ref;

  POSNotifier(this._ref) : super(POSState()) {
    _loadTickets();
    _loadStaff();
  }

  /// Load tickets from local DB on init
  Future<void> _loadTickets() async {
    final authState = _ref.read(authProvider);
    final businessId = authState.currentBusinessId;
    
    if (businessId == null) {
      // No business ID available yet, tickets will be empty
      return;
    }

    try {
      final entityService = _ref.read(entityServiceProvider(businessId));
      final ticketsData = await entityService.get('ticket');
      final tickets = ticketsData.map((data) => Ticket.fromJson(data)).toList();
      
      // Always update state, even if empty (to clear old data after restore)
      state = state.copyWith(tickets: tickets);
    } catch (e) {
      // Silently fail - will work with in-memory tickets
      print('Error loading tickets from local DB: $e');
    }
  }

  /// Load staff from local DB on init
  Future<void> _loadStaff() async {
    final authState = _ref.read(authProvider);
    final businessId = authState.currentBusinessId;
    
    if (businessId == null) {
      // No business ID available yet, staff will be empty
      return;
    }

    try {
      final entityService = _ref.read(entityServiceProvider(businessId));
      final staffData = await entityService.get('staff');
      final staff = staffData.map((data) {
        return Staff(
          id: data['id'] as String,
          fullName: data['full_name'] as String? ?? data['name'] as String? ?? '',
          role: data['role'] as String? ?? 'staff',
          isActive: data['is_active'] as bool? ?? data['isActive'] as bool? ?? true,
        );
      }).toList();
      
      // Always update state, even if empty (to clear old data after restore)
      state = state.copyWith(staff: staff);
    } catch (e) {
      // Silently fail - will work with empty staff list
      print('Error loading staff from local DB: $e');
    }
  }

  /// Refresh all data from local DB (called after restore/sync)
  Future<void> refresh() async {
    await Future.wait([
      _loadTickets(),
      _loadStaff(),
    ]);
  }

  /// Helper to save ticket to local DB
  Future<void> _saveTicketToLocalDB(Ticket ticket, {bool isCreate = false}) async {
    final authState = _ref.read(authProvider);
    final businessId = authState.currentBusinessId;
    
    if (businessId == null) {
      // No business ID available, skip saving
      return;
    }

    try {
      final entityService = _ref.read(entityServiceProvider(businessId));
      await entityService.save(
        resourceName: 'ticket',
        id: ticket.id,
        data: ticket.toJson(),
        isCreate: isCreate,
      );
    } catch (e) {
      // Silently fail - offline saving is best effort
      print('Error saving ticket to local DB: $e');
    }
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

    // Save to local DB asynchronously (non-blocking)
    _saveTicketToLocalDB(newTicket, isCreate: true);

    return newTicket;
  }

  void assignStaffToTicket(String ticketId, Staff staff) {
    final tickets = state.tickets.map((t) {
      if (t.id == ticketId) {
        final updated = t.copyWith(assigneeId: staff.id);
        // Save to local DB asynchronously (non-blocking)
        _saveTicketToLocalDB(updated, isCreate: false);
        return updated;
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
        final updated = t.copyWith(tableNumber: tableNumber);
        // Save to local DB asynchronously (non-blocking)
        _saveTicketToLocalDB(updated, isCreate: false);
        return updated;
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
        Ticket updated;
        if (existingItemIndex != -1) {
          final updatedItems = List<TicketItem>.from(t.items);
          updatedItems[existingItemIndex] = updatedItems[existingItemIndex].copyWith(
            quantity: updatedItems[existingItemIndex].quantity + item.quantity,
          );
          updated = t.copyWith(items: updatedItems);
        } else {
          updated = t.copyWith(items: [...t.items, item]);
        }
        // Save to local DB asynchronously (non-blocking)
        _saveTicketToLocalDB(updated, isCreate: false);
        return updated;
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
        final updated = t.copyWith(items: t.items.where((i) => i.id != itemId).toList());
        // Save to local DB asynchronously (non-blocking)
        _saveTicketToLocalDB(updated, isCreate: false);
        return updated;
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
        final updated = t.copyWith(
          items: t.items.map((i) {
            if (i.id == itemId) {
              return i.copyWith(quantity: quantity);
            }
            return i;
          }).toList(),
        );
        // Save to local DB asynchronously (non-blocking)
        _saveTicketToLocalDB(updated, isCreate: false);
        return updated;
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
        final updated = t.copyWith(
          items: t.items.map((i) {
            if (i.id == itemId) {
              return i.copyWith(discount: clampedDiscount);
            }
            return i;
          }).toList(),
        );
        // Save to local DB asynchronously (non-blocking)
        _saveTicketToLocalDB(updated, isCreate: false);
        return updated;
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
        final updated = t.copyWith(status: 'paid');
        // Save to local DB asynchronously (non-blocking)
        _saveTicketToLocalDB(updated, isCreate: false);
        return updated;
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

  void deleteTicket(String ticketId) async {
    final authState = _ref.read(authProvider);
    final businessId = authState.currentBusinessId;

    // Delete from local DB asynchronously (non-blocking)
    if (businessId != null) {
      try {
        final entityService = _ref.read(entityServiceProvider(businessId));
        await entityService.delete('ticket', ticketId);
      } catch (e) {
        // Silently fail - offline deletion is best effort
        print('Error deleting ticket from local DB: $e');
      }
    }

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
  return POSNotifier(ref);
});
