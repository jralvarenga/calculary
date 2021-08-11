import 'package:calculary/widgets/CalculatorButton.dart';
import 'package:flutter/material.dart';

class FunctionsPad extends StatelessWidget {
  FunctionsPad({
    Key? key,
    required this.addOperator,
    required this.addNumberExpression,
    required this.addGlobalFunction,
  }) : super(key: key);

  final Function addOperator;
  final Function addNumberExpression;
  final Function addGlobalFunction;

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Row(
                    children: [
                      // Main functions
                      FunctionButton(
                        text: 'TIP',
                        value: 'Tip',
                        textColor: Color.fromRGBO(114, 114, 114, 1),
                        textSize: 16,
                        buttonColor: Color.fromRGBO(249, 220, 197, 1),
                        callback: addGlobalFunction
                      ),
                      FunctionButton(
                        text: 'AVG',
                        value: 'Average',
                        textColor: Color.fromRGBO(114, 114, 114, 1),
                        textSize: 14,
                        buttonColor: Color.fromRGBO(249, 220, 197, 1),
                        callback: addGlobalFunction
                      ),
                      FunctionButton(
                        text: '!',
                        value: '!',
                        textColor: Color.fromRGBO(114, 114, 114, 1),
                        textSize: 22,
                        buttonColor: Color.fromRGBO(249, 220, 197, 1),
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: 'sqrt',
                        value: 'sqrt(',
                        textColor: Color.fromRGBO(114, 114, 114, 1),
                        textSize: 16,
                        buttonColor: Color.fromRGBO(249, 220, 197, 1),
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: '^',
                        value: '^(',
                        textColor: Color.fromRGBO(114, 114, 114, 1),
                        textSize: 22,
                        buttonColor: Color.fromRGBO(249, 220, 197, 1),
                        callback: addNumberExpression
                      ),

                      // Other functions
                      FunctionButton(
                        text: 'RAND',
                        value: 'rand',
                        textColor: Color.fromRGBO(114, 114, 114, 1),
                        textSize: 16,
                        buttonColor: Color.fromRGBO(249, 220, 197, 1),
                        callback: addGlobalFunction
                      ),
                      FunctionButton(
                        text: 'exp',
                        value: 'exp(',
                        textColor: Color.fromRGBO(114, 114, 114, 1),
                        textSize: 20,
                        buttonColor: Color.fromRGBO(249, 220, 197, 1),
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: 'sin',
                        value: 'sin(',
                        textColor: Color.fromRGBO(114, 114, 114, 1),
                        textSize: 20,
                        buttonColor: Color.fromRGBO(249, 220, 197, 1),
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: 'cos',
                        value: 'cos(',
                        textColor: Color.fromRGBO(114, 114, 114, 1),
                        textSize: 20,
                        buttonColor: Color.fromRGBO(249, 220, 197, 1),
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: 'tan',
                        value: 'tan(',
                        textColor: Color.fromRGBO(114, 114, 114, 1),
                        textSize: 20,
                        buttonColor: Color.fromRGBO(249, 220, 197, 1),
                        callback: addNumberExpression
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // Main functions
                      FunctionButton(
                        text: 'pi',
                        value: '3.14159265',
                        textColor: Color.fromRGBO(114, 114, 114, 1),
                        textSize: 22,
                        buttonColor: Color.fromRGBO(249, 220, 197, 1),
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: 'e',
                        value: '2.718281828',
                        textColor: Color.fromRGBO(114, 114, 114, 1),
                        textSize: 22,
                        buttonColor: Color.fromRGBO(249, 220, 197, 1),
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: '%',
                        value: '%',
                        textColor: Color.fromRGBO(114, 114, 114, 1),
                        textSize: 22,
                        buttonColor: Color.fromRGBO(249, 220, 197, 1),
                        callback: addGlobalFunction
                      ),
                      FunctionButton(
                        text: '(',
                        value: '(',
                        textColor: Color.fromRGBO(114, 114, 114, 1),
                        textSize: 22,
                        buttonColor: Color.fromRGBO(249, 220, 197, 1),
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: ')',
                        value: ')',
                        textColor: Color.fromRGBO(114, 114, 114, 1),
                        textSize: 22,
                        buttonColor: Color.fromRGBO(249, 220, 197, 1),
                        callback: addNumberExpression
                      ),

                      // Other functions
                      FunctionButton(
                        text: 'log',
                        value: 'log(',
                        textColor: Color.fromRGBO(114, 114, 114, 1),
                        textSize: 20,
                        buttonColor: Color.fromRGBO(249, 220, 197, 1),
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: 'ln',
                        value: 'ln(',
                        textColor: Color.fromRGBO(114, 114, 114, 1),
                        textSize: 20,
                        buttonColor: Color.fromRGBO(249, 220, 197, 1),
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: 'asin',
                        value: 'asin(',
                        textColor: Color.fromRGBO(114, 114, 114, 1),
                        textSize: 20,
                        buttonColor: Color.fromRGBO(249, 220, 197, 1),
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: 'acos',
                        value: 'acos(',
                        textColor: Color.fromRGBO(114, 114, 114, 1),
                        textSize: 20,
                        buttonColor: Color.fromRGBO(249, 220, 197, 1),
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: 'atan',
                        value: 'atan(',
                        textColor: Color.fromRGBO(114, 114, 114, 1),
                        textSize: 20,
                        buttonColor: Color.fromRGBO(249, 220, 197, 1),
                        callback: addNumberExpression
                      ),
                    ],
                  ),
                  SizedBox(height: 10)
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}