import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/API/userIfno/getuserinfo.dart';
import 'package:paurakhi/src/core/routes/authroutes.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:paurakhi/src/core/themes/appcolors.dart';

import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:paurakhi/src/core/utils/focuesnode.dart';

class LoginDialogs {
  static Future<Object?> showIncorrectPassword(BuildContext context) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dismissOnTouchOutside: false,
      headerAnimationLoop: false,
      dialogType: DialogType.error,
      bodyHeaderDistance: 30,
      desc: 'Incorrect number and password!',
      titleTextStyle: AppStyles.text20PxSemiBold,
      descTextStyle: AppStyles.text16Px,
      showCloseIcon: false,
      btnOkOnPress: () {},
      onDismissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
      title: 'Retry',
    ).show();
  }

  static Future<Object?> changeLangauge(BuildContext context) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dismissOnTouchOutside: false,
      headerAnimationLoop: false,
      dialogType: DialogType.success,
      bodyHeaderDistance: 30,
      // customHeader: const Icon(Icons.done),
      showCloseIcon: false,
      title: 'Succes',
      titleTextStyle: AppStyles.text20PxSemiBold,
      descTextStyle: AppStyles.text16Px,
      desc: 'Paurakhi application language changed successfully ',
      btnOkOnPress: () {
        debugPrint('OnClcik');
      },
      btnOkIcon: Icons.check_circle,
      onDismissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
    ).show();
  }

  static Future<Object?> productCreated(BuildContext context) {
    return AwesomeDialog(
      context: context,

      animType: AnimType.scale,
      dismissOnTouchOutside: false,
      headerAnimationLoop: false,

      dialogType: DialogType.success,
      bodyHeaderDistance: 30,
      // customHeader: const Icon(Icons.done),
      showCloseIcon: false,
      title: 'Succes',
      titleTextStyle: AppStyles.text20PxSemiBold,
      descTextStyle: AppStyles.text16Px,
      desc: 'Product Created successfully \n Wait or admin to approve !',
      btnOkOnPress: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
      btnOkIcon: Icons.check_circle,
      onDismissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
    ).show();
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

  static Future<Object?> updatePassword(BuildContext context) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dismissOnTouchOutside: false,
      headerAnimationLoop: false,
      dialogType: DialogType.success,
      bodyHeaderDistance: 30,
      // customHeader: const Icon(Icons.done),
      showCloseIcon: false,
      title: 'Succes',
      titleTextStyle: AppStyles.text20PxSemiBold,
      descTextStyle: AppStyles.text16Px,
      desc: 'Password Update Successfully !\n Please login to continue',
      btnOkOnPress: () {
        Navigator.pop(context);
        AuthRoutes.loginRoute();
      },
      btnOkIcon: Icons.check_circle,
      onDismissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
    ).show();
  }

  static Future<Object?> updateProfile(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dismissOnTouchOutside: false,
      headerAnimationLoop: false,
      dialogType: DialogType.success,
      bodyHeaderDistance: 10,
      showCloseIcon: false,
      // customHeader: Icon,
      title: 'Success',
      titleTextStyle: AppStyles.text20PxSemiBold,
      descTextStyle: AppStyles.text16Px,
      desc: 'Profile Updated Successfully !',
      btnOkOnPress: () {
        Navigator.pop(context);
      },
      btnOkIcon: Icons.check_circle,
      onDismissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
    ).show();
  }

  static void verifyAccount(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            // Disable closing the dialog with the back button
            return false;
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            content: SizedBox(
              height: 280.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(Icons.done, color: Colors.green, size: 50),
                  const SizedBox(height: 15),
                  SizedBox(
                      width: 220,
                      child: Center(child: Text('Account Verified Successfully!', textAlign: TextAlign.center, style: AppStyles.text16PxSemiBold))),
                  const SizedBox(height: 10),
                  SizedBox(
                      width: 220,
                      child: Center(
                          child:
                              Text('You can turn on 2 Factor Authentication now', textAlign: TextAlign.center, style: AppStyles.text14PxSemiBold))),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: ElevatedButton(
                        onPressed: () async {
                          await GetUserInfo.getUserInfo();
                          AuthRoutes.loginRoute();
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), side: const BorderSide(color: Colors.green, width: 1.5)),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.green),
                        child: const Text('Login')),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
