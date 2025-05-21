import 'package:flutter/material.dart';
import 'package:fypmobile/src/Dashboard.dart';
import 'TeamSelectionPage.dart';
import 'package:fypmobile/src/components/StartButton.dart';
import 'package:fypmobile/src/LiveScorePage.dart';

class OTPVerificationPage extends StatefulWidget {
  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification',
        style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: const Color(0xFF000435),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _otpController,
                decoration: InputDecoration(
                  labelText: 'Enter OTP',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 20),

            // OTP verification button
            StartButton(
                buttonText: 'Verify',
                onPageReady: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => DashboardPage()),
              );
            }),
          ],
        ),
      ),
    );
  }
}
