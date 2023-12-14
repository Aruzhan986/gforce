import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gforce/presentation/constants/constants.dart';
import 'package:flutter_gforce/presentation/screens/animation_screen.dart';
import 'package:flutter_gforce/presentation/screens/news_screen.dart';
import 'package:flutter_gforce/presentation/screens/profile_screen.dart';
import 'package:flutter_gforce/presentation/screens/qr_screen.dart';
import 'package:flutter_gforce/presentation/screens/stories_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    ProfilePage(),
    NewsScreen(),
    QrScreen(),
    AnimatScreen(),
    StoriesView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: PrimaryColors.Colorthree,
        backgroundColor: PrimaryColors.Colorfour,
        buttonBackgroundColor: PrimaryColors.Colorthree,
        height: 50,
        items: <Widget>[
          Icon(Icons.person, size: 30, color: PrimaryColors.Colortwo),
          Icon(Icons.home, size: 30, color: PrimaryColors.Colortwo),
          Icon(Icons.qr_code_2, size: 30, color: PrimaryColors.Colortwo),
          Icon(Icons.movie, size: 30, color: PrimaryColors.Colortwo),
          Icon(Icons.video_call, size: 30, color: PrimaryColors.Colortwo),
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
