import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/homescreen/home_screen.dart';
import 'package:paurakhi/src/app/screens/home/presentation/notifications/notifications_screeen.dart';

import 'profile/profile_screen.dart';
import 'request/request_screen.dart';
import 'tabbars/bloc/tab_bloc_bloc.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _selectedIndex = 1;
  static final List<Widget> _widgetOptions = <Widget>[
    const NotificationScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      BlocProvider.of<TabBlocBloc>(context).add(TabInitialEvent());

      if (index == 2) {
        _selectedIndex = _selectedIndex;
        requestBottomSheet(context);
      } else {
        _selectedIndex = index;
      }
      BlocProvider.of<TabBlocBloc>(context).add(TabInitialEvent());
    });
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
