import 'package:calculary/services/custom_theme.dart';
import 'package:calculary/services/format_color.dart';
import 'package:calculary/widgets/calculator_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:charcode/charcode.dart";

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
                        textColor: estimateBrightnessForColorForText(themeData.accentColor),
                        textSize: 16,
                        buttonColor: themeData.accentColor,
                        callback: addGlobalFunction
                      ),
                      FunctionButton(
                        text: 'AVG',
                        value: 'Average',
                        textColor: estimateBrightnessForColorForText(themeData.accentColor),
                        textSize: 14,
                        buttonColor: themeData.accentColor,
                        callback: addGlobalFunction
                      ),
                      FunctionButton(
                        text: '!',
                        value: '!',
                        textColor: estimateBrightnessForColorForText(themeData.accentColor),
                        textSize: 22,
                        buttonColor: themeData.accentColor,
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: String.fromCharCode($radic),
                        value: 'sqrt(',
                        textColor: estimateBrightnessForColorForText(themeData.accentColor),
                        textSize: 16,
                        buttonColor: themeData.accentColor,
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: '^',
                        value: '^(',
                        textColor: estimateBrightnessForColorForText(themeData.accentColor),
                        textSize: 22,
                        buttonColor: themeData.accentColor,
                        callback: addNumberExpression
                      ),

                      // Other functions
                      FunctionButton(
                        text: 'RAND',
                        value: 'rand',
                        textColor: estimateBrightnessForColorForText(themeData.accentColor),
                        textSize: 16,
                        buttonColor: themeData.accentColor,
                        callback: addGlobalFunction
                      ),
                      FunctionButton(
                        text: 'exp',
                        value: 'e^(',
                        textColor: estimateBrightnessForColorForText(themeData.accentColor),
                        textSize: 20,
                        buttonColor: themeData.accentColor,
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: 'sin',
                        value: 'sin(',
                        textColor: estimateBrightnessForColorForText(themeData.accentColor),
                        textSize: 20,
                        buttonColor: themeData.accentColor,
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: 'cos',
                        value: 'cos(',
                        textColor: estimateBrightnessForColorForText(themeData.accentColor),
                        textSize: 20,
                        buttonColor: themeData.accentColor,
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: 'tan',
                        value: 'tan(',
                        textColor: estimateBrightnessForColorForText(themeData.accentColor),
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
                        text: String.fromCharCode($pi),
                        value: '3.14159265',
                        textColor: estimateBrightnessForColorForText(themeData.accentColor),
                        textSize: 22,
                        buttonColor: themeData.accentColor,
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: 'e',
                        value: '2.718281828',
                        textColor: estimateBrightnessForColorForText(themeData.accentColor),
                        textSize: 22,
                        buttonColor: themeData.accentColor,
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: '%',
                        value: '%',
                        textColor: estimateBrightnessForColorForText(themeData.accentColor),
                        textSize: 22,
                        buttonColor: themeData.accentColor,
                        callback: addGlobalFunction
                      ),
                      FunctionButton(
                        text: '(',
                        value: '(',
                        textColor: estimateBrightnessForColorForText(themeData.accentColor),
                        textSize: 22,
                        buttonColor: themeData.accentColor,
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: ')',
                        value: ')',
                        textColor: estimateBrightnessForColorForText(themeData.accentColor),
                        textSize: 22,
                        buttonColor: themeData.accentColor,
                        callback: addNumberExpression
                      ),

                      // Other functions
                      FunctionButton(
                        text: 'log',
                        value: 'log10(',
                        textColor: estimateBrightnessForColorForText(themeData.accentColor),
                        textSize: 20,
                        buttonColor: themeData.accentColor,
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: 'ln',
                        value: 'ln(',
                        textColor: estimateBrightnessForColorForText(themeData.accentColor),
                        textSize: 20,
                        buttonColor: themeData.accentColor,
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: 'asin',
                        value: 'arcsin(',
                        textColor: estimateBrightnessForColorForText(themeData.accentColor),
                        textSize: 20,
                        buttonColor: themeData.accentColor,
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: 'acos',
                        value: 'arccos(',
                        textColor: estimateBrightnessForColorForText(themeData.accentColor),
                        textSize: 20,
                        buttonColor: themeData.accentColor,
                        callback: addNumberExpression
                      ),
                      FunctionButton(
                        text: 'atan',
                        value: 'arctan(',
                        textColor: estimateBrightnessForColorForText(themeData.accentColor),
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