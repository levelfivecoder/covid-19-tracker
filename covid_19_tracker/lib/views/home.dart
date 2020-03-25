import 'package:covid_19_tracker/views/dashboard.dart';
import 'package:covid_19_tracker/views/indiapage.dart';
import 'package:covid_19_tracker/views/mapui.dart';
import 'package:covid_19_tracker/views/sharepage.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Dashboard(Colors.white),
    MapUi(),
    IndiaPage(),
    SharePage()
  ];
  void onTabSelected(int selectedIndex) {
    setState(() {
      _currentIndex = selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF15191C),
      body: _children[_currentIndex],
      appBar: AppBar(
        backgroundColor: Color(0xFF121212),
        title: Text('Covid 19 Tracker'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF121212),
        selectedItemColor: Color(0xFFD15D1F),
        showUnselectedLabels: true,
        selectedFontSize: 20,
        currentIndex:
            _currentIndex, // this will be set when a new tab is tapped
        onTap: onTabSelected,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.dashboard),
            backgroundColor: Color(0xFF121212),
            title: new Text('Dashboard'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.map),
            backgroundColor: Color(0xFF121212),
            title: new Text('Map'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.assessment),
            title: new Text('India'),
            backgroundColor: Color(0xFF121212),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.info),
              backgroundColor: Color(0xFF121212),
              title: Text('About'))
        ],
      ),
    );
  }
}
