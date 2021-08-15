import 'package:calculary/services/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputResultPad extends StatelessWidget {
  InputResultPad({
    Key? key,
    required this.expression,
    required this.result,
    this.function = '',
    required this.inputAnimation,
    required this.resultAnimation,
  }) : super(key: key);

  final List<String> expression;
  final String result;
  final String function;
  final inputAnimation;
  final resultAnimation;
  
  @override
  Widget build(BuildContext context) {
    CustomTheme theme = Provider.of(context);
    var themeData = theme.themeData;

    return Container(
      alignment: Alignment(1.0, 1.0),
      child: Column(
        children: [
          // Input container
          Container(
            alignment: Alignment(1, 1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100)
            ),
            child: FadeTransition(
              opacity: inputAnimation,
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(right: 10, bottom: 15),
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      child: SelectableText(
                        expression.join(),
                        showCursor: false,
                        cursorWidth: 3,
                        cursorColor: themeData.primaryColor,
                        cursorRadius: Radius.circular(100),
                        style: TextStyle(
                          fontSize: 45,
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
          // Result container
          Container(
            alignment: Alignment(1, 1),
            child: FadeTransition(
              opacity: resultAnimation,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  result,
                  style: TextStyle(
                    fontSize: 25,
                    color: theme.paperTextColor,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}