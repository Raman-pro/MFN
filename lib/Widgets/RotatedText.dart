import 'package:flutter/material.dart';

class RotatedText extends StatelessWidget {
  const RotatedText({
    required this.text,
    this.style=const TextStyle(color: Colors.black, fontSize: 24),
    super.key,
  });
  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 2,
      child: Text(
        text,
        style: TextStyle(color: Colors.black, fontSize: 24),
      ),
    );
  }
}