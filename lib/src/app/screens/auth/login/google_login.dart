import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/extensions/colors_extension.dart';
import 'package:paurakhi/src/core/themes/appstyles.dart';

class GoogleSignin extends StatelessWidget {
  const GoogleSignin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF4FBF3),
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 35,
            child: Stack(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.end, children: [
                Text("One Step Ahead", style: AppStyles.text24PxBold),
                Text("Some additional details", style: AppStyles.text16Px),
                const SizedBox(height: 20),
                const SizedBox(height: 10),
                phoneNumber(context),
                const SizedBox(height: 10),
                password(context),
                const SizedBox(height: 10),
                confirmPassword(context),
                const SizedBox(height: 15),
                signUp(context),
                const SizedBox(height: 15),
                SizedBox(height: MediaQuery.of(context).size.height / 4),
                Align(alignment: Alignment.bottomCenter, child: Image.asset('assets/images/design.png', fit: BoxFit.cover)),
              ]),
            ]),
          ),
        ));
  }
}

SizedBox signUp(BuildContext context) {
  return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width / 1.2,
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF34A853), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
          child: Text("Log In", style: AppStyles.text18PxSemiBold)));
}

SizedBox confirmPassword(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width / 1.2,
    child: TextField(
      decoration: InputDecoration(
        hintText: 'Confirm Password',
        filled: true,
        hintStyle: AppStyles.text16Px.textGrey,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black, width: 2.0)),
      ),
    ),
  );
}

SizedBox password(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width / 1.2,
    child: TextField(
      decoration: InputDecoration(
        hintText: 'Password',
        filled: true,
        hintStyle: AppStyles.text16Px.textGrey,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black, width: 2.0)),
      ),
    ),
  );
}

SizedBox phoneNumber(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width / 1.2,
    child: TextField(
        decoration: InputDecoration(
            hintText: 'Phone Number',
            hintStyle: AppStyles.text16Px.textGrey,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black, width: 2.0)))),
  );
}
