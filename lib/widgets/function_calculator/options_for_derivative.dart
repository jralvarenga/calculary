import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:calculary/services/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OptionsForDerivative extends StatelessWidget {
  const OptionsForDerivative({
    Key? key,
    required this.xValue,
    required this.dxOrder,
    required this.changeInputIndex,
    required this.changeDerivativeIndex,
    required this.derivativeIndexOptions
  }) : super(key: key);

  final String xValue;
  final String dxOrder;
  final int derivativeIndexOptions;
  final changeInputIndex;
  final changeDerivativeIndex;

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
              onTap: () => changeDerivativeIndex(0),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                reverse: true,
                scrollDirection: Axis.horizontal,
                child: Text(
                  AppLocalizations.of(context)!.order + '=' + dxOrder,
                  style: TextStyle(
                    fontSize: 25,
                    color: derivativeIndexOptions == 0 ? theme.textColor : theme.paperTextColor,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            SizedBox(width: 20),
            GestureDetector(
              onTap: () => changeDerivativeIndex(1),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                reverse: true,
                scrollDirection: Axis.horizontal,
                child: Text(
                  'x=' + xValue,
                  style: TextStyle(
                    fontSize: 25,
                    color: derivativeIndexOptions == 1 ? theme.textColor : theme.paperTextColor,
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