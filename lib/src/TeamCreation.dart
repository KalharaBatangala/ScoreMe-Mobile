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
  String _selectedTournamentType = "Cricket"; // Default tournament type
  final TextEditingController _tournamentNameController = TextEditingController();
  final TextEditingController _team1Controller = TextEditingController();
  final TextEditingController _team2Controller = TextEditingController();
  final TextEditingController _team3Controller = TextEditingController();
  final TextEditingController _team4Controller = TextEditingController();

  // Dummy backend URL (replace with actual endpoint)
  final String backendUrl = "https://your-backend-endpoint.com/createTournament";

  // Function to send data to the backend
  Future<void> _createTournament() async {
    String tournamentName = _tournamentNameController.text;
    String team1 = _team1Controller.text;
    String team2 = _team2Controller.text;
    String team3 = _team3Controller.text;
    String team4 = _team4Controller.text;

    if (tournamentName.isEmpty || team1.isEmpty || team2.isEmpty) {

      CustomSnackBar.show(
          context,
          message: 'All fields must be filled out!',
          backgroundColor: Colors.red);
      return;
    }

    final response = await http.post(
      Uri.parse(backendUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "tournamentType": _selectedTournamentType,
        "tournamentName": tournamentName,
        "teams": [team1, team2],
      }),
    );

    if (response.statusCode == 200) {

      CustomSnackBar.show(context,
          message: "$tournamentName created successfully!",
          backgroundColor: Colors.green);
      _tournamentNameController.clear();
      _team1Controller.clear();
      _team2Controller.clear();
      _team3Controller.clear();
      _team4Controller.clear();

      // Navigate to the next page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrganizerPage(
            tournamentType: _selectedTournamentType,
            tournamentName: tournamentName,
            Team1Name: team1,
            Team2Name: team2,
            // tournamentName: tournamentName,
            // team1: team1,
            // team2: team2,
          ),
        ),
      );
    } else {

      CustomSnackBar.show(context,
          message: "Failed to create tournament. Try again.",
          backgroundColor: Colors.red);
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
          "Create Tournament",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Create a Tournament",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _selectedTournamentType,
                items: ["Cricket", "Football", "Volleyball", "Badminton"]
                    .map((type) => DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTournamentType = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Select Tournament Type",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _tournamentNameController,
                decoration: InputDecoration(
                  labelText: "Enter Tournament Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _team1Controller,
                decoration: InputDecoration(
                  labelText: "Enter Team 1 Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _team2Controller,
                decoration: InputDecoration(
                  labelText: "Enter Team 2 Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
          
              TextField(
                controller: _team3Controller,
                decoration: InputDecoration(
                  labelText: "Enter Team 3 Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
          
          
              TextField(
                controller: _team4Controller,
                decoration: InputDecoration(
                  labelText: "Enter Team 4 Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              
          
              ElevatedButton(
                onPressed: _createTournament,
                child: Text("Create Tournament", style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class OrganizerPage extends StatelessWidget {
//   final String tournamentName;
//   final String team1;
//   final String team2;
//
//   OrganizerPage({
//     required this.tournamentName,
//     required this.team1,
//     required this.team2,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Organizer Page"),
//         backgroundColor: primaryColor,
//       ),
//       body: Center(
//         child: Text(
//           "Tournament: $tournamentName\nTeam 1: $team1\nTeam 2: $team2",
//           textAlign: TextAlign.center,
//           style: TextStyle(fontSize: 18.0),
//         ),
//       ),
//     );
//   }
// }
