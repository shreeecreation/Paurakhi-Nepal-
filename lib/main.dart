import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paurakhi/src/app/screens/home/presentation/home_page.dart';

import 'src/core/utils/focuesnode.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white, // status bar color
  ));
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
            debugShowCheckedModeBanner: false, theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light), home: const HomePage()),
      ),
    );
  }
}
