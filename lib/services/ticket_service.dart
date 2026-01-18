import '../models/pos/ticket.dart';

/// Service for ticket-related business logic
class TicketService {
  /// Generate a unique order number based on timestamp
  static String generateOrderNumber() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'ORD-${timestamp.toString().substring(5)}';
  }

  /// Check if a ticket is a "ghost order" (empty with no assignments)
  static bool isGhostOrder(Ticket? ticket) {
    if (ticket == null) return false;
    return ticket.isEmpty;
  }

  /// Get the last ticket from a list
  static Ticket? getLastTicket(List<Ticket> tickets) {
    if (tickets.isEmpty) return null;
    return tickets.last;
  }
}
