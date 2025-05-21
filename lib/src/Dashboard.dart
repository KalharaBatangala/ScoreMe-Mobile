import 'package:flutter/material.dart';
import 'package:fypmobile/src/LiveScorePage.dart';
import 'package:fypmobile/src/MatchSummary.dart';
import 'package:fypmobile/src/OrganizerPage.dart';
import 'package:fypmobile/src/TeamCreation.dart';
import 'package:fypmobile/src/TeamSelectionPage.dart';
import 'package:fypmobile/src/TestingPage1.dart';


class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    //DashboardContentPage(), // First Tab
    //MatchHistoryPage(),     // Second Tab
    //RoleSelectionPage(),    //Third Tab
    Testingpage1(),
    TeamCreationPage(),
    TeamSelectionPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_rounded), label: "Add Players"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Select Role"),
        ],
      ),
    );
  }
}
