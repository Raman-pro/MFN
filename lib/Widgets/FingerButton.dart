import 'package:flutter/material.dart';
import 'RotatedText.dart';

class FingerButton extends StatelessWidget {
  const FingerButton({super.key,required this.onPressed});
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(padding: EdgeInsetsGeometry.all(25)),
      onPressed:onPressed,
      child: RotatedText(text:'Show Finger'),
    );
  }
}
