/// Staff model representing a staff member
class Staff {
  final String id;
  final String fullName;
  final String role;
  final bool isActive;

  Staff({
    required this.id,
    required this.fullName,
    required this.role,
    this.isActive = true,
  });

  // Backward compatibility getter
  String get name => fullName;
}
