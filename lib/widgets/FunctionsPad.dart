import 'package:calculary/widgets/CalculatorButton.dart';
import 'package:flutter/material.dart';

class FunctionsPad extends StatelessWidget {
  FunctionsPad({
    Key? key,
    required this.addOperator,
    required this.addNumber,
  }) : super(key: key);

  final Function addOperator;
  final Function addNumber;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FunctionButton(
              text: 'TIP',
              textColor: Color.fromRGBO(114, 114, 114, 1),
              textSize: 16,
              buttonColor: Color.fromRGBO(249, 220, 197, 1),
              callback: addOperator
            ),
            FunctionButton(
              text: 'PROM',
              textColor: Color.fromRGBO(114, 114, 114, 1),
              textSize: 14,
              buttonColor: Color.fromRGBO(249, 220, 197, 1),
              callback: addOperator
            ),
            FunctionButton(
              text: '!',
              textColor: Color.fromRGBO(114, 114, 114, 1),
              textSize: 22,
              buttonColor: Color.fromRGBO(249, 220, 197, 1),
              callback: addOperator
            ),
            FunctionButton(
              text: 'Sqrt',
              textColor: Color.fromRGBO(114, 114, 114, 1),
              textSize: 16,
              buttonColor: Color.fromRGBO(249, 220, 197, 1),
              callback: addOperator
            ),
            FunctionButton(
              text: '^',
              textColor: Color.fromRGBO(114, 114, 114, 1),
              textSize: 22,
              buttonColor: Color.fromRGBO(249, 220, 197, 1),
              callback: addOperator
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FunctionButton(
              text: 'pi',
              textColor: Color.fromRGBO(114, 114, 114, 1),
              textSize: 22,
              buttonColor: Color.fromRGBO(249, 220, 197, 1),
              callback: addNumber
            ),
            FunctionButton(
              text: 'e',
              textColor: Color.fromRGBO(114, 114, 114, 1),
              textSize: 22,
              buttonColor: Color.fromRGBO(249, 220, 197, 1),
              callback: addNumber
            ),
            FunctionButton(
              text: '%',
              textColor: Color.fromRGBO(114, 114, 114, 1),
              textSize: 22,
              buttonColor: Color.fromRGBO(249, 220, 197, 1),
              callback: addOperator
            ),
            FunctionButton(
              text: '(',
              textColor: Color.fromRGBO(114, 114, 114, 1),
              textSize: 22,
              buttonColor: Color.fromRGBO(249, 220, 197, 1),
              callback: addOperator
            ),
            FunctionButton(
              text: ')',
              textColor: Color.fromRGBO(114, 114, 114, 1),
              textSize: 22,
              buttonColor: Color.fromRGBO(249, 220, 197, 1),
              callback: addOperator
            ),
          ],
        ),
        SizedBox(height: 10)
      ],
    );
  }
}