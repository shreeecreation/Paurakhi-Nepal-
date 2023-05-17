import 'package:flutter/material.dart';
import 'package:paurakhi/src/core/routes/is_logged_in.dart';

import 'AllBottomNavigator/login_false_bottom_navigtor.dart';
import 'AllBottomNavigator/login_true_bottom_navigation.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: IsLoggedIn.isLoggedIn ? const LoginTrueBottomNavigator() : const LoginFalseBottomNavigator());
  }
}
