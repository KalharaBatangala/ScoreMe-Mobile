import 'package:flutter/material.dart';

class MatchSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Match Summary"),
      ),
      body: Center(
        child: Text(
          "Match Summary Content Goes Here",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
