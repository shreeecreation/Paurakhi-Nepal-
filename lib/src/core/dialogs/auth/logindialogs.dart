import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/routes/authroutes.dart';
import 'package:paurakhi/src/core/routes/homeroutes.dart';

import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:paurakhi/src/core/utils/focuesnode.dart';

class LoginDialogs {
  void showIncorrectPassword(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: SizedBox(
            height: 200.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.info_outline, color: Colors.red, size: 60),
                const SizedBox(height: 15),
                SizedBox(
                    width: 200,
                    child: Center(child: Text('Incorect number or password !', textAlign: TextAlign.center, style: AppStyles.text18PxSemiBold))),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 2,
                      child: ElevatedButton(
                          onPressed: () {
                            // addProduct(context);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: const Color(0xFF34A853),
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                          child: Text("Retry", style: AppStyles.text16Px))),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class UserDialogs {
  static void successCreateUser(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: SizedBox(
            height: 250.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.close_rounded, color: Colors.red, size: 50),
                const SizedBox(height: 15),
                SizedBox(
                    width: 220,
                    child: Center(child: Text('Sucessfully Created User!', textAlign: TextAlign.center, style: AppStyles.text16PxSemiBold))),
                const SizedBox(height: 10),
                SizedBox(
                    width: 220,
                    child: Center(child: Text('Please login to continue', textAlign: TextAlign.center, style: AppStyles.text14PxSemiBold))),
                const SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        unFocusNode(context);
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), side: const BorderSide(color: Colors.green, width: 1.5)),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.green),
                      child: const Text('Ok')),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static void updatePassword(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: SizedBox(
            height: 250.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.close_rounded, color: Colors.red, size: 50),
                const SizedBox(height: 15),
                SizedBox(
                    width: 220,
                    child: Center(child: Text('Password Update Successfully!', textAlign: TextAlign.center, style: AppStyles.text16PxSemiBold))),
                const SizedBox(height: 10),
                SizedBox(
                    width: 220,
                    child: Center(child: Text('Please login to continue', textAlign: TextAlign.center, style: AppStyles.text14PxSemiBold))),
                const SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: ElevatedButton(
                      onPressed: () {
                        // TODO logout functionlaity
                        AuthRoutes.loginRoute();
                        unFocusNode(context);
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), side: const BorderSide(color: Colors.green, width: 1.5)),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.green),
                      child: const Text('Ok')),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static void updateProfile(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: SizedBox(
            height: 250.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.close_rounded, color: Colors.red, size: 50),
                const SizedBox(height: 15),
                SizedBox(
                    width: 220,
                    child: Center(child: Text('Profile Updated Successfully!', textAlign: TextAlign.center, style: AppStyles.text16PxSemiBold))),
                const SizedBox(height: 10),
                SizedBox(width: 220, child: Center(child: Text('', textAlign: TextAlign.center, style: AppStyles.text14PxSemiBold))),
                const SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), side: const BorderSide(color: Colors.green, width: 1.5)),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.green),
                      child: const Text('Ok')),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static void verifyAccount(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: SizedBox(
            height: 250.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.close_rounded, color: Colors.red, size: 50),
                const SizedBox(height: 15),
                SizedBox(
                    width: 220,
                    child: Center(child: Text('Account Verified Successfully!', textAlign: TextAlign.center, style: AppStyles.text16PxSemiBold))),
                const SizedBox(height: 10),
                SizedBox(
                    width: 220,
                    child: Center(
                        child: Text('You can turn on 2 Factor Authentication now', textAlign: TextAlign.center, style: AppStyles.text14PxSemiBold))),
                const SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: ElevatedButton(
                      onPressed: () {
                        HomeRoutes.homeScreen();
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), side: const BorderSide(color: Colors.green, width: 1.5)),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.green),
                      child: const Text('Later on ')),
                ),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), side: const BorderSide(color: Colors.green, width: 1.5)),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.green),
                      child: const Text('Ok')),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
