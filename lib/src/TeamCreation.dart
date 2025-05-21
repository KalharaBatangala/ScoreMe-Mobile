import 'package:flutter/material.dart';
import 'package:fypmobile/src/components/SnackBar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON encoding
import 'package:fypmobile/src/OrganizerPage.dart';

const Color primaryColor = Color(0xFF000435);

class TeamCreationPage extends StatefulWidget {
  @override
  _TeamCreationPageState createState() => _TeamCreationPageState();
}

class _TeamCreationPageState extends State<TeamCreationPage> {
  String _selectedTeamType = "Batting Team"; // Default value
  final TextEditingController _teamNameController = TextEditingController();

  //Variables
  String teamName = '';


  // Dummy backend URL (replace with actual endpoint)
  final String backendUrl = "https://your-backend-endpoint.com/createTeam";

  // Function to send data to the backend
  Future<void> _createTeam() async {
    teamName = _teamNameController.text;
    if (teamName.isEmpty) {
      CustomSnackBar.show(
          context,
          message: 'Team name cannot be empty!',
          backgroundColor: Colors.red);
      return;
    }

    final response = await http.post(
      Uri.parse(backendUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "teamName": teamName,
        "teamType": _selectedTeamType == "Batting Team" ? "batting" : "bowling",
      }),
    );

    if (response.statusCode == 200) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("$teamName ($_selectedTeamType) created successfully!")),
      // );
      CustomSnackBar.show(
          context,
          message:"$teamName ($_selectedTeamType) created successfully!" ,
          backgroundColor: Colors.green);
      _teamNameController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to create team. Try again.")),
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
            "Create Team",
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
              "Create a Team",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedTeamType,
              items: ["Batting Team", "Bowling Team"]
                  .map((type) => DropdownMenuItem<String>(
                value: type,
                child: Text(type),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedTeamType = value!;
                });
              },
              decoration: InputDecoration(
                labelText: "Select Team Type",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _teamNameController,
              decoration: InputDecoration(
                labelText: "Enter Team Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _createTeam,
              child: Text("Create Team"),
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to Organizer Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrganizerPage(TeamName: teamName,)),
                );
              },
              child: Text("Go to Organizer Page"),
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
