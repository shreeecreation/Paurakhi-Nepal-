import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paurakhi/src/app/screens/home/presentation/history/ProductHistory/model/product_history_model.dart';
import 'package:paurakhi/src/app/screens/home/presentation/history/ProductHistory/product_history.dart';
import 'package:paurakhi/src/core/API/CheckLogin/check_login.dart';
import 'package:paurakhi/src/core/API/LogOutAPI/logout_api.dart';
import 'package:paurakhi/src/core/API/ProductHistoryAPI/product_history_api.dart';
import 'package:paurakhi/src/core/API/userIfno/getuserinfo.dart';
import 'package:paurakhi/src/core/routes/authroutes.dart';
import 'package:paurakhi/src/core/routes/is_logged_in.dart';

import 'package:paurakhi/src/core/themes/appstyles.dart';
import 'package:paurakhi/src/core/utils/focuesnode.dart';
import 'package:restart_app/restart_app.dart';

class LoginDialogs {
  static void showIncorrectPassword(context, String message, String status) {
    dialogComponent(context, message, Icons.close, status);
  }

  static Future<Object?> changeLangauge(BuildContext context) {
    return dialogComponent(context, "Please restart your application",
        Icons.check_circle, "Success",
        button: "Restart");
  }

  static productCreated(BuildContext context, message, status) {
    return dialogComponent(context, message, Icons.check_circle, status);
  }

  static productError(BuildContext context, message) {
    return dialogComponent(context, message, Icons.close, "Error");
  }

  static loginError(BuildContext context, message) {
    return dialogComponent(context, message, Icons.close, "Error");
  }
}

class UserDialogs {
  static productExit(BuildContext context) {
    return productDialogComponent(
        context,
        "Don't save product ?\n Do you sure want to exit ?",
        Icons.warning,
        "Warning");
  }

  static internalServerError(context) {
    return dialogComponent(
        context,
        "Something went wrong \n Please try again later !",
        Icons.close,
        "Error");
  }

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
                    child: Center(
                        child: Text('Sucessfully Created User!',
                            textAlign: TextAlign.center,
                            style: AppStyles.text16PxSemiBold))),
                const SizedBox(height: 10),
                SizedBox(
                    width: 220,
                    child: Center(
                        child: Text('Please login to continue',
                            textAlign: TextAlign.center,
                            style: AppStyles.text14PxSemiBold))),
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
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                  color: Colors.green, width: 1.5)),
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

  static Future<Object?> updatePassword(BuildContext context, String message) {
    return dialogComponent(context, message, Icons.check_circle, "Success");
  }

  static updateProfile(BuildContext context, message, icon, status) {
    return dialogComponent(context, message, Icons.check_circle, "Success");
  }

  static invalidOTP(BuildContext context, message) {
    return dialogComponent(context, message, Icons.close, "Error");
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
                      child: Center(
                          child: Text('Account Verified Successfully!',
                              textAlign: TextAlign.center,
                              style: AppStyles.text16PxSemiBold))),
                  const SizedBox(height: 10),
                  SizedBox(
                      width: 220,
                      child: Center(
                          child: Text(
                              'You can turn on 2 Factor Authentication now',
                              textAlign: TextAlign.center,
                              style: AppStyles.text14PxSemiBold))),
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
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                      color: Colors.green, width: 1.5)),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.green),
                          child: const Text('Login'))),
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

