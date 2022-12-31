class Validator {
  static String? validateName(dynamic str) {
    if (str!.trim().isEmpty) {
      return 'Field cannot be empty';
    }
    return null;
  }

  static String? validateEmail(dynamic str) {
    if (str!.trim().isEmpty) {
      return 'Field cannot be empty';
    }
    return null;
  }

  static String? validateMobileNumber(dynamic str) {
    if (str!.trim().isEmpty) {
      return 'Field cannot be empty';
    }
    return null;
  }

  static String? validatePassword(dynamic str) {
    if (str!.trim().isEmpty) {
      return 'Field cannot be empty';
    }
    return null;
  }

  static String? validateConfirmPassword(String? str, String? secondStr) {
    final string = str!.trim();

    // print("second string is ${str.trim()}");
    if (string.isEmpty) {
      return 'Field cannot be empty';
    }

    if ((string != secondStr!.trim())) {
      // print("passwords are not equal");
      return 'passwords not equal';
    }

    return null;
  }
}
