import 'package:calculary/services/custom_theme.dart';
import 'package:calculary/widgets/function_calculator/options_for_derivative.dart';
import 'package:calculary/widgets/function_calculator/options_for_function.dart';
import 'package:calculary/widgets/function_calculator/options_for_integral.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputResultPadFunctionCalculator extends StatelessWidget {
  const InputResultPadFunctionCalculator({
    Key? key,
    required this.loadingResult,
    required this.mode,
    required this.expression,
    required this.result,
    required this.xValue,
    required this.inputIndex,
    required this.changeInputIndex,
    required this.initialModeText,
    required this.finalModeText,

    required this.dxOrder,
    required this.dxXValue,
    required this.changeDerivativeIndex,
    required this.derivativeIndexOptions,

    required this.integralAValue,
    required this.integralBValue,
    required this.changeIntegralIndex,
    required this.integralIndexOptions,
  }) : super(key: key);

  final bool loadingResult;
  final String mode;

  final List<String> expression;
  final String result;
  final String xValue;
  final int inputIndex;
  final String initialModeText;
  final String finalModeText;

  final changeInputIndex;

  // Derivative mode
  final String dxOrder;
  final String dxXValue;
  final int derivativeIndexOptions;
  final changeDerivativeIndex;

  // Integral mode
  final String integralAValue;
  final String integralBValue;
  final int integralIndexOptions;
  final changeIntegralIndex;

  @override
  Widget build(BuildContext context) {
    CustomTheme theme = Provider.of(context);
    var themeData = theme.themeData;

    return Container(
      alignment: Alignment(1, 1),
      child: Column(
        children: <Widget>[
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
                        initialModeText + expression.join() + finalModeText,
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
          if (mode == 'function')
            OptionForFunction(
              changeInputIndex: changeInputIndex,
              xValue: xValue
            ),
          if (mode == 'derivative')
            OptionsForDerivative(
              xValue: dxXValue,
              dxOrder: dxOrder,
              changeInputIndex: changeInputIndex,
              changeDerivativeIndex: changeDerivativeIndex,
              derivativeIndexOptions: derivativeIndexOptions,
            ),
          if (mode == 'integral')
            OptionsForIntegral(
              integralAValue: integralAValue,
              integralBValue: integralBValue,
              integralIndexOptions: integralIndexOptions,
              changeIntegralIndex: changeIntegralIndex,
              changeInputIndex: changeInputIndex
            ),
          if (mode == 'plot')
            OptionForFunction(
              changeInputIndex: changeInputIndex,
              xValue: 'plot'
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
                children: <Widget>[
                  if (loadingResult) 
                    CircularProgressIndicator(
                      strokeWidth: 7,
                      color: themeData.primaryColor,
                      backgroundColor: themeData.accentColor
                    ),
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