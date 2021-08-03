import 'package:flutter/material.dart';

class NumberButton extends StatelessWidget {
  NumberButton({
    Key? key,
    required this.text,
    required this.textColor,
    required this.textSize,
    required this.buttonColor,
    required this.callback,
  }) : super(key: key);

  final String text;
  final Color textColor;
  final double textSize;
  final Color buttonColor;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: SizedBox(
        width: 60,
        height: 60,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            )
          ),
          onPressed: () {
            callback(text);
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
  }) : super(key: key);

  final String text;
  final Color textColor;
  final double textSize;
  final Color buttonColor;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: SizedBox(
        width: 60,
        height: 60,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )
          ),
          onPressed: () {
            callback(text);
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
  }) : super(key: key);

  final String text;
  final Color textColor;
  final double textSize;
  final Color buttonColor;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: SizedBox(
        width: 130,
        height: 60,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )
          ),
          onPressed: () {
            callback(text);
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