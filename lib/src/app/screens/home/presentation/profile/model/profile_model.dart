class ProfileModel {
  static String? userId;
  static String? role;
  static bool? twoFactor;
  static bool? verified;
  static String? phoneNumber;
}

class Profile {
  static String? firstName;
  static String? lastName;
  static String finalName = "${firstName!}  ${lastName!}";
  static String? email;
  static String? address;
  static String picture = "";
}
