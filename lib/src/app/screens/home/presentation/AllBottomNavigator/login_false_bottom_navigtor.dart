import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paurakhi/src/app/screens/auth/login/login_screen.dart';
import 'package:paurakhi/src/app/screens/home/presentation/homescreen/home_screen.dart';
import 'package:paurakhi/src/core/utils/get_current_location.dart';
import '../tabbars/bloc/tab_bloc_bloc.dart';

class LoginFalseBottomNavigator extends StatefulWidget {
  const LoginFalseBottomNavigator({super.key});

  @override
  State<LoginFalseBottomNavigator> createState() =>
      _LoginFalseBottomNavigatorState();
}

class _LoginFalseBottomNavigatorState extends State<LoginFalseBottomNavigator> {
  int _selectedIndex = 1;
  static final List<Widget> _widgetOptions = <Widget>[
    const LoginScreen(),
    const HomeScreen(),
    const LoginScreen(),
    const LoginScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      BlocProvider.of<TabBlocBloc>(context).add(TabInitialEvent());
    });
  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  getLocation() async {
    try {
      await GetCurrentLocation.getCurrentPosition(context);
    } catch (e) {
      debugPrint("$e");
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                child: Material(
                  // Wrap with Material widget
                  elevation: 8.0, // Set the desired elevation value
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    child: BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      unselectedItemColor: const Color(0xFF828282),
                      items: <BottomNavigationBarItem>[
                        _selectedIndex == 0
                            ? _buildRoundedIconBottomNavigationBarItemActive(
                                Icons.notifications_active)
                            : _buildRoundedIconBottomNavigationBarItem(
                                Icons.notifications_active_outlined),
                        _selectedIndex == 1
                            ? _buildRoundedIconBottomNavigationBarItemActive(
                                Icons.home)
                            : _buildRoundedIconBottomNavigationBarItem(
                                Icons.home_outlined),
                        _selectedIndex == 2
                            ? _buildRoundedIconBottomNavigationBarItemActive(
                                Icons.add)
                            : _buildRoundedIconBottomNavigationBarItem(
                                Icons.add),
                        _selectedIndex == 3
                            ? _buildRoundedIconBottomNavigationBarItemActive(
                                Icons.person)
                            : _buildRoundedIconBottomNavigationBarItem(
                                Icons.person_outline),
                      ],
                      currentIndex: _selectedIndex,
                      unselectedLabelStyle: const TextStyle(fontSize: 0.5),
                      selectedLabelStyle: const TextStyle(fontSize: 0.5),
                      selectedItemColor: Colors.white,
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

BottomNavigationBarItem _buildRoundedIconBottomNavigationBarItem(
    IconData icon) {
  return BottomNavigationBarItem(
    icon: Padding(
        padding: const EdgeInsets.all(8.0), child: Icon(icon, size: 30)),
    label: "",
  );
}

BottomNavigationBarItem _buildRoundedIconBottomNavigationBarItemActive(
    IconData icon) {
  return BottomNavigationBarItem(
    icon: Container(
      height: 40,
      width: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.green,
      ),
      child: Center(child: Icon(icon, size: 20)),
    ),
    label: "",
  );
}
