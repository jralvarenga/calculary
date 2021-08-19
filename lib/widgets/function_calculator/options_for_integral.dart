import 'package:calculary/services/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OptionsForIntegral extends StatelessWidget {
  const OptionsForIntegral({
    Key? key,
    required this.integralAValue,
    required this.integralBValue,
    required this.integralIndexOptions,
    required this.changeIntegralIndex,
    required this.changeInputIndex,
  }) : super(key: key);

  final String integralAValue;
  final String integralBValue;
  final int integralIndexOptions;
  final changeIntegralIndex;
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
              onTap: () => changeIntegralIndex(0),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                reverse: true,
                scrollDirection: Axis.horizontal,
                child: Text(
                  'a=' + integralAValue,
                  style: TextStyle(
                    fontSize: 25,
                    color: integralIndexOptions == 0 ? theme.textColor : theme.paperTextColor,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            SizedBox(width: 20),
            GestureDetector(
              onTap: () => changeIntegralIndex(1),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                reverse: true,
                scrollDirection: Axis.horizontal,
                child: Text(
                  'b=' + integralBValue,
                  style: TextStyle(
                    fontSize: 25,
                    color: integralIndexOptions == 1 ? theme.textColor : theme.paperTextColor,
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