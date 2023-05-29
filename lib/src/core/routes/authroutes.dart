import 'package:get/get.dart';
import 'package:paurakhi/src/app/screens/auth/forgot/forgot_screen.dart';
import 'package:paurakhi/src/app/screens/auth/login/google_login.dart';
import 'package:paurakhi/src/app/screens/auth/login/login_screen.dart';
import 'package:paurakhi/src/app/screens/auth/login/otp.dart';
import 'package:paurakhi/src/app/screens/auth/login/otp_forgot.dart';
import 'package:paurakhi/src/app/screens/auth/register/register.dart';

class AuthRoutes {
  static void createUserRoute() {
    Get.offAll(const CreateScreen());
  }

  static void loginRoute() {
    Get.offAll(const LoginScreen());
  }

  static void googelSigninRoute() {
    Get.offAll(const GoogleSignin());
  }

  static void otpRoute() {
    Get.offAll(OTPScreen());
  }

   static void otpRouteForForgotPassword() {
    Get.to(OTPForgotScreen());
  }

  static void forgotScreen() {
    Get.offAll(ForgotPasswordScreen());
  }

  static void googleAuthFieldRoute() {
    Get.offAll(const GoogleSignin());
  }

  static void agricultureRoute() {}
  static void ticketRoute() {}
  static void ticketHistoryRoute() {}
}
