class ValidationUtils {
  // Validate email format
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  // Validate phone number (E.164 format: +1234567890)
  static bool isValidPhoneNumber(String phone) {
    final phoneRegex = RegExp(r'^\+[1-9]\d{1,14}$');
    return phoneRegex.hasMatch(phone);
  }

  // Alias for isValidPhoneNumber
  static bool isValidPhone(String phone) {
    return isValidPhoneNumber(phone);
  }

  // Validate contact (either email or phone)
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
