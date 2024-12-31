class FormValidator {
  static String? validateNotEmpty(String? value, {String fieldName = "This field"}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName cannot be empty";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    const emailRegex =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    if (value == null || value.trim().isEmpty) {
      return "Email cannot be empty";
    } else if (!RegExp(emailRegex).hasMatch(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  static String? validatePassword(String? value, {int minLength = 8}) {
    if (value == null || value.trim().isEmpty) {
      return "Password cannot be empty";
    } else if (value.length < minLength) {
      return "Password must be at least $minLength characters long";
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    const phoneRegex = r'^\+?[0-9]{10,15}$'; // Supports numbers with/without country codes
    if (value == null || value.trim().isEmpty) {
      return "Phone number cannot be empty";
    } else if (!RegExp(phoneRegex).hasMatch(value)) {
      return "Enter a valid phone number (10-15 digits)";
    }
    return null;
  }
}
