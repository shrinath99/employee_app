import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  final bool active;
  final VoidCallback onTap;
  final String text;

  const ToggleButton(
      {super.key,
      required this.active,
      required this.onTap,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: active ? Colors.blue : Color(0xffEDF8FF),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.0,
            color: active ? Colors.white : Colors.blue,
          ),
        ),
      ),
    );
  }
}
