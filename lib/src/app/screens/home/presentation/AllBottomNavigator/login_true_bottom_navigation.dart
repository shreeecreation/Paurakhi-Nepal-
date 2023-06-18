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
      backgroundColor: Colors.transparent,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: _widgetOptions.elementAt(_selectedIndex),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
      bottomNavigationBar: Theme(
  data: ThemeData(
    canvasColor: Colors.transparent,
  ),
  child: Container(
    height: 80,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: const Color(0xFF828282),
          items: <BottomNavigationBarItem>[
            _buildRoundedIconBottomNavigationBarItem(Icons.notifications),
            _buildRoundedIconBottomNavigationBarItem(Icons.home_filled),
            _buildRoundedIconBottomNavigationBarItem(Icons.add),
            _buildRoundedIconBottomNavigationBarItem(Icons.person),
          ],
          currentIndex: _selectedIndex,
          unselectedLabelStyle: const TextStyle(fontSize: 0.5),
          selectedLabelStyle: const TextStyle(fontSize: 0.5),
          selectedItemColor: const Color(0xFF34A853),
          onTap: _onItemTapped,
          elevation: 0,
        ),
      ),
    ),
  ))

    );
  }
}

BottomNavigationBarItem _buildRoundedIconBottomNavigationBarItem(IconData icon) {
  return BottomNavigationBarItem(
    icon: Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, size: 25),
      ),
    ),
    label: "",
  );
}
