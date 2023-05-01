import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/extensions/colors_extension.dart';
import 'package:paurakhi/src/core/routes/authroutes.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    return Scaffold(
        backgroundColor: const Color(0xFFF4FBF3),
        body: SingleChildScrollView(
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
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      filled: true,
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
                  child: TextField(
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
                          Transform.scale(
                            scale: 0.8,
                            child: Checkbox(
                              value: isChecked,
                              onChanged: (value) {
                                isChecked = value!;
                              },
                              activeColor: Colors.green,
                              side: const BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
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
                        onPressed: () {
                          // addProduct(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF34A853),
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                        child: Text("Login", style: AppStyles.text18PxSemiBold))),
                const SizedBox(height: 20),
                const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.gps_off_outlined), Text("Login with Google ")]),
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
        ));
  }
}
