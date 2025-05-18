import 'package:flutter/material.dart';
import 'package:fypmobile/src/components/ScoreUpdaterButton.dart';
import 'package:fypmobile/src/components/OrganizerButton.dart';
import 'OTPverificationPage.dart';
import 'OrganizerPage.dart';
import 'package:fypmobile/src/components/SnackBar.dart';


class UserSelectionPage extends StatefulWidget {
  @override
  _UserSelectionPageState createState() => _UserSelectionPageState();
}

class _UserSelectionPageState extends State<UserSelectionPage> {
  @override
  void initState() {
    super.initState();

    // Show the snackbar after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CustomSnackBar.show(
        context,
        message: "Login Successful!",   // Show the Login Successful
        backgroundColor: Colors.green,  // Custom SnackBar
        icon: Icons.check_circle,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Role',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF000435),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ScoreUpdaterButton(onPageReady:()
        {Navigator.of(context).push(MaterialPageRoute(builder: (context) => OTPVerificationPage()));}, buttonText: 'Score Updater'),


            const SizedBox(height: 20),

            OrganizerButton(onPageReady:()
            {Navigator.of(context).push(MaterialPageRoute(builder: (context) => OTPVerificationPage()));}, buttonText: 'Organizer'),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute(builder: (context) => OTPVerificationPage()),
            //     );
            //   },
            //   child: Text('Score Updater'),
            // ),

            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute(builder: (context) => OrganizerPage()),
            //     );
            //   },
            //   child: Text('Organizer'),
            // ),
          ],
        ),
      ),
    );
  }
}
