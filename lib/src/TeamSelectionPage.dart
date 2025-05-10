import 'package:flutter/material.dart';
import 'package:fypmobile/src/LiveScorePage.dart';
import 'components/StartButton.dart';
import 'package:fypmobile/src/components/SnackBar.dart';

//primary color theme of the app
const Color primaryColor = Color(0xFF000435);

class TeamSelectionPage extends StatefulWidget {
  @override
  _TeamSelectionPageState createState() => _TeamSelectionPageState();
}

class _TeamSelectionPageState extends State<TeamSelectionPage> {
  String? selectedTeam1;
  String? selectedTeam2;
  String? openBatsman;

  // List of team names
  final List<String> _teams1 = ['Team A', 'Team B', 'Team C', 'Team D']; // Team 1
  final List<String> _teams2 = ['Team A', 'Team B', 'Team C', 'Team D']; // Team 2

  bool _shouldShowUptime = true;

  void _startMatch() {
    if (selectedTeam1 == null || selectedTeam2 == null) {
      CustomSnackBar.show(
        context,
        message: "Select two Teams !",
        backgroundColor: Colors.red,
        icon: Icons.info,
      );
      return; // Prevent navigation
    }

    // Navigate to LiveScorePage if both teams are selected
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LiveScorePage(shouldShowUptime: _shouldShowUptime, battingTeam: selectedTeam1, bowlingTeam: selectedTeam2,),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Teams',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Team 1 Label
            Text(
              'Batting',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            // Team 1 Dropdown
            DropdownButtonFormField<String>(
              value: selectedTeam1,
              items: _teams1
                  .map(
                    (team) => DropdownMenuItem<String>(
                  value: team,
                  child: Text(team),
                ),
              )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedTeam1 = value!; // Selected team for Team 1
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
              ),
            ),
            SizedBox(height: 24.0),

            // Team 2 Label
            Text(
              'Bowling',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            // Team 2 Dropdown
            DropdownButtonFormField<String>(
              value: selectedTeam2,
              items: _teams2
                  .map(
                    (team) => DropdownMenuItem<String>(
                  value: team,
                  child: Text(team),
                ),
              )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedTeam2 = value!; // Selected team for Team 2
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
              ),
            ),
            SizedBox(height: 24.0),

            // Uptime Toggle Button
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Show Uptime',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    Switch(
                      value: _shouldShowUptime,
                      onChanged: (value) {
                        setState(() {
                          _shouldShowUptime = value; // Toggle uptime state
                        });
                      },
                      activeColor: primaryColor,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.0),

            // Match Start Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StartButton(
                  buttonText: 'Start',
                  onPageReady: _startMatch, // Validate selections and navigate
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
