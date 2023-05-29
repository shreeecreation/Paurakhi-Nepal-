import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paurakhi/src/app/screens/auth/login/login_screen.dart';
import 'package:paurakhi/src/app/screens/home/presentation/homescreen/home_screen.dart';
import 'package:paurakhi/src/core/utils/get_current_location.dart';
import '../tabbars/bloc/tab_bloc_bloc.dart';

class LoginFalseBottomNavigator extends StatefulWidget {
  const LoginFalseBottomNavigator({super.key});

  @override
  State<LoginFalseBottomNavigator> createState() => _LoginFalseBottomNavigatorState();
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
