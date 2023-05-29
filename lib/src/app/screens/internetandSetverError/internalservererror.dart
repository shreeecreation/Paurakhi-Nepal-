// ignore_for_file: file_names

import 'package:flutter/material.dart';

class InternalServerError {
  static void dialog(context) {
    showDialog(
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
            'InternalServerError',
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
}
