class FormValidators {
  static String? fullNameValidator(String? value) {
    if (value == null || value.isEmpty) return "Please enter child's full name";

    final nameRegex = RegExp(r'^[a-zA-Z0-9 ]+$');
    if (!nameRegex.hasMatch(value)) {
      return "Full name must be alphanumeric only";
    }
    return null;
  }

  static String? nhiNumberValidator(String? value) {
    if (value == null || value.isEmpty) return "Please enter NHI number";

    final nhiRegex = RegExp(r'^[A-Z]{3}[0-9]{4}$');
    if (!nhiRegex.hasMatch(value)) {
      return "NHI number must be 3 uppercase letters followed by 4 digits (e.g. ABC1234)";
    }
    return null;
  }

  static String? futureDateValidator(String? value) {
    if (value == null || value.isEmpty) return "Please enter the date";

    final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    if (!dateRegex.hasMatch(value)) {
      return "Date must be in yyyy-mm-dd format";
    }

    try {
      final inputDate = DateTime.parse(value);
      final today = DateTime.now();
      if (!inputDate.isAfter(today)) {
        return "Date must be a future date";
      }
    } catch (e) {
      return "Invalid date format";
    }

    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) return "Please enter email address";

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return "Please enter a valid email address";
    }
    return null;
  }
}
