import 'package:calculary/services/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OptionsForDerivative extends StatelessWidget {
  const OptionsForDerivative({
    Key? key,
    required this.xValue,
    required this.dxOrder,
    required this.changeInputIndex,
  }) : super(key: key);

  final String xValue;
  final String dxOrder;
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
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                reverse: true,
                scrollDirection: Axis.horizontal,
                child: Text(
                  'order=' + dxOrder,
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