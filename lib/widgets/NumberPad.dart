import 'package:calculary/services/CustomTheme.dart';
import 'package:calculary/widgets/CalculatorButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    CustomTheme theme = Provider.of(context);
    var themeData = theme.themeData;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NumberButton(
              text: '7',
              value: '7',
              textColor: theme.textColor,
              textSize: 20,
              buttonColor: themeData.dialogBackgroundColor,
              callback: addNumber
            ),
            NumberButton(
              text: '8',
              value: '8',
              textColor: theme.textColor,
              textSize: 20,
              buttonColor: themeData.dialogBackgroundColor,
              callback: addNumber
            ),
            NumberButton(
              text: '9',
              value: '9',
              textColor: theme.textColor,
              textSize: 20,
              buttonColor: themeData.dialogBackgroundColor,
              callback: addNumber
            ),
            FunctionButton(
              text: '/',
              value: '/',
              textColor: theme.paperTextColor,
              textSize: 22,
              buttonColor: themeData.accentColor,
              callback: addOperator
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: SizedBox(
                width: 60,
                height: 60,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: themeData.primaryColor,
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
              textColor: theme.textColor,
              textSize: 20,
              buttonColor: themeData.dialogBackgroundColor,
              callback: addNumber
            ),
            NumberButton(
              text: '5',
              value: '5',
              textColor: theme.textColor,
              textSize: 20,
              buttonColor: themeData.dialogBackgroundColor,
              callback: addNumber
            ),
            NumberButton(
              text: '6',
              value: '6',
              textColor: theme.textColor,
              textSize: 20,
              buttonColor: themeData.dialogBackgroundColor,
              callback: addNumber
            ),
            FunctionButton(
              text: '-',
              value: '-',
              textColor: theme.paperTextColor,
              textSize: 22,
              buttonColor: themeData.accentColor,
              callback: addOperator
            ),
            FunctionButton(
              text: 'x',
              value: '*',
              textColor: theme.paperTextColor,
              textSize: 22,
              buttonColor: themeData.accentColor,
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
              textColor: theme.textColor,
              textSize: 20,
              buttonColor: themeData.dialogBackgroundColor,
              callback: addNumber
            ),
            NumberButton(
              text: '2',
              value: '2',
              textColor: theme.textColor,
              textSize: 20,
              buttonColor: themeData.dialogBackgroundColor,
              callback: addNumber
            ),
            NumberButton(
              text: '3',
              value: '3',
              textColor: theme.textColor,
              textSize: 20,
              buttonColor: themeData.dialogBackgroundColor,
              callback: addNumber
            ),
            LargeFunctionButton(
              text: '+',
              value: '+',
              textColor: theme.paperTextColor,
              textSize: 22,
              buttonColor: themeData.accentColor,
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
              textColor: theme.textColor,
              textSize: 20,
              buttonColor: themeData.dialogBackgroundColor,
              callback: addNumber
            ),
            NumberButton(
              text: '.',
              value: '.',
              textColor: theme.textColor,
              textSize: 20,
              buttonColor: themeData.dialogBackgroundColor,
              callback: addNumber
            ),
            LargeFunctionButton(
              text: '=',
              value: 'enter',
              textColor: Color.fromRGBO(255, 255, 255, 1),
              textSize: 22,
              buttonColor: themeData.primaryColor,
              callback: enterExpretion
            ),
          ],
        ),
      ],
    );
  }
}