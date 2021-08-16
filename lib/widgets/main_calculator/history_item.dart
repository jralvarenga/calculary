import 'package:calculary/services/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryItem extends StatelessWidget {
  HistoryItem({
    Key? key,
    required this.expression,
    required this.result,
    required this.index,
    required this.selectItem
  }) : super(key: key);

  final String expression;
  final String result;
  final int index;
  final selectItem;

  @override
  Widget build(BuildContext context) {
    CustomTheme theme = Provider.of(context);
    var themeData = theme.themeData;

    return Material(
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => selectItem(index),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: themeData.dialogBackgroundColor),
            borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      expression,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: theme.paperTextColor
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: Text(
                      result,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}