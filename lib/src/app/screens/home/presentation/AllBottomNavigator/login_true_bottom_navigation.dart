import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/homescreen/home_screen.dart';
import 'package:paurakhi/src/app/screens/home/presentation/notifications/notifications_screeen.dart';
import 'package:paurakhi/src/core/utils/get_current_location.dart';

import '../profile/profile_screen.dart';
import '../request/request_screen.dart';
import '../tabbars/bloc/tab_bloc_bloc.dart';

class LoginTrueBottomNavigator extends StatefulWidget {
  const LoginTrueBottomNavigator({super.key});

  @override
  State<LoginTrueBottomNavigator> createState() => _LoginTrueBottomNavigatorState();
}

class _LoginTrueBottomNavigatorState extends State<LoginTrueBottomNavigator> {
  int _selectedIndex = 1;
  static final List<Widget> _widgetOptions = <Widget>[
    const NotificationScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == _selectedIndex) {
      return;
    }
    setState(() {
      if (index == 2) {
        _selectedIndex = _selectedIndex;
        requestBottomSheet(context);
      } else {
        BlocProvider.of<TabBlocBloc>(context).add(TabInitialEvent());

        _selectedIndex = index;
      }
    });
  }

  @override
  void initState() {
    getLocation();
    // TODO: implement initState
    super.initState();
  }

  getLocation() async {
    try {
      await GetCurrentLocation.getCurrentPosition(context);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: const Color(0xFF828282),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.notifications, size: 28), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.home_filled, size: 28), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.add, size: 28), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.person, size: 28), label: ""),
          ],
          currentIndex: _selectedIndex,
          unselectedLabelStyle: const TextStyle(fontSize: 0.5),
          selectedLabelStyle: const TextStyle(fontSize: 0.5),
          selectedItemColor: const Color(0xFF34A853),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
