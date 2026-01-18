/// Staff model representing a staff member
class Staff {
  final String id;
  final String name;
  final String role;
  final bool isActive;

  Staff({
    required this.id,
    required this.name,
    required this.role,
    this.isActive = true,
  });
}
