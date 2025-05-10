import 'package:flutter/material.dart';
import 'dart:async';

class LiveIndicator extends StatefulWidget {
  final Color color; // Color of the blinking indicator
  final String text; // Text to display next to the indicator
  final bool initialVisibility; // Initial visibility state

  LiveIndicator({
    required this.color,
    required this.text,
    this.initialVisibility = true,
  });

  @override
  _LiveIndicatorState createState() => _LiveIndicatorState();
}

class _LiveIndicatorState extends State<LiveIndicator> {
  late bool _isVisible;

  @override
  void initState() {
    super.initState();
    _isVisible = widget.initialVisibility;
    // Timer to toggle the visibility state every 500 milliseconds
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        _isVisible = !_isVisible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),
          child: Icon(
            Icons.circle,
            color: widget.color,
            size: 14,
          ),
        ),
        SizedBox(width: 8),
        Text(
          widget.text,
          style: TextStyle(
            color: widget.color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
