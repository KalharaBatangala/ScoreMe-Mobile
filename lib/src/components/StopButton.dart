import 'package:flutter/material.dart';

//Primary color of the application
const Color primaryColor = Color(0xFF000435);

class StopButton extends StatefulWidget {
  final Function onStopPressed; // Callback for stop action
  final String buttonText; // Text for the button
  final Color buttonColor; // Background color of the button
  final IconData buttonIcon; // Icon to display on the button

  const StopButton({
    Key? key,
    required this.onStopPressed,
    required this.buttonText,
    required this.buttonColor,
    required this.buttonIcon,
  }) : super(key: key);

  @override
  _StopButtonState createState() => _StopButtonState();
}

class _StopButtonState extends State<StopButton> {
  bool _isLoading = false;

  void _handleStopAction() async {
    setState(() {
      _isLoading = true; // Show loading animation
    });

    // Simulate delay (if needed for processing stop logic)
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false; // Reset loading state
    });

    // Notify parent to handle stop action
    widget.onStopPressed();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.0,
      child: ElevatedButton(
        onPressed: _isLoading
            ? null // Disable button while loading
            : _handleStopAction,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.buttonColor,
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
          height: 24.0,
          width: 24.0,
          child: CircularProgressIndicator(
            color: primaryColor,
            strokeWidth: 5.0,
          ),
        )
            : Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.buttonIcon,
              color: Colors.white,
            ),
            const SizedBox(width: 8.0),
            Text(
              widget.buttonText,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
