import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:text_recognition/provider/loading_provider.dart';
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
      activeColor: Colors.green,
    ),
    BottomNavyBarItem(
        icon: Icon(Icons.save),
        title: Text('Saved'),
        activeColor: Colors.green),
    BottomNavyBarItem(
        icon: Icon(Icons.settings),
        title: Text('Settings'),
        activeColor: Colors.green),
  ];

  List<Widget> _bodies = [HomePage(), Saved(), Settings()];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoadingProvider>(context);
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text("Text Recognition"),
            ),
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
          provider.isLoading
              ? Positioned.fill(
                  child: Container(
                  color: Colors.black.withOpacity(.9),
                  child:
                      Lottie.asset('assets/animations/9305-loading-bloob.zip'),
                ))
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
