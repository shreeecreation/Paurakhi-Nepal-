import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:paurakhi/src/core/env/envmodels.dart';

import 'src/app/screens/auth/login/login_screen.dart';
import 'src/core/utils/focuesnode.dart';

Future<void> main() async {
  await dotenv.load(fileName: Environment.fileName);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white));
  await dotenv.load();
  runApp(const MyApp());
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        unFocusNode(context);
      },
      child: SafeArea(
        child: GetMaterialApp(
            debugShowCheckedModeBanner: false, theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light), home: const LoginScreen()),
      ),
    );
  }
}
