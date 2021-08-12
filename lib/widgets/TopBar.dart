import 'package:calculary/services/CustomTheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopBar extends StatelessWidget {
  TopBar({
    Key? key,
    required this.mode,
    required this.rightButtonFunction,
    required this.leftButtonFunction
  }) : super(key: key);

  final String mode;
  final rightButtonFunction;
  final leftButtonFunction;
  
  @override
  Widget build(BuildContext context) {
    CustomTheme theme = Provider.of(context);
    var themeData = theme.themeData;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: leftButtonFunction,
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: themeData.dialogBackgroundColor,
            ),
            child: Icon(
              Icons.more_horiz,
              size: 30,
            ),
          )
        ),
        GestureDetector(
          onTap: rightButtonFunction,
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 7, bottom: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: themeData.dialogBackgroundColor,
            ),
            child: Text(
              mode,
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ),
      ],
    );
  }
}