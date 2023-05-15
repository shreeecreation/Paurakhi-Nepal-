import 'package:flutter/material.dart';

import 'AllBottomNavigator/login_true_bottom_navigation.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: LoginTrueBottomNavigator());
  }
}
