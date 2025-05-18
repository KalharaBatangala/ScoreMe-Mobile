import 'package:flutter/material.dart';

class PauseButton extends StatefulWidget {
  final Function onPauseToggle; // Callback for pause/resume action
  final bool isPaused; // Status to track if it's paused
  final String buttonText; // Text for the button
  final Color buttonColor; // Background color of the button
  final IconData buttonIcon; // Icon to display on the button

  const PauseButton({
    Key? key,
    required this.onPauseToggle,
    required this.isPaused,
    required this.buttonText,
    required this.buttonColor,
    required this.buttonIcon,
  }) : super(key: key);

  @override
  _PauseButtonState createState() => _PauseButtonState();
}

class _PauseButtonState extends State<PauseButton> {
  bool _isLoading = false;

  void _togglePause() async {
    setState(() {
      _isLoading = true; // Show loading animation
    });

    // Simulate delay (e.g., handling pause/resume logic)
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _isLoading = false; // Reset loading state
    });

    // Notify parent to handle pause/resume action
    widget.onPauseToggle();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0,
      child: ElevatedButton(
        onPressed: _isLoading
            ? null // Disable button while loading
            : _togglePause,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.buttonColor,
          elevation: 4,
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
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
            : Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.buttonIcon,
              color: Colors.white,
            ),
            SizedBox(width: 8.0),
            Text(
              widget.buttonText,
              style: TextStyle(
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
