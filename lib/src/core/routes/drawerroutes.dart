import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:paurakhi/main.dart';
import 'package:paurakhi/src/app/screens/home/presentation/blog/blog_screen.dart';
import 'package:paurakhi/src/app/screens/home/presentation/news/news_screen.dart';

import '../../app/screens/home/presentation/News/bloc/news_bloc.dart';

class DrawerRoutes {
  static void blogRoute() {
    Get.to(const BlogScreen());

    scaffoldKey.currentState!.openEndDrawer();
  }

  static void homeRoute(context) {
    Navigator.pop(context);
  }

  static void newsRoute() {
    Get.to(const NewsScreen());

    scaffoldKey.currentState!.openEndDrawer();
  }

  static void categoryRoute() {}
  static void agricultureRoute() {}
  static void ticketRoute() {}
  static void ticketHistoryRoute() {}
}
