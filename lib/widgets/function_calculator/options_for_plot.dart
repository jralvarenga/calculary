import 'package:calculary/services/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OptionsForPlot extends StatelessWidget {
  const OptionsForPlot({
    Key? key,
    required this.from,
    required this.to,
    required this.changePlotIndex,
    required this.plotIndexOptions,
    required this.changeInputIndex,
  }) : super(key: key);

  final String from;
  final String to;
  final int plotIndexOptions;
  final changePlotIndex;
  final changeInputIndex;

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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () => changePlotIndex(0),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                reverse: true,
                scrollDirection: Axis.horizontal,
                child: Text(
                  'from=' + from,
                  style: TextStyle(
                    fontSize: 25,
                    color: plotIndexOptions == 0 ? theme.textColor : theme.paperTextColor,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            SizedBox(width: 20),
            GestureDetector(
              onTap: () => changePlotIndex(1),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                reverse: true,
                scrollDirection: Axis.horizontal,
                child: Text(
                  'to=' + to,
                  style: TextStyle(
                    fontSize: 25,
                    color: plotIndexOptions == 1 ? theme.textColor : theme.paperTextColor,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            )
          ]
        ),
      )
    );
  }
}