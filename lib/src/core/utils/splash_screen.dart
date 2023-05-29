import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paurakhi/src/app/screens/home/presentation/home_page.dart';
import 'package:paurakhi/src/core/API/CheckLogin/check_login.dart';
import 'package:paurakhi/src/core/extensions/colors_extension.dart';
import 'package:paurakhi/src/core/routes/is_logged_in.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  void navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    bool isLoggedIn = await CheckLogin.checkLogin();

    if (isLoggedIn) {
      IsLoggedIn.isLoggedIn = true;
      Get.offAll(const HomePage(), transition: Transition.downToUp, duration: const Duration(milliseconds: 1000));
    } else {
      IsLoggedIn.isLoggedIn = false;
      Get.offAll(const HomePage(), transition: Transition.downToUp, duration: const Duration(milliseconds: 1000));
//
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(child: Image.asset("assets/images/logo2.png")),
          Positioned(
            bottom: 1,
            right: 0,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("by makuraLabs", style: AppStyles.text16Px.textGrey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
