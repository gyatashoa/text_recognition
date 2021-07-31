import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:text_recognition/ui/homepage.dart';
import 'package:text_recognition/ui/saved.dart';
import 'package:text_recognition/ui/settings.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<BottomNavyBarItem> _items = [
    BottomNavyBarItem(
      icon: Icon(Icons.home),
      title: Text('Home'),
      activeColor: Colors.blue,
    ),
    BottomNavyBarItem(
        icon: Icon(Icons.save),
        title: Text('Pinned'),
        activeColor: Colors.blue),
    BottomNavyBarItem(
        icon: Icon(Icons.settings),
        title: Text('Settings'),
        activeColor: Colors.blue),
  ];

  List<Widget> _bodies = [HomePage(), Saved(), Settings()];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: _bodies[_currentIndex],
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          items: _items,
          onItemSelected: (int value) {
            setState(() {
              _currentIndex = value;
            });
          },
        ),
      ),
    );
  }
}
