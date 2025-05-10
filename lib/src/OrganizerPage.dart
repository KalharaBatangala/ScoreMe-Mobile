import 'package:flutter/material.dart';


class OrganizerPage extends StatefulWidget {
  @override
  _OrganizerPageState createState() => _OrganizerPageState();
}

class _OrganizerPageState extends State<OrganizerPage> {
  final List<String> _battingTeam = [];
  final List<String> _bowlingTeam = [];
  final TextEditingController _playerNameController = TextEditingController();

  void _addPlayer(String teamType) {
    if (_playerNameController.text.isNotEmpty) {
      setState(() {
        if (teamType == "Batting") {
          _battingTeam.add(_playerNameController.text);
        } else {
          _bowlingTeam.add(_playerNameController.text);
        }
      });
      _playerNameController.clear();
    }
  }

  Widget _buildTeamList(String title, List<String> team) {
    return Expanded(
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: team.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(team[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Organizer'),
        backgroundColor: const Color(0xFF000435),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _playerNameController,
              decoration: InputDecoration(
                labelText: 'Enter Player Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => _addPlayer("Batting"),
                  child: Text('Add to Batting Team'),
                ),
                ElevatedButton(
                  onPressed: () => _addPlayer("Bowling"),
                  child: Text('Add to Bowling Team'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _buildTeamList('Batting Team', _battingTeam),
                const SizedBox(width: 10),
                _buildTeamList('Bowling Team', _bowlingTeam),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
