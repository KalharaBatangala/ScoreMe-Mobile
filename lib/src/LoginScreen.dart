import 'package:flutter/material.dart';
import 'package:fypmobile/src/OrganizerPage.dart';
import 'package:fypmobile/src/UserSelectionPage.dart';
import 'package:fypmobile/src/components/LoginButton.dart';
import '../main.dart';
import 'package:fypmobile/src/components/SnackBar.dart';
import 'package:fypmobile/src/SignUpScreen.dart';

//primary color theme of the app
const Color primaryColor = Color(0xFF000435);

Future<bool> _performLogin() async {
  // Simulate a login process (Replace this with actual authentication logic)
  await Future.delayed(Duration(seconds: 0)); // Simulate network delay
  return true; // Return true for success, false for failure
}



class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,  //Navy blue as primary color
        title: Text('Login',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),


      // Body - Email & Password Text fields
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),


            LoginButton(
                onPageReady: () async {

                  bool loginSuccess = await _performLogin();
                  if (loginSuccess) {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => UserSelectionPage(),
                      ),
                    );

                  } else
                  {

                    // Show error Snackbar immediately
                    // Using the widget method
                    CustomSnackBar.show(
                      context,
                      message: "Login Failed!",
                      backgroundColor: Colors.red,
                      icon: Icons.error,
                    );
                  }
                },


                buttonText: 'Login'),


            SizedBox(height: 10),




          ],
        ),
      ),
    );
  }
}