import 'package:boti_blog/ui/colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;

  PrimaryButton({
    this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        onPressed: onPressed,
        padding: EdgeInsets.all(12),
        color: BotiBlogColors.oxleyDark,
        child: Text(
          this.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
