import 'package:calculary/services/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputResultPadFunctionCalculator extends StatelessWidget {
  const InputResultPadFunctionCalculator({
    Key? key,
    required this.expression,
    required this.result,
    required this.xValue,
    required this.inputIndex,
    required this.changeInputIndex
  }) : super(key: key);

  final List<String> expression;
  final String result;
  final String xValue;
  final int inputIndex;
  final changeInputIndex;

  @override
  Widget build(BuildContext context) {
    CustomTheme theme = Provider.of(context);
    var themeData = theme.themeData;

    return Container(
      alignment: Alignment(1, 1),
      child: Column(
        children: [
          Container(
            alignment: Alignment(1, 1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100)
            ),
            child: GestureDetector(
              onTap: () => changeInputIndex(0),
              //opacity: inputAnimation,
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(10),
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        'f(x)=' + expression.join(),
                        style: TextStyle(
                          fontSize: 30,
                          color: theme.textColor,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ),
                ]
              ),
            )
          ),
          Divider(
            thickness: 1,
            color: inputIndex == 0 ? themeData.primaryColor : themeData.dialogBackgroundColor,
          ),
          Container(
            alignment: Alignment(1, 1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: GestureDetector(
              onTap: () => changeInputIndex(1),
              //opacity: inputAnimation,
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(10),
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        'x=' + xValue,
                        style: TextStyle(
                          fontSize: 25,
                          color: theme.textColor,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ),
                ]
              ),
            )
          ),
          Divider(
            thickness: 1,
            color: inputIndex == 1 ? themeData.primaryColor : themeData.dialogBackgroundColor,
          ),
          Container(
            alignment: Alignment(1, 1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100)
            ),
            child: Container(
              //opacity: inputAnimation,
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: SelectableText(
                      result,
                      showCursor: false,
                      cursorWidth: 3,
                      cursorColor: themeData.primaryColor,
                      cursorRadius: Radius.circular(100),
                      style: TextStyle(
                        fontSize: 30,
                        color: theme.textColor,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ]
              ),
            )
          ),
        ],
      ),
    );
  }
}