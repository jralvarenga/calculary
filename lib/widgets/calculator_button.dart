import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberButton extends StatelessWidget {
  NumberButton({
    Key? key,
    required this.text,
    required this.textColor,
    required this.textSize,
    required this.buttonColor,
    required this.callback,
    required this.value,
  }) : super(key: key);

  final String text;
  final Color textColor;
  final double textSize;
  final Color buttonColor;
  final Function callback;
  final String value;

  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: EdgeInsets.all(2),
      child: SizedBox(
        width: 68,
        height: 68,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            )
          ),
          onPressed: () {
            HapticFeedback.lightImpact();
            callback(text, value);
          },
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: textSize,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}

// Function Button

class FunctionButton extends StatelessWidget {
  FunctionButton({
    Key? key,
    required this.text,
    required this.textColor,
    required this.textSize,
    required this.buttonColor,
    required this.callback,
    required this.value,
  }) : super(key: key);

  final String text;
  final Color textColor;
  final double textSize;
  final Color buttonColor;
  final Function callback;
  final String value;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(2),
      child: SizedBox(
        width: 68,
        height: 68,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )
          ),
          onPressed: () {
            HapticFeedback.lightImpact();
            callback(text, value);
          },
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: textSize,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}

// Function Button

class LargeFunctionButton extends StatelessWidget {
  LargeFunctionButton({
    Key? key,
    required this.text,
    required this.textColor,
    required this.textSize,
    required this.buttonColor,
    required this.callback,
    required this.value,
  }) : super(key: key);

  final String text;
  final Color textColor;
  final double textSize;
  final Color buttonColor;
  final Function callback;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      child: SizedBox(
        width: 140,
        height: 68,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )
          ),
          onPressed: () {
            HapticFeedback.lightImpact();
            if (value == 'enter') {
              callback();
            } else {
              callback(text, value);
            }
          },
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: textSize,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}