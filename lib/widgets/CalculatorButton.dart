import 'package:flutter/material.dart';

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
      margin: EdgeInsets.all(5),
      child: SizedBox(
        width: 62,
        height: 62,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            )
          ),
          onPressed: () {
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
      margin: EdgeInsets.all(5),
      child: SizedBox(
        width: 62,
        height: 62,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )
          ),
          onPressed: () {
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
      margin: EdgeInsets.all(5),
      child: SizedBox(
        width: 132,
        height: 62,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )
          ),
          onPressed: () {
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