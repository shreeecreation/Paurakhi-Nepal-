extension ExtString on String {
  static bool validatePhoneNumber(String input) {
    final RegExp regex = RegExp(r'^[0-9]{10}$');
    return regex.hasMatch(input);
  }

  static bool validatePassword(String input) {
    final RegExp regex = RegExp(r'^.{8,}$');
    return regex.hasMatch(input);
  }

  bool get isNotNull {
    return this != null;
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }
}
