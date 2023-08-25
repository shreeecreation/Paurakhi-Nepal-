import 'package:flutter/material.dart';
import 'package:paurakhi/src/app/screens/auth/login/validators/validators.dart';
import 'package:paurakhi/src/core/API/ForgotPasswordAPI/forgot_password_api.dart';
import 'package:paurakhi/src/core/extensions/colors_extension.dart';
import 'package:paurakhi/src/core/routes/authroutes.dart';
import 'package:paurakhi/src/core/themes/appcolors.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final GlobalKey<FormState> forgotKey = GlobalKey<FormState>();
  final TextEditingController phoneNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FBF3),
      body: SingleChildScrollView(
          child: Form(
        key: forgotKey,
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(children: [
              IconButton(
                  onPressed: () {
                    AuthRoutes.loginRoute();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 40,
                    color: AppColors.statusGreen,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Forgot Password", style: AppStyles.text24PxBold),
                      const SizedBox(height: 5),
                      Text("Enter your number to verify",
                          style: AppStyles.text16Px),
                      const SizedBox(height: 20),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: TextFormField(
                            controller: phoneNumber,
                            validator: (val) {
                              if (!ExtString.validatePhoneNumber(val!)) {
                                return " Enter a valid phone number";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Phone Number',
                              filled: true,
                              hintStyle: AppStyles.text16Px.textGrey,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2.0),
                              ),
                            ),
                          )),
                      const SizedBox(height: 20),
                      Center(
                        child: SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width - 50,
                            child: ElevatedButton(
                                onPressed: () async {
                                  //
                                  if (forgotKey.currentState!.validate()) {
                                    await ForgotPasswordAPI.verifyNumberForgot(
                                        phoneNumber.text, context);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF34A853),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
                                child: Text("Verify Number",
                                    style: AppStyles.text16Px))),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 70),
              Align(
                alignment: Alignment.bottomCenter,
                child:
                    Image.asset('assets/images/design.png', fit: BoxFit.cover),
              ),
            ])),
      )),
    );
  }
}
