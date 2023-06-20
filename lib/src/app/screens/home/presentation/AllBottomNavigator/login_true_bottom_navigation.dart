import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paurakhi/src/app/screens/home/presentation/homescreen/home_screen.dart';
import 'package:paurakhi/src/app/screens/home/presentation/notifications/notifications_screeen.dart';
import 'package:paurakhi/src/core/themes/appcolors.dart';
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
      extendBody: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: _widgetOptions.elementAt(_selectedIndex),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: 200,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              height: 70,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                child: Material(
                  // Wrap with Material widget
                  elevation: 16.0, // Set the desired elevation value
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    child: BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      unselectedItemColor: const Color(0xFF828282),
                      items: <BottomNavigationBarItem>[
                        _selectedIndex == 0
                            ? _buildRoundedIconBottomNavigationBarItem(Icons.notifications_active)
                            : _buildRoundedIconBottomNavigationBarItem(Icons.notifications_active_outlined),
                        _selectedIndex == 1
                            ? _buildRoundedIconBottomNavigationBarItem(Icons.home)
                            : _buildRoundedIconBottomNavigationBarItem(Icons.home_outlined),
                        _buildRoundedIconBottomNavigationBarItem(Icons.add),
                        _selectedIndex == 3
                            ? _buildRoundedIconBottomNavigationBarItem(Icons.person)
                            : _buildRoundedIconBottomNavigationBarItem(Icons.person_outline),
                      ],
                      currentIndex: _selectedIndex,
                      unselectedLabelStyle: const TextStyle(fontSize: 0.5),
                      selectedLabelStyle: const TextStyle(fontSize: 0.5),
                      selectedItemColor: Colors.green,
                      onTap: _onItemTapped,
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

BottomNavigationBarItem _buildRoundedIconBottomNavigationBarItem(IconData icon) {
  return BottomNavigationBarItem(
    icon: Padding(padding: const EdgeInsets.all(8.0), child: Icon(icon, size: 30)),
    label: "",
  );
}
