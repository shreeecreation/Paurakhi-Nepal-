import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/extensions/colors_extension.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

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
                Text("Set Your Farm Now", style: AppStyles.text24PxBold),
                Text("sign in to start your journey", style: AppStyles.text16Px),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Full Name',
                      hintStyle: AppStyles.text16Px.textGrey,
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
                          hintText: 'Phone Number',
                          hintStyle: AppStyles.text16Px.textGrey,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black, width: 2.0)))),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Password',
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
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
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
                    height: 50,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: ElevatedButton(
                        onPressed: () {
                          // addProduct(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF34A853),
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                        child: Text("Sign Up", style: AppStyles.text18PxSemiBold))),
                const SizedBox(height: 30),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.gps_off_outlined),
                  const SizedBox(width: 5),
                  Text("Login with Google", style: AppStyles.text18PxBold)
                ]),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 40),
                    Text("Already have an account ?", style: AppStyles.text14PxMedium),
                    TextButton(onPressed: () {}, child: const Text("Log In"))
                  ],
                ),
                const SizedBox(height: 70),
                Align(alignment: Alignment.bottomCenter, child: Image.asset('assets/images/design.png', fit: BoxFit.cover)),
              ]),
            ]),
          ),
        ));
  }
}
