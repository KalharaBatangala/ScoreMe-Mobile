import 'package:flutter/material.dart';
import 'package:fypmobile/main.dart';
import 'package:fypmobile/src/UserSelectionPage.dart';

class Testingpage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
            "Testing Page 1",
        style: TextStyle(
          color: Colors.white,
        ),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              "This is a testing page only",
              style: TextStyle(fontSize: 24),
            ),
          ),
          FloatingActionButton(onPressed: ()=> {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => UserSelectionPage()),
                  (route) => false, // Removes all previous routes
            )
          }),
        ],
      ),
    );
  }
}
