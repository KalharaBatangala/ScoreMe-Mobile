import 'package:flutter/material.dart';
const Color primaryColor = Color(0xFF000435);



class SignUpButton extends StatefulWidget {
  final Function onPageReady; // Callback for navigation or action
  final String buttonText;
  const SignUpButton({Key? key, required this.onPageReady, required this.buttonText}) : super(key: key);

  @override
  _SignUpButtonState createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  bool _isLoading = false;

  void _startLoading() async {
    setState(() {
      _isLoading = true; // Show loading animation
    });

    // Simulate some delay (e.g., fetching data or loading resources)
    await Future.delayed(Duration(milliseconds:300 ));

    setState(() {
      _isLoading = false; // Reset to initial state
    });

    // Notify parent that loading is complete
    widget.onPageReady();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160.0,
      child: ElevatedButton(
        onPressed: _isLoading
            ? null // Disable button while loading
            : _startLoading,
        style: ElevatedButton.styleFrom(
            elevation: 3,
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            backgroundColor: primaryColor.withBlue(350)
        ),
        child: _isLoading
            ? SizedBox(
          height: 24.0,
          width: 24.0,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 5.0,
          ),
        )
            : Text(
          widget.buttonText,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white ),
        ),
      ),
    );

  }
}
