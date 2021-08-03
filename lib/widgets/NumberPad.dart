import 'package:calculary/widgets/CalculatorButton.dart';
import 'package:flutter/cupertino.dart';

class NumberPad extends StatelessWidget {
  NumberPad({
    Key? key,
    required this.addNumber,
    required this.addOperator,
    required this.deleteFromExpretion,
    required this.enterExpretion,
  }) : super(key: key);

  final Function addNumber;
  final Function addOperator;
  final Function deleteFromExpretion;
  final Function enterExpretion;

  void addFunction(String function) {
    print(function);
  }
  
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NumberButton(
              text: '7',
              textColor: Color.fromRGBO(0, 0, 0, 1),
              textSize: 18,
              buttonColor: Color.fromRGBO(227, 227, 227, 1),
              callback: addNumber
            ),
            NumberButton(
              text: '8',
              textColor: Color.fromRGBO(0, 0, 0, 1),
              textSize: 18,
              buttonColor: Color.fromRGBO(227, 227, 227, 1),
              callback: addNumber
            ),
            NumberButton(
              text: '9',
              textColor: Color.fromRGBO(0, 0, 0, 1),
              textSize: 18,
              buttonColor: Color.fromRGBO(227, 227, 227, 1),
              callback: addNumber
            ),
            FunctionButton(
              text: '/',
              textColor: Color.fromRGBO(114, 114, 114, 1),
              textSize: 22,
              buttonColor: Color.fromRGBO(249, 220, 197, 1),
              callback: addOperator
            ),
            FunctionButton(
              text: 'DEL',
              textColor: Color.fromRGBO(255, 255, 255, 1),
              textSize: 16,
              buttonColor: Color.fromRGBO(210, 155, 253, 1),
              callback: deleteFromExpretion
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NumberButton(
              text: '4',
              textColor: Color.fromRGBO(0, 0, 0, 1),
              textSize: 18,
              buttonColor: Color.fromRGBO(227, 227, 227, 1),
              callback: addNumber
            ),
            NumberButton(
              text: '5',
              textColor: Color.fromRGBO(0, 0, 0, 1),
              textSize: 18,
              buttonColor: Color.fromRGBO(227, 227, 227, 1),
              callback: addNumber
            ),
            NumberButton(
              text: '6',
              textColor: Color.fromRGBO(0, 0, 0, 1),
              textSize: 18,
              buttonColor: Color.fromRGBO(227, 227, 227, 1),
              callback: addNumber
            ),
            FunctionButton(
              text: '-',
              textColor: Color.fromRGBO(114, 114, 114, 1),
              textSize: 22,
              buttonColor: Color.fromRGBO(249, 220, 197, 1),
              callback: addOperator
            ),
            FunctionButton(
              text: 'x',
              textColor: Color.fromRGBO(114, 114, 114, 1),
              textSize: 16,
              buttonColor: Color.fromRGBO(249, 220, 197, 1),
              callback: addOperator
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NumberButton(
              text: '1',
              textColor: Color.fromRGBO(0, 0, 0, 1),
              textSize: 18,
              buttonColor: Color.fromRGBO(227, 227, 227, 1),
              callback: addNumber
            ),
            NumberButton(
              text: '2',
              textColor: Color.fromRGBO(0, 0, 0, 1),
              textSize: 18,
              buttonColor: Color.fromRGBO(227, 227, 227, 1),
              callback: addNumber
            ),
            NumberButton(
              text: '3',
              textColor: Color.fromRGBO(0, 0, 0, 1),
              textSize: 18,
              buttonColor: Color.fromRGBO(227, 227, 227, 1),
              callback: addNumber
            ),
            LargeFunctionButton(
              text: '+',
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
            LargeFunctionButton(
              text: '0',
              textColor: Color.fromRGBO(0, 0, 0, 1),
              textSize: 18,
              buttonColor: Color.fromRGBO(227, 227, 227, 1),
              callback: addNumber
            ),
            NumberButton(
              text: '.',
              textColor: Color.fromRGBO(0, 0, 0, 1),
              textSize: 18,
              buttonColor: Color.fromRGBO(227, 227, 227, 1),
              callback: addNumber
            ),
            LargeFunctionButton(
              text: '=',
              textColor: Color.fromRGBO(255, 255, 255, 1),
              textSize: 22,
              buttonColor: Color.fromRGBO(210, 155, 253, 1),
              callback: enterExpretion
            ),
          ],
        ),
      ],
    );
  }
}