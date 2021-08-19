import 'package:calculary/services/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OptionForFunction extends StatelessWidget {
  const OptionForFunction({
    Key? key,
    required this.changeInputIndex,
    required this.xValue
  }) : super(key: key);

  final changeInputIndex;
  final xValue;

  @override
  Widget build(BuildContext context) {
    CustomTheme theme = Provider.of(context);

    return Container(
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
    );
  }
}