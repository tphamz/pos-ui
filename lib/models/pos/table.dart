/// Table model representing a table/station/register
class Table {
  final String id;
  final String number;
  final int capacity;
  final String status;

  Table({
    required this.id,
    required this.number,
    required this.capacity,
    this.status = 'available',
  });
}
