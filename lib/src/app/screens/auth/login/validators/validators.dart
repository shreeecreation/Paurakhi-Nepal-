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
   static bool validateProductPrice(String input) {
    final RegExp regex =  RegExp(r'\d+(?:\.\d+)?');
    return regex.hasMatch(input);
  }
  static bool validateMinQty(String input) {
    final RegExp regex =  RegExp(r'\d+(?:\.\d+)?');
    return regex.hasMatch(input);
  }

  static bool isEmailValid(String email) {
    // email validation pattern
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }


   static bool validateNormalName(String input) {
    final RegExp regex = RegExp(r'^.{5,}$');
    return regex.hasMatch(input);
  }

}
