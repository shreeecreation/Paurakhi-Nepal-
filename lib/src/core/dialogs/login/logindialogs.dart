import 'package:flutter/material.dart';

import 'package:paurakhi/src/core/themes/appstyles.dart';

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
            height: 250.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.info_outline, color: Colors.green, size: 50),
                const SizedBox(height: 15),
                SizedBox(
                    width: 220,
                    child: Center(
                        child:
                            Text('Are you sure want to Logout from this account !', textAlign: TextAlign.center, style: AppStyles.text16PxSemiBold))),
                const SizedBox(height: 10),
                Center(
                  child: SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: ElevatedButton(
                          onPressed: () {
                            // addProduct(context);
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: const Color(0xFF34A853),
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                          child: Text("Logout", style: AppStyles.text16Px))),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), side: const BorderSide(color: Colors.green, width: 1.5)),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.green),
                      child: const Text('Cancel')),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
