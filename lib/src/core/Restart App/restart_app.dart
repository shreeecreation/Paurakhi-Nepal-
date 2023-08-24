import 'package:flutter/material.dart';
import 'package:paurakhi/main.dart';

void restartApp() {
  // Spawn a new isolate and send a message to trigger the hot restart-like behavior
  runApp(MyApp());
}
