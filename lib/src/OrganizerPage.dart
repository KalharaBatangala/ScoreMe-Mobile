import 'package:flutter/material.dart';
import 'package:fypmobile/src/components/StartButton.dart';
import 'dart:convert'; // For JSON encoding
import 'package:http/http.dart' as http;
import 'package:fypmobile/src/components/SnackBar.dart';

const Color primaryColor = Color(0xFF000435);

class OrganizerPage extends StatefulWidget {
  final String? TeamName;
  bool isBatting = false;

  // Constructor to pass arguements
  OrganizerPage({required this.TeamName});

  @override
  _OrganizerPageState createState() => _OrganizerPageState(TeamName: TeamName);
}

class _OrganizerPageState extends State<OrganizerPage> {
  final TextEditingController _battingPlayerController = TextEditingController();
  final TextEditingController _bowlingPlayerController = TextEditingController();

  final String? TeamName;

  _OrganizerPageState({required this.TeamName});

  // Dummy backend URL (replace with actual endpoint)
  final String backendUrl = "https://your-backend-endpoint.com/addPlayer";

  // Function to send data to the backend
  Future<void> _addPlayer(String playerName, String teamType) async {
    if (playerName.isEmpty) {
      CustomSnackBar.show(
        context,
        message: "Player name cannot be empty!",
        backgroundColor: Colors.red,
      );

      return;
    }

    final response = await http.post(
      Uri.parse(backendUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "playerName": playerName,
        "teamType": teamType, // "batting" or "bowling"
      }),
    );

    if (response.statusCode == 200) {
      // Show a cutom snackbar if player adding was successful
      CustomSnackBar.show(
        context,
        message: "$playerName added to $teamType team successfully!",
        backgroundColor: Colors.green,);
      if (teamType == "batting") {
        _battingPlayerController.clear();
      } else {
        _bowlingPlayerController.clear();
      }
    } else {
      // Show a cutom snackbar if player adding was failed !
      CustomSnackBar.show(
        context,
        message: "Failed to add player. Try again.",
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
            "Add Players",
        style: TextStyle(
          color: Colors.white,
        ),),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),


      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add Players to $TeamName",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _battingPlayerController,
              decoration: InputDecoration(
                labelText: "Enter Player Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8.0),
            // ElevatedButton(
            //   onPressed: () => _addPlayer(_battingPlayerController.text, "batting"),
            //   child: Text(
            //     "Add to Batting Team",
            //     style: TextStyle(
            //         color: Colors.white),
            //     ),
            //   style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            // ),


            StartButton(onPageReady: () => _addPlayer(_battingPlayerController.text, "batting"), buttonText: "Add Player to $TeamName"),

            Divider(thickness: 1.5),
            SizedBox(height: 16.0),

            // Text(
            //   "Add Players to Bowling Team",
            //   style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            // ),
            // SizedBox(height: 8.0),
            // TextField(
            //   controller: _bowlingPlayerController,
            //   decoration: InputDecoration(
            //     labelText: "Enter Player Name",
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            // SizedBox(height: 8.0),
            // ElevatedButton(
            //   onPressed: () => _addPlayer(_bowlingPlayerController.text, "bowling"),
            //   child: Text(
            //       "Add to Bowling Team",
            //   style: TextStyle(color: Colors.white),),
            //   style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            // ),
          ],
        ),
      ),
    );
  }
}
