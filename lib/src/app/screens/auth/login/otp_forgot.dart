import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/API/otp/otpconfirm.dart';
import 'package:paurakhi/src/core/countdowntimer/countdowntimer.dart';
import 'package:paurakhi/src/core/extensions/colors_extension.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:pinput/pinput.dart';

// ignore: must_be_immutable
class OTPForgotScreen extends StatelessWidget {
  OTPForgotScreen({super.key});
  String verifypin = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SizedBox(
        child: Stack(children: [
          Container(
            margin: const EdgeInsets.only(left: 25, right: 25),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Enter Your OTP",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Please Check your SMS for the OTP", style: TextStyle(fontSize: 17), textAlign: TextAlign.center),
                  const SizedBox(height: 30),
                  Pinput(
                    length: 4,
                    showCursor: true,
                    onCompleted: (pin) => verifypin = pin,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text("Didn't received OTP? ", style: TextStyle(fontSize: 14), textAlign: TextAlign.center),
                      CoutDownTimerManager.coutDownTimer(),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade600, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                        onPressed: () async {
                          await ConfirmOTP.confirmOtpForgot(verifypin, context);
                        },
                        child: const Text("Continue")),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Edit your number ?", style: AppStyles.text16Px.textBlue)),
                  const SizedBox(height: 70),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset('assets/images/design.png', fit: BoxFit.cover),
          ),
        ]),
      ),
    );
  }
}
