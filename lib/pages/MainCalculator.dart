import 'package:calculary/functions/solve_calculator.dart';
import 'package:calculary/widgets/FunctionsPad.dart';
import 'package:calculary/widgets/InputResultPad.dart';
import 'package:calculary/widgets/NumberPad.dart';
import 'package:calculary/widgets/TopBar.dart';
import 'package:flutter/material.dart';

class MainCalculator extends StatefulWidget {
  MainCalculator({Key? key, required this.title}) : super(key: key);

  final String title;
  
  @override
  _MainCalculator createState() => _MainCalculator();
}

class _MainCalculator extends State<MainCalculator> {
  String _mode = 'Calculator';
  String _input = '';
  String _result = '';
  bool _hasOperator = false;
  bool _hasNumber = false;

  void addNumber(String number) {

    setState(() {
      _input += number;
      _hasNumber = true;
      if (_hasOperator) {
        var solver = new SolveMainCalculator(_input);
        String result = solver.solve_expretion();
        _result = result;
      }
    });
  }

  void addOperator(String function) {
    var solver = new SolveMainCalculator(_input);
    
    setState(() {
      if (_hasNumber) {
        String result = solver.solve_expretion();

        _input += function;
        _result = result;
        _hasOperator = true;
      }
    });
  }

  void addFunction(String function) {
    setState(() {
      _input += function + '(' + _input;
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
    var solver = new SolveMainCalculator(_input);
    String result = solver.solve_expretion();

    setState(() {
      _result = '';
      _input = result;
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
                          addOperator: addOperator,
                          addFunction: addFunction,
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
