import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paurakhi/src/app/screens/home/presentation/home_page.dart';

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

  void navigateToNextScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(const HomePage(), transition: Transition.downToUp, duration: const Duration(milliseconds: 1000));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(child: Image.asset("assets/images/logo2.png")),
          const Positioned(
            bottom: 0,
            right: 0,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "by makuraLabs",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
