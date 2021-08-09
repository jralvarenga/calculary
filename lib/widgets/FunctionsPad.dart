import 'package:calculary/widgets/CalculatorButton.dart';
import 'package:flutter/material.dart';

class FunctionsPad extends StatelessWidget {
  FunctionsPad({
    Key? key,
    required this.addOperator,
    required this.addNumber,
    required this.addFunction,
  }) : super(key: key);

  final Function addOperator;
  final Function addNumber;
  final Function addFunction;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FunctionButton(
              text: 'TIP',
              value: 'TIP',
              textColor: Color.fromRGBO(114, 114, 114, 1),
              textSize: 16,
              buttonColor: Color.fromRGBO(249, 220, 197, 1),
              callback: addFunction
            ),
            FunctionButton(
              text: 'PROM',
              value: 'PROM',
              textColor: Color.fromRGBO(114, 114, 114, 1),
              textSize: 14,
              buttonColor: Color.fromRGBO(249, 220, 197, 1),
              callback: addFunction
            ),
            FunctionButton(
              text: '!',
              value: '!',
              textColor: Color.fromRGBO(114, 114, 114, 1),
              textSize: 22,
              buttonColor: Color.fromRGBO(249, 220, 197, 1),
              callback: addNumber
            ),
            FunctionButton(
              text: 'sqrt',
              value: 'sqrt',
              textColor: Color.fromRGBO(114, 114, 114, 1),
              textSize: 16,
              buttonColor: Color.fromRGBO(249, 220, 197, 1),
              callback: addFunction
            ),
            FunctionButton(
              text: '^',
              value: '^',
              textColor: Color.fromRGBO(114, 114, 114, 1),
              textSize: 22,
              buttonColor: Color.fromRGBO(249, 220, 197, 1),
              callback: addFunction
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FunctionButton(
              text: 'pi',
              value: '3.14159265',
              textColor: Color.fromRGBO(114, 114, 114, 1),
              textSize: 22,
              buttonColor: Color.fromRGBO(249, 220, 197, 1),
              callback: addNumber
            ),
            FunctionButton(
              text: 'e',
              value: '2.718281828',
              textColor: Color.fromRGBO(114, 114, 114, 1),
              textSize: 22,
              buttonColor: Color.fromRGBO(249, 220, 197, 1),
              callback: addNumber
            ),
            FunctionButton(
              text: '%',
              value: '%',
              textColor: Color.fromRGBO(114, 114, 114, 1),
              textSize: 22,
              buttonColor: Color.fromRGBO(249, 220, 197, 1),
              callback: addFunction
            ),
            FunctionButton(
              text: '(',
              value: '(',
              textColor: Color.fromRGBO(114, 114, 114, 1),
              textSize: 22,
              buttonColor: Color.fromRGBO(249, 220, 197, 1),
              callback: addNumber
            ),
            FunctionButton(
              text: ')',
              value: ')',
              textColor: Color.fromRGBO(114, 114, 114, 1),
              textSize: 22,
              buttonColor: Color.fromRGBO(249, 220, 197, 1),
              callback: addNumber
            ),
          ],
        ),
        SizedBox(height: 10)
      ],
    );
  }
}