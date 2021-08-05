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
  // Display input entered
  String _input = '';
  // Evaluate input entered
  String _evaluate = '';
  // Result when evaluated _evaluate
  String _result = '';
  //String _currentFunction = '';
  bool _hasOperator = false;
  // Handle input/result enter fade
  bool _visibleInput = false;
  bool _visibleResult = false;

  void addNumber(String number, String value) {
    setState(() {
      _visibleInput = true;
      if (number == '(' || number == ')') {
        _input += number;
      } else if (number == 'pi' || number == 'e') {
        _input += number;
        _evaluate += value;
        _result = value;
      } else {
        _input += number;
        _evaluate += value;
      }
      if (_hasOperator) {
        _visibleResult = true;
        var solver = new SolveMainCalculator(_evaluate);
        String result = solver.solve_expretion();
        _result = result;
      }
    });
  }

  void addOperator(String operator, String value) {
    var solver = new SolveMainCalculator(_evaluate);
    String result = solver.solve_expretion();
    
    setState(() {
      _visibleResult = true;
      if (operator == 'x' || operator == '/') {
        _input += operator;        
      } else {
        _input += ' ' + operator + ' ';
      }
      _evaluate += value;
      _result = result;
      _hasOperator = true;
    });
  }

  void addFunction(String function, String value) {
    setState(() {
      _visibleResult = true;
      _input += function + '(' + _input;
      //_currentFunction = function;
    });
  }

  void deleteFromExpretion() {
    setState(() {
      if (_input.length == 1) {
        _input = '';
        _evaluate = '';
        _hasOperator = false;
        _visibleInput = false;
      _visibleResult = false;
      } else {
        _input = _input.substring(0, _input.length - 1);
        _evaluate = _evaluate.substring(0, _evaluate.length - 1);
        _visibleResult = false;
        _hasOperator = false;
      }
      _result = '';
    });
  }

  void deleteAllInput() {
    setState(() {
      _input = '';
      _evaluate = '';
      _result = '';
      _hasOperator = false;
      _visibleInput = false;
      _visibleResult = false;
    });
  }

  void enterExpretion() {
    setState(() {
      var solver = new SolveMainCalculator(_evaluate);
      String result = solver.solve_expretion();
      _result = '';
      _input = result;
      _hasOperator = false;
      _visibleResult = false;
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
                        InputResultPad(
                          input: _input,
                          result: _result,
                          visibleInput: _visibleInput,
                          visibleResult: _visibleResult,
                        ),
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
