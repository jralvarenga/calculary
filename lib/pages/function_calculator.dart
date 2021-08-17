import 'package:calculary/widgets/function_calculator/input_pad.dart';
import 'package:calculary/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class FunctionCalculator extends StatefulWidget {
  const FunctionCalculator({ Key? key }) : super(key: key);

  @override
  _FunctionCalculatorState createState() => _FunctionCalculatorState();
}

class _FunctionCalculatorState extends State<FunctionCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    child: Column(
                      children: [
                        TopBar(
                          mode: 'Function',
                          rightButtonFunction: () => print('hi')
                        ),
                        SizedBox(height: 30),
                        InputPad()
                      ],
                    ),
                  )
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}