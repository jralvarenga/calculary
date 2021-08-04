import 'package:calculary/widgets/CalculatorButton.dart';
import 'package:flutter/material.dart';

class NumberPad extends StatelessWidget {
  NumberPad({
    Key? key,
    required this.addNumber,
    required this.addOperator,
    required this.deleteFromExpretion,
    required this.deleteAllInput,
    required this.enterExpretion,
  }) : super(key: key);

  final Function addNumber;
  final Function addOperator;
  final Function deleteFromExpretion;
  final Function enterExpretion;
  final Function deleteAllInput;

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
              value: '7',
              textColor: Color.fromRGBO(0, 0, 0, 1),
              textSize: 20,
              buttonColor: Color.fromRGBO(227, 227, 227, 1),
              callback: addNumber
            ),
            NumberButton(
              text: '8',
              value: '8',
              textColor: Color.fromRGBO(0, 0, 0, 1),
              textSize: 20,
              buttonColor: Color.fromRGBO(227, 227, 227, 1),
              callback: addNumber
            ),
            NumberButton(
              text: '9',
              value: '9',
              textColor: Color.fromRGBO(0, 0, 0, 1),
              textSize: 20,
              buttonColor: Color.fromRGBO(227, 227, 227, 1),
              callback: addNumber
            ),
            FunctionButton(
              text: '/',
              value: '/',
              textColor: Color.fromRGBO(114, 114, 114, 1),
              textSize: 22,
              buttonColor: Color.fromRGBO(249, 220, 197, 1),
              callback: addOperator
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: SizedBox(
                width: 60,
                height: 60,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromRGBO(210, 155, 253, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )
                  ),
                  onLongPress: () {
                    deleteAllInput();
                  },
                  onPressed: () {
                    deleteFromExpretion();
                  },
                  child: Text(
                    'DEL',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NumberButton(
              text: '4',
              value: '4',
              textColor: Color.fromRGBO(0, 0, 0, 1),
              textSize: 20,
              buttonColor: Color.fromRGBO(227, 227, 227, 1),
              callback: addNumber
            ),
            NumberButton(
              text: '5',
              value: '5',
              textColor: Color.fromRGBO(0, 0, 0, 1),
              textSize: 20,
              buttonColor: Color.fromRGBO(227, 227, 227, 1),
              callback: addNumber
            ),
            NumberButton(
              text: '6',
              value: '6',
              textColor: Color.fromRGBO(0, 0, 0, 1),
              textSize: 20,
              buttonColor: Color.fromRGBO(227, 227, 227, 1),
              callback: addNumber
            ),
            FunctionButton(
              text: '-',
              value: '-',
              textColor: Color.fromRGBO(114, 114, 114, 1),
              textSize: 22,
              buttonColor: Color.fromRGBO(249, 220, 197, 1),
              callback: addOperator
            ),
            FunctionButton(
              text: 'x',
              value: '*',
              textColor: Color.fromRGBO(114, 114, 114, 1),
              textSize: 22,
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
              value: '1',
              textColor: Color.fromRGBO(0, 0, 0, 1),
              textSize: 20,
              buttonColor: Color.fromRGBO(227, 227, 227, 1),
              callback: addNumber
            ),
            NumberButton(
              text: '2',
              value: '2',
              textColor: Color.fromRGBO(0, 0, 0, 1),
              textSize: 20,
              buttonColor: Color.fromRGBO(227, 227, 227, 1),
              callback: addNumber
            ),
            NumberButton(
              text: '3',
              value: '3',
              textColor: Color.fromRGBO(0, 0, 0, 1),
              textSize: 20,
              buttonColor: Color.fromRGBO(227, 227, 227, 1),
              callback: addNumber
            ),
            LargeFunctionButton(
              text: '+',
              value: '+',
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
              value: '0',
              textColor: Color.fromRGBO(0, 0, 0, 1),
              textSize: 20,
              buttonColor: Color.fromRGBO(227, 227, 227, 1),
              callback: addNumber
            ),
            NumberButton(
              text: '.',
              value: '.',
              textColor: Color.fromRGBO(0, 0, 0, 1),
              textSize: 20,
              buttonColor: Color.fromRGBO(227, 227, 227, 1),
              callback: addNumber
            ),
            LargeFunctionButton(
              text: '=',
              value: 'enter',
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