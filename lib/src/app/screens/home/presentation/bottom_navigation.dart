import 'package:flutter/material.dart';
import 'package:paurakhi/src/app/screens/home/presentation/homescreen/home_screen.dart';
import 'package:paurakhi/src/app/screens/home/presentation/notifications/notifications_screeen.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 10, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    const NotificationScreen(),
    const HomeScreen(),
    const Text('Index 2: School', style: optionStyle),
    const Text('Index 2: School', style: optionStyle),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
