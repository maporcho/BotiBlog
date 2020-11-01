import 'package:boti_blog/ui/colors.dart';
import 'package:flutter/material.dart';

class BotiFlatButton extends StatelessWidget {
  final String text;

  final VoidCallback onPressed;

  const BotiFlatButton(
    this.text, {
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        text,
        style: TextStyle(
          color: BotiBlogColors.oxleyDark,
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          decoration: TextDecoration.underline,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
