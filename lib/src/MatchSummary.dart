import 'package:flutter/material.dart';
import 'package:fypmobile/src/Dashboard.dart';
import 'package:fypmobile/src/UserSelectionPage.dart';

class MatchSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Match Summary"),
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              "Match Summary Content Goes Here",
              style: TextStyle(fontSize: 24),
            ),

          ),
          FloatingActionButton(onPressed: ()=> {
          Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage()),
          (route) => false, // Removes all previous routes
          )
          }),
        ],
      ),
    );
  }
}
