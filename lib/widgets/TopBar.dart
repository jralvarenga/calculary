import 'package:calculary/services/CustomTheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopBar extends StatelessWidget {
  TopBar({
    Key? key,
    required this.mode
  }) : super(key: key);

  final String mode;

  void pressed() {
    print('hi');
  }
  
  @override
  Widget build(BuildContext context) {
    CustomTheme theme = Provider.of(context);
    var themeData = theme.themeData;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: pressed,
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
          onTap: pressed,
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