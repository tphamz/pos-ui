class ValidationUtils {
  // Validate email format
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  // Normalize phone number to E.164 format
  // If a 10-digit US number is provided (without country code), automatically prepends +1
  // Examples:
  //   - "1234567890" -> "+11234567890"
  //   - "+11234567890" -> "+11234567890" (already normalized)
  //   - "11234567890" -> "+11234567890"
  static String normalizePhoneNumber(String phone) {
    if (phone.isEmpty) return phone;

    // If it contains @, it's likely an email - don't normalize
    if (phone.contains('@')) return phone;

    // Remove whitespace, dashes, parentheses, and dots (common phone formatting)
    String normalized = phone.trim();
    normalized = normalized.replaceAll(RegExp(r'[\s\-\(\)\.]'), '');

    // If already in E.164 format, return as-is
    if (normalized.startsWith('+')) {
      return normalized;
    }

    // If it's a 10-digit number (US format), prepend +1
    if (RegExp(r'^\d{10}$').hasMatch(normalized)) {
      return '+1$normalized';
    }

    // If it's an 11-digit number starting with 1 (US format without +), prepend +
    if (RegExp(r'^1\d{10}$').hasMatch(normalized)) {
      return '+$normalized';
    }

    // Return original if we can't normalize it
    return phone;
  }

  // Validate phone number format
  // Accepts E.164 format: +[country code][number]
  // Also accepts 10-digit US numbers or 11-digit numbers starting with 1 (will be normalized)
  static bool isValidPhoneNumber(String phone) {
    if (phone.isEmpty) return false;

    // Normalize first to handle 10-digit and 11-digit formats
    final normalized = normalizePhoneNumber(phone);

    // Must start with + after normalization
    if (!normalized.startsWith('+')) return false;

    // E.164 format: +[1-15 digits]
    final phoneRegex = RegExp(r'^\+[1-9]\d{1,14}$');
    return phoneRegex.hasMatch(normalized);
  }

  // Alias for isValidPhoneNumber
  static bool isValidPhone(String phone) {
    return isValidPhoneNumber(phone);
  }

  // Validate contact (either email or phone)
  // Phone can be in various formats (10-digit, 11-digit, or E.164)
  static bool isValidContact(String contact) {
    return isValidEmail(contact) || isValidPhoneNumber(contact);
  }

  // Validate store code (1-50 characters, lowercase alphanumeric with hyphens)
  static bool isValidStoreCode(String storeCode) {
    final storeCodeRegex = RegExp(r'^[a-z0-9-]{1,50}$');
    return storeCodeRegex.hasMatch(storeCode);
  }

  // Validate OTP code (6 digits)
  static bool isValidOTPCode(String code) {
    final otpRegex = RegExp(r'^\d{6}$');
    return otpRegex.hasMatch(code);
  }
}
