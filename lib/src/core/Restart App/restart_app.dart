import 'package:flutter/material.dart';
import 'package:paurakhi/main.dart';

void restartApp() {
  // Spawn a new isolate and send a message to trigger the hot restart-like behavior
  runApp(MyApp());
}

void _restartIsolate(dynamic message) {
  // Perform any necessary cleanup or preparation here

  // Delay the app restart by a few milliseconds to allow the current isolate to exit gracefully
  Future.delayed(const Duration(milliseconds: 100), () {
    // Call the main function to restart the app
  });
}
