import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paurakhi/src/app/screens/home/presentation/home_page.dart';
import 'package:paurakhi/src/core/API/CookieManager/managelogincookie.dart';
import 'package:paurakhi/src/core/API/Notification%20API/notification_api.dart';
import 'package:paurakhi/src/core/API/userIfno/getuserinfo.dart';
import 'package:paurakhi/src/core/extensions/colors_extension.dart';
import 'package:paurakhi/src/core/routes/authroutes.dart';
import 'package:paurakhi/src/core/routes/is_logged_in.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              height: MediaQuery.of(context).size.height,
              child: Stack(children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(AppLocalizations.of(context)!.welcome_back,
                          style: AppStyles.text24PxBold),
                      Text(AppLocalizations.of(context)!.login_to_continue,
                          style: AppStyles.text16Px),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: TextFormField(
                          controller: phoneNo,
                          validator: (val) {
                            if (!ExtString.validatePhoneNumber(val!)) {
                              return AppLocalizations.of(context)!
                                  .enter_a_valid_phone;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.phoneNo,
                            filled: true,
                            hintStyle: AppStyles.text16Px.textGrey,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0),
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
                              if (!ExtString.validatePassword(val!)) {
                                return AppLocalizations.of(context)!
                                    .password_length_error;
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText:
                                    AppLocalizations.of(context)!.password,
                                hintStyle: AppStyles.text16Px.textGrey,
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2.0)))),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    child: Text(
                                        "${AppLocalizations.of(context)!.forgot_pasword}?",
                                        style: AppStyles.text14Px.textBlue),
                                    onPressed: () {
                                      AuthRoutes.forgotScreen();
                                    }),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: isChecked,
                                      activeColor: Colors.green,
                                      onChanged: (newValue) {
                                        setState(() {
                                          isChecked = newValue!;
                                          IsLoggedIn.keepLogin = newValue;
                                        });
                                      },
                                    ),
                                    Text(
                                        AppLocalizations.of(context)!
                                            .remember_me,
                                        style: AppStyles.text16Px)
                                  ],
                                ),
                              ])),
                      const SizedBox(height: 10),
                      SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: ElevatedButton(
                              onPressed: () async {
                                loginFunction(formKey, phoneNo, password,
                                    context, isChecked);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF34A853),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)))),
                              child: Text(AppLocalizations.of(context)!.login,
                                  style: AppStyles.text18PxSemiBold))),
                      const SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.person, color: Colors.green),
                            TextButton(
                                onPressed: () async {
                                  IsLoggedIn.isLoggedIn = false;
                                  Get.offAll(const HomePage(),
                                      transition: Transition.downToUp,
                                      duration:
                                          const Duration(milliseconds: 1000));
//
                                },
                                child: Text(AppLocalizations.of(context)!
                                    .login_as_guest))
                          ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              "${AppLocalizations.of(context)!.dont_have_an_account} ?",
                              style: AppStyles.text14PxMedium),
                          TextButton(
                              onPressed: () {
                                AuthRoutes.createUserRoute();
                              },
                              child: Text(
                                  AppLocalizations.of(context)!.create_account))
                        ],
                      ),
                      const SizedBox(height: 70),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset('assets/images/design.png',
                            fit: BoxFit.cover),
                      ),
                    ]),
              ]),
            ),
          ),
        ));
  }
}

void loginFunction(formKey, phoneNo, password, context, checkLogin) async {
  if (formKey.currentState!.validate()) {
    var response =
        await LoginAPI.loginPoint(phoneNo.text, password.text, context);
    var data = response?.body;
    if (data != null) {
      var responseBody = jsonDecode(data);
      if (!responseBody["twoFactor"]) {
        ManageLoginCookie.manageLoginCookieTwoFactorFalse(response, checkLogin);
        IsLoggedIn.isLoggedIn = true;

        SSEManager.startListening();
        await GetUserInfo.getUserInfo();

        phoneNo.text = "";
        password.text = "";
      } else {
        await GetUserInfo.getUserInfo();
        IsLoggedIn.isLoggedIn = true;

        ManageLoginCookie.manageLoginCookieTwoFactorTrue(response, checkLogin);
        phoneNo.text = "";
        password.text = "";
      }
    }
  }
}
