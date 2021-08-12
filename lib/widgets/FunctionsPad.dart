import 'package:calculary/services/CustomTheme.dart';
import 'package:calculary/widgets/CalculatorButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    CustomTheme theme = Provider.of(context);
    var themeData = theme.themeData;

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
                        textColor: theme.paperTextColor,
                        textSize: 16,
                        buttonColor: themeData.accentColor,
                        callback: addGlobalFunction
                      ),
                      FunctionButton(
                        text: 'AVG',
                        value: 'Average',
                        textColor: theme.paperTextColor,
                        textSize: 14,
                        buttonColor: themeData.accentColor,
                        callback: addGlobalFunction
                      ),
                      FunctionButton(
                        text: '!',
                        value: '!',
                        textColor: theme.paperTextColor,
                        textSize: 22,
                        buttonColor: themeData.accentColor,
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: 'sqrt',
                        value: 'sqrt(',
                        textColor: theme.paperTextColor,
                        textSize: 16,
                        buttonColor: themeData.accentColor,
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: '^',
                        value: '^(',
                        textColor: theme.paperTextColor,
                        textSize: 22,
                        buttonColor: themeData.accentColor,
                        callback: addNumberExpression
                      ),

                      // Other functions
                      FunctionButton(
                        text: 'RAND',
                        value: 'rand',
                        textColor: theme.paperTextColor,
                        textSize: 16,
                        buttonColor: themeData.accentColor,
                        callback: addGlobalFunction
                      ),
                      FunctionButton(
                        text: 'exp',
                        value: 'e^(',
                        textColor: theme.paperTextColor,
                        textSize: 20,
                        buttonColor: themeData.accentColor,
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: 'sin',
                        value: 'sin(',
                        textColor: theme.paperTextColor,
                        textSize: 20,
                        buttonColor: themeData.accentColor,
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: 'cos',
                        value: 'cos(',
                        textColor: theme.paperTextColor,
                        textSize: 20,
                        buttonColor: themeData.accentColor,
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: 'tan',
                        value: 'tan(',
                        textColor: theme.paperTextColor,
                        textSize: 20,
                        buttonColor: themeData.accentColor,
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
                        textColor: theme.paperTextColor,
                        textSize: 22,
                        buttonColor: themeData.accentColor,
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: 'e',
                        value: '2.718281828',
                        textColor: theme.paperTextColor,
                        textSize: 22,
                        buttonColor: themeData.accentColor,
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: '%',
                        value: '%',
                        textColor: theme.paperTextColor,
                        textSize: 22,
                        buttonColor: themeData.accentColor,
                        callback: addGlobalFunction
                      ),
                      FunctionButton(
                        text: '(',
                        value: '(',
                        textColor: theme.paperTextColor,
                        textSize: 22,
                        buttonColor: themeData.accentColor,
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: ')',
                        value: ')',
                        textColor: theme.paperTextColor,
                        textSize: 22,
                        buttonColor: themeData.accentColor,
                        callback: addNumberExpression
                      ),

                      // Other functions
                      FunctionButton(
                        text: 'log',
                        value: 'log10(',
                        textColor: theme.paperTextColor,
                        textSize: 20,
                        buttonColor: themeData.accentColor,
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: 'ln',
                        value: 'ln(',
                        textColor: theme.paperTextColor,
                        textSize: 20,
                        buttonColor: themeData.accentColor,
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: 'asin',
                        value: 'arcsin(',
                        textColor: theme.paperTextColor,
                        textSize: 20,
                        buttonColor: themeData.accentColor,
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: 'acos',
                        value: 'arccos(',
                        textColor: theme.paperTextColor,
                        textSize: 20,
                        buttonColor: themeData.accentColor,
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: 'atan',
                        value: 'arctan(',
                        textColor: theme.paperTextColor,
                        textSize: 20,
                        buttonColor: themeData.accentColor,
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