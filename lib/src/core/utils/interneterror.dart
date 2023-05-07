import 'package:flutter/material.dart';

class InternetErrorsDialogs {
  static void internalServerDialog(context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Error',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          content: const Text(
            'InternalServerError \n Server On Maintainence',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void noInternetDialog(context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Error',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          content: const Text(
            'No Internet Connection !',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Retry'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
