import 'package:boti_blog/ui/colors.dart';
import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;

  DeleteButton({
    this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: OutlineButton(
        borderSide: BorderSide(
          color: BotiBlogColors.red,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        onPressed: onPressed,
        padding: EdgeInsets.all(12),
        child: Text(
          this.title,
          style: TextStyle(
            color: BotiBlogColors.red,
          ),
        ),
      ),
    );
  }
}
