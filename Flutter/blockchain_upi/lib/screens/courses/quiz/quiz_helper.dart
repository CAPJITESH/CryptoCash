import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answerText;
  final Color? borderColor;
  final VoidCallback answerTap;

  Answer({
    required this.answerText,
    required this.borderColor,
    required this.answerTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: answerTap,
      child: Container(
        padding: EdgeInsets.all(15.0),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 3,
            color: borderColor ?? Colors.white, // Use borderColor if available, else use default
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                answerText,
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ),
            borderColor == Colors.red
                ? Icon(Icons.cancel_outlined, color: borderColor ?? Colors.white)
                : Icon(Icons.check_circle_outline_rounded, color: borderColor ?? Colors.white),
          ],
        ),
      ),
    );
  }
}