Future<dynamic> dialogComponent(
    BuildContext context, String message, IconData icon, String status,
    {String button = "Closed"}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: SizedBox(
          height: 400,
          width: MediaQuery.of(context).size.width / 1.2,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 50,
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  backgroundColor: Colors.white,
                  contentPadding: const EdgeInsets.all(16.0),
                  content: SizedBox(
                    height: 200,
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Text(status,
                            style: AppStyles.text20PxSemiBold,
                            textAlign: TextAlign.center),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 200,
                          child: Text(message,
                              style: AppStyles.text16Px,
                              textAlign: TextAlign.center),
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                elevation: 0),
                            onPressed: () {
                              if (status == "Success") {
                                button == "Restart"
                                    ? Restart.restartApp()
                                    : pop(context);
                              } else {
                                button == "Restart"
                                    ? Restart.restartApp()
                                    : Navigator.pop(context);
                              }
                            },
                            child: Text(button,
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                child: Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: status == "Success" ? Colors.green : Colors.red,
                    ),
                    child: Icon(icon, color: Colors.white, size: 50)),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void restart() {
  LogOutAPI.clearSharedPreferences();
  IsLoggedIn.isLoggedIn = false;
  CheckLogin.setLoginInValue(false);

  Restart.restartApp();
}

Future<dynamic> productDialogComponent(
    BuildContext context, String message, IconData icon, String status,
    {String button = "Closed"}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: SizedBox(
          height: 410,
          width: MediaQuery.of(context).size.width / 1.2,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 50,
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  backgroundColor: Colors.white,
                  contentPadding: const EdgeInsets.all(16.0),
                  content: SizedBox(
                    height: 210,
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Text(status,
                            style: AppStyles.text20PxSemiBold,
                            textAlign: TextAlign.center),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 200,
                          child: Text(message,
                              style: AppStyles.text16Px,
                              textAlign: TextAlign.center),
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    elevation: 0),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text("Ok",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    elevation: 0),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Edit",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                child: Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: status == "Success"
                          ? Colors.green
                          : const Color.fromARGB(255, 228, 205, 0),
                    ),
                    child: Icon(icon, color: Colors.white, size: 40)),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void pop(context) {
  Navigator.of(context).pop();
  Navigator.of(context).pop();
}

Future<dynamic> deleteComponent(BuildContext context, Product product) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: SizedBox(
          height: 450,
          width: MediaQuery.of(context).size.width / 1.2,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 50,
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  backgroundColor: Colors.white,
                  contentPadding: const EdgeInsets.all(16.0),
                  content: SizedBox(
                    height: 200,
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Text("Delete ?",
                            style: AppStyles.text20PxSemiBold,
                            textAlign: TextAlign.center),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 250,
                          child: Text("Do you sure want to delete prodcut? ",
                              style: AppStyles.text16Px,
                              textAlign: TextAlign.center),
                        ),
                        const SizedBox(height: 10),
                        Text(product.name,
                            style: AppStyles.text16PxBold,
                            textAlign: TextAlign.center),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 100,
                              height: 35,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    elevation: 0),
                                onPressed: () {
                                  ProductHistory.deleteProduct(product.id);
                                  Navigator.pop(context);
                                  Get.find<ProductHistoryController>()
                                      .loadProductHistory();
                                },
                                child: const Text("Delete",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 100,
                              height: 35,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    elevation: 0),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("No",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                child: Container(
                    width: 55,
                    height: 55,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: const Icon(Icons.delete,
                        color: Colors.white, size: 50)),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<dynamic> exitDialog(
  BuildContext context,
) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: SizedBox(
          height: 400,
          width: MediaQuery.of(context).size.width / 1.2,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 50,
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  backgroundColor: Colors.white,
                  contentPadding: const EdgeInsets.all(16.0),
                  content: SizedBox(
                    height: 200,
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Text("Warning",
                            style: AppStyles.text20PxSemiBold,
                            textAlign: TextAlign.center),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 200,
                          child: Text(
                              "Do you sure want to exit the application ? ",
                              style: AppStyles.text16Px,
                              textAlign: TextAlign.center),
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 4.5,
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    elevation: 0),
                                onPressed: () {
                                  SystemNavigator.pop(animated: true);
                                },
                                child: const Text("Exit",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 4.5,
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    elevation: 0),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Cancel",
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                child: Container(
                    width: 55,
                    height: 55,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: const Icon(Icons.warning,
                        color: Colors.white, size: 30)),
              ),
            ],
          ),
        ),
      );
    },
  );
}
