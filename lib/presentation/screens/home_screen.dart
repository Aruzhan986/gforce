import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gforce/presentation/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.yellow,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.yellow,
        height: 50,
        items: <Widget>[
          Icon(Icons.person, size: 30),
          Icon(Icons.person, size: 30),
          Icon(Icons.work, size: 30),
          Icon(Icons.qr_code_2, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
