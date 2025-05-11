import 'package:flutter/material.dart';
import 'package:fypmobile/src/LiveScorePage.dart';
import 'components/StartButton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fypmobile/src/components/SnackBar.dart';
import 'package:fypmobile/src/components/RefreshButton.dart';

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
  bool isLoading = false;



  List<String> teams = [];

  bool _shouldShowUptime = true;

  Future<void> fetchTeams() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 3));

    try {
      final response =
      await http.get(Uri.parse('http://192.168.1.100:3000/teams'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          teams = data.map((team) => team['name'] as String).toList();
        });
      } else {
        print('Failed to load teams');
      }
    } catch (e) {
      print('Error fetching teams: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTeams();
  }


  void _startMatch() {
    if (selectedTeam1 == null || selectedTeam2 == null) {
      CustomSnackBar.show(
        context,                                // Check if
        message: "Select two Teams !",         // any team is missing
        backgroundColor: Colors.red,
        icon: Icons.info,
      );
      return; // Prevent navigation
    }
    if (selectedTeam1 == selectedTeam2) {
      CustomSnackBar.show(
        context,                                // Check if the
        message: "Same Team cannot be used",    // same team is selected
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
            isLoading? Center(child: CircularProgressIndicator(color: Colors.amberAccent,),):
            DropdownButtonFormField<String>(
              value: selectedTeam1,
              items: teams
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
            )
    ,
            SizedBox(height: 24.0),

            // Team 2 Label
            Text(
              'Bowling',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            // Team 2 Dropdown
            isLoading? Center(child: CircularProgressIndicator(color: Colors.amberAccent,),):
            DropdownButtonFormField<String>(
              value: selectedTeam2,
              items: teams
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

            // Match Start Button & Refresh Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RefreshButton(onPageReady: fetchTeams, buttonText: 'Refresh',),

                SizedBox(height: 24.0, width: 40.0,),

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
