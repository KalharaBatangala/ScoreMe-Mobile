import 'package:flutter/material.dart';

Future<void> showUpdateDialog(BuildContext context, Function(String, String) onUpdate) {
  String selectedBowler = "Bowler 1"; // Default selection
  String selectedBatsman = "Batsman 1"; // Default selection

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Update Players"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<String>(
              value: selectedBowler,
              items: ["Bowler 1", "Bowler 2", "Bowler 3"].map((bowler) {
                return DropdownMenuItem(
                  value: bowler,
                  child: Text(bowler),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) selectedBowler = value;
              },
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: selectedBatsman,
              items: ["Batsman 1", "Batsman 2", "Batsman 3"].map((batsman) {
                return DropdownMenuItem(
                  value: batsman,
                  child: Text(batsman),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) selectedBatsman = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onUpdate(selectedBowler, selectedBatsman); // Pass back the selections
            },
            child: Text("Update"),
          ),
        ],
      );
    },
  );
}
