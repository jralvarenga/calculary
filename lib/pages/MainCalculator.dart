import 'dart:async';

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

class _MainCalculator extends State<MainCalculator> with TickerProviderStateMixin {
  String _mode = 'Calculator';
  List<String> _expression = [];
  List<String> _expressionDisplayer = [];
  int characterNumber = 0;
  String _globalFunction = '';
  var _result = '';

  // Solver conditions
  bool _openedParenthesis = false;
  bool _hasOperator = false;
  bool _canSolve = true;

  // Input/Result animation controllers
  late AnimationController _inputAnimationController;
  late AnimationController _resultAnimationController;
  late Animation _inputAnimation;
  late Animation _resultAnimation;

  @override
  void initState() {
    super.initState();
    _inputAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    _inputAnimation = Tween(
      begin: 0.0,
      end: 1.0
    ).animate(_inputAnimationController);

    _resultAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    _resultAnimation = Tween(
      begin: 0.0,
      end: 1.0
    ).animate(_resultAnimationController);
  }

  @override
  void dispose() {
    _inputAnimationController.dispose();
    _resultAnimationController.dispose();
    super.dispose();
  }
  /////////////////////////

  void addNumberExpression(String expression, String value) {
    setState(() {
      _inputAnimationController.forward();
      if (_mode == 'Tip') {
        _mode = 'Calculator';
      }

      switch (expression) {
        case 'pi':
        case 'e':
          _expression.add(value);
          _expressionDisplayer.add(expression);
          _result = value;

          _resultAnimationController.forward();
        break;
        case '!':
          String lastNumberInExpression = _expression.last;
          String lastNumberInDisplay = _expressionDisplayer.last;
          String addedFactorial = lastNumberInExpression + value;
          String addedFactorialInDisplayer = lastNumberInDisplay + expression;
          _expression.removeLast();
          _expressionDisplayer.removeLast();

          _expression.add(addedFactorial);
          _expressionDisplayer.add(addedFactorialInDisplayer);
          
          var solver = new SolveMainCalculator(_expression, _globalFunction);
          String result = solver.solveExpression();
          _result = result;
          _resultAnimationController.forward();
        break;
        case '(':
        case '^':
        case 'sqrt':
          _openedParenthesis = true;
          _canSolve = false;
          
          _expression.add(value);
          _expressionDisplayer.add(value);
        break;
        case ')':
          _openedParenthesis = false;
          _canSolve = true;
          
          _expression.add(value);
          _expressionDisplayer.add(expression);

          var solver = new SolveMainCalculator(_expression, _globalFunction);
          String result = solver.solveExpression();
          _result = result;
          _resultAnimationController.forward();
        break;
        default:
          _expression.add(value);
          _expressionDisplayer.add(expression);
        break;
      }

      if (_canSolve && !_openedParenthesis && _hasOperator) {
        _resultAnimationController.forward();
        var solver = new SolveMainCalculator(_expression, _globalFunction);
        String result = solver.solveExpression();
        _result = result;
      }
    });
  }

  void addOperator(String operator, String value) {
    setState(() {
      if (_mode == 'Tip') {
        _mode = 'Calculator';
      }
      // Verifies AVG mode
      if (_globalFunction == 'AVG' && (operator == 'x' || operator == '/')) {
        final snackBar = SnackBar(
          content: const Text('Only + & - operators allowed in average mode')
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        _expressionDisplayer.add(operator);
        _expression.add(value);
      }

      _hasOperator = true;
    });
  }

  void addGlobalFunction(String function, String value) {
    setState(() {
      switch (function) {
        case 'AVG':
          _mode = value;
          _globalFunction = function;

          _expressionDisplayer.insert(0, function + '(');
        break;
        case 'TIP':
          _mode = value;
          var solver = new SolveMainCalculator(_expression, _globalFunction);
          String result = solver.solveExpression();
          double onlyTip = double.parse(result) * 0.1;
          print(onlyTip);

          _expression = onlyTip.toString().split('');
          _expressionDisplayer = onlyTip.toString().split('');
          _result = '';
        break;
      }
    });
  }

  void resetGlobalFunction() {
    setState(() {
      _mode = 'Calculator';
      _globalFunction = '';
    });
  }

  void deleteFromExpression() {
    setState(() {
      _openedParenthesis = false;
      _hasOperator = false;
      _canSolve = true;

      if (_expressionDisplayer.length == 1) {
        _inputAnimationController.reverse();
        _resultAnimationController.reverse();

        Timer(Duration(milliseconds: 200), () {
          _expression = [];
          _expressionDisplayer = [];
        });
      } else {
        _expressionDisplayer.removeLast();
        _expression.removeLast();

        _resultAnimationController.reverse();
      }
      Timer(Duration(milliseconds: 200), () {
        _result = '';
      });
    });
  }

  void deleteAllInput() {
    setState(() {
      _inputAnimationController.reverse();
      _resultAnimationController.reverse();

      _openedParenthesis = false;
      _hasOperator = false;
      _canSolve = true;

      Timer(Duration(milliseconds: 200), () {
        _expression = [''];
        _expressionDisplayer = [''];
        _result = '';
      });
    });
  }

  void enterExpression() {
    setState(() {
      if (_openedParenthesis) {
        final snackBar = SnackBar(
          content: const Text('Close all parenthesis')
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        var solver = new SolveMainCalculator(_expression, _globalFunction);
        String result = solver.solveExpression();
        _resultAnimationController.reverse();
        _expression = result.split('');
        _expressionDisplayer = result.split('');
        _globalFunction = '';
        _mode = 'Calculator';

        Timer(Duration(milliseconds: 200), () {
          _result = '';
        });
      }
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
                        TopBar(
                          mode: _mode,
                          rightButtonFunction: resetGlobalFunction,
                        ),
                        InputResultPad(
                          expression: _expressionDisplayer,
                          result: _result,
                          inputAnimation: _inputAnimation,
                          resultAnimation: _resultAnimation,
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
                          addNumberExpression: addNumberExpression,
                          addOperator: addOperator,
                          addGlobalFunction: addGlobalFunction,
                        ),
                        NumberPad(
                          addNumberExpression: addNumberExpression,
                          addOperator: addOperator,
                          deleteFromExpression: deleteFromExpression,
                          deleteAllInput: deleteAllInput,
                          enterExpression: enterExpression
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
