extension ExtString on String {
  static bool validatePhoneNumber(String input) {
    final RegExp regex = RegExp(r'^[0-9]{10}$');
    return regex.hasMatch(input);
  }

  static bool validatePassword(String input) {
    final RegExp regex = RegExp(r'^.{8,}$');
    return regex.hasMatch(input);
  }

  static bool validateFirstName(String input) {
    final RegExp regex = RegExp(r'^.{4,}$');
    return regex.hasMatch(input);
  }

  static bool validateSecondName(String input) {
    final RegExp regex = RegExp(r'^.{4,}$');
    return regex.hasMatch(input);
  }

  static bool isEmailValid(String email) {
    // email validation pattern
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }
}
