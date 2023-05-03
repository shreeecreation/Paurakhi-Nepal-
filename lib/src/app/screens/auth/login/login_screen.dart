import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/API/CookieManager/managelogincookie.dart';
import 'package:paurakhi/src/core/extensions/colors_extension.dart';
import 'package:paurakhi/src/core/routes/authroutes.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

import '../../../../core/API/login/loginapi.dart';
import 'validators/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isChecked = false;
  TextEditingController phoneNo = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF4FBF3),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 35,
              child: Stack(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text("Welcome back", style: AppStyles.text24PxBold),
                  Text("login to continue", style: AppStyles.text16Px),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: TextFormField(
                      controller: phoneNo,
                      validator: (val) {
                        if (!ExtString.validatePhoneNumber(val!)) return " Enter a valid phone number";
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        filled: true,
                        hintStyle: AppStyles.text16Px.textGrey,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black, width: 2.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: TextFormField(
                        controller: password,
                        validator: (val) {
                          if (!ExtString.validatePassword(val!)) return "Password length should be greater than 8";
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: AppStyles.text16Px.textGrey,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black, width: 2.0)))),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text("Forgot Password ?", style: AppStyles.text14Px.textBlue),
                        Row(
                          children: [
                            Checkbox(
                              value: isChecked,
                              activeColor: Colors.green,
                              onChanged: (newValue) {
                                setState(() {
                                  isChecked = newValue!;
                                });
                              },
                            ),
                            Text("Remember me", style: AppStyles.text16Px)
                          ],
                        ),
                      ])),
                  const SizedBox(height: 10),
                  SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: ElevatedButton(
                          onPressed: () async {
                            //TODO login functionality
                            loginFunction(formKey, phoneNo, password, context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF34A853),
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                          child: Text("Login", style: AppStyles.text18PxSemiBold))),
                  const SizedBox(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Image.network(
                      "http://pngimg.com/uploads/google/google_PNG19635.png",
                      height: 30,
                    ),
                    const Text("Login with Google ")
                  ]),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account ? ", style: AppStyles.text14PxMedium),
                      TextButton(
                          onPressed: () {
                            AuthRoutes.createUserRoute();
                          },
                          child: const Text("Create an account"))
                    ],
                  ),
                  const SizedBox(height: 70),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset('assets/images/design.png', fit: BoxFit.cover),
                  ),
                ]),
              ]),
            ),
          ),
        ));
  }
}

void loginFunction(formKey, phoneNo, password, context) async {
  if (formKey.currentState!.validate()) {
    var response = await LoginAPI.loginPoint(phoneNo.text, password.text, context);
    var data = response?.body;
    if (data != null) {
      var responseBody = jsonDecode(data);
      if (!responseBody["twoFactor"]) {
        ManageLoginCookie.manageLoginCookieTwoFactorFalse(response);
        phoneNo.text = "";
        password.text = "";
      } else {
        ManageLoginCookie.manageLoginCookieTwoFactorTrue(response);
        phoneNo.text = "";
        password.text = "";


      }
    }
  }
}
