import 'package:calculary/widgets/FunctionsPad.dart';
import 'package:calculary/widgets/InputResultPad.dart';
import 'package:calculary/widgets/NumberPad.dart';
import 'package:calculary/widgets/TopBar.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MainCalculator extends StatefulWidget {
  MainCalculator({Key? key, required this.title}) : super(key: key);

  final String title;
  
  @override
  _MainCalculator createState() => _MainCalculator();
}

class _MainCalculator extends State<MainCalculator> {
  Parser p = Parser();
  String _mode = 'Calculator';
  String _input = '';
  String _result = '';
  bool _hasOperator = false;

  void addNumber(String number) {

    setState(() {
      _input += number;
      if (_hasOperator) {
        Expression exp = p.parse(_input);
        ContextModel cm = ContextModel();
        _result = exp.evaluate(EvaluationType.REAL, cm).toString();
      }
    });
  }

  void addOperator(String function) {
    Expression exp = p.parse(_input);
    ContextModel cm = ContextModel();
    
    setState(() {
      _input += function;
      _result = exp.evaluate(EvaluationType.REAL, cm).toString();
      _hasOperator = true;
    });
  }

  void deleteFromExpretion() {
    setState(() {
      _input = _input.substring(0, _input.length - 1);
    });
  }

  void deleteAllInput() {
    setState(() {
      _input = '';
      _result = '';
    });
  }

  void enterExpretion() {
    Expression exp = p.parse(_input);
    ContextModel cm = ContextModel();

    setState(() {
      _result = '';
      _input = exp.evaluate(EvaluationType.REAL, cm).toString();
    });
  }
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TopBar(mode: _mode),
                        InputResultPad(input: _input, result: _result),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FunctionsPad(
                          addNumber: addNumber,
                          addOperator: addOperator
                        ),
                        NumberPad(
                          addNumber: addNumber,
                          addOperator: addOperator,
                          deleteFromExpretion: deleteFromExpretion,
                          deleteAllInput: deleteAllInput,
                          enterExpretion: enterExpretion
                        )
                      ],
                    ),
                  )
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}
