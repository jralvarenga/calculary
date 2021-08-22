import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:calculary/services/solve_calculator.dart';
import 'package:calculary/widgets/main_calculator/function_pad.dart';
import 'package:calculary/widgets/main_calculator/input_result_pad.dart';
import 'package:calculary/widgets/main_calculator/main_calculator_options.dart';
import 'package:calculary/widgets/number_pad.dart';
import 'package:calculary/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryItem {
  List<String> expression;
  List<String> expressionDisplayer;
  String result;

  Map toJson() => {
    'expression': expression,
    'expressionDisplayer': expressionDisplayer,
    'result': result,
  };

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      expression: List<String>.from(json["expression"].map((x) => x.toString())),
      expressionDisplayer: List<String>.from(json["expressionDisplayer"].map((x) => x.toString())),
      result: json['result'] as String,
    );
  }
  
  HistoryItem({
    Key? key,
    required this.expression,
    required this.expressionDisplayer,
    required this.result,
  });
}

class MainCalculator extends StatefulWidget {
  MainCalculator({
    Key? key,
    required this.mathAPIAvaliable
  }) : super(key: key);

  final bool mathAPIAvaliable;
  
  @override
  _MainCalculatorState createState() => _MainCalculatorState();
}

class _MainCalculatorState extends State<MainCalculator> with TickerProviderStateMixin {
  List _calculatorHistory = [];
  String _mode = 'Calculator';
  List<String> _expression = [];
  List<String> _expressionDisplayer = [];
  String _globalFunction = '';
  String _functionEnd = '';
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

  void sendSnackbar(String text) {
    final snackBar = SnackBar(
      content: Text(text)
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void getCalculatorHistory() async {
    final prefs = await SharedPreferences.getInstance();
    String historyJson = (prefs.getString('main_calculator_history') ?? '[]');
    final parsedHistoryJson = jsonDecode(historyJson).cast<Map<String, dynamic>>();
    List history = parsedHistoryJson.map<HistoryItem>((json) => HistoryItem.fromJson(json)).toList();

    setState(() {
      _calculatorHistory = history;
    });
  }

  @override
  void initState() {
    super.initState();

    getCalculatorHistory();

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

  void setItemsFromHistory(HistoryItem item) {
    setState(() {
      _expression = item.expression;
      _expressionDisplayer = item.expressionDisplayer;
      _result = item.result;
    });
    _inputAnimationController.forward();
    _resultAnimationController.forward();
    Navigator.of(context).pop();
  }

  void resetHistory() async {
    HapticFeedback.lightImpact();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('main_calculator_history');
    setState(() {
      _calculatorHistory = [];
    });
    Navigator.of(context).pop();
  }

  void setANS() {
    HapticFeedback.lightImpact();
    var lastHistoryItem = _calculatorHistory.last;
    setState(() {
      _expression.add(lastHistoryItem.result);
      _expressionDisplayer.add(lastHistoryItem.result);
    });
    _inputAnimationController.forward();
    Navigator.of(context).pop();
  }
  
  void addNumberExpression(String expression, String value) {
    setState(() {
      _inputAnimationController.forward();
      if (_mode == 'Tip') {
        _mode = 'Calculator';
      }
      // Divition in zero handler
      if (_expression.length > 0) {
        if (_expression.last == '/' && value == '0') {
          _canSolve = false;
        }
      }

      switch (value) {
        // Pi
        case '3.14159265':
        // Euler number
        case '2.718281828':
          _expression.add(value);
          _expressionDisplayer.add(expression);
          _result = value;

          _resultAnimationController.forward();
        break;
        case '!':
          _expression.add(value);
          _expressionDisplayer.add(value);
          
          var solver = new SolveMainCalculator(_expression, _globalFunction);
          String result = solver.solveExpression();
          _result = result;
          _resultAnimationController.forward();
        break;
        case '(':
        case '^(':
        case 'sqrt(':
        case 'sin(':
        case 'cos(':
        case 'tan(':
        case 'arcsin(':
        case 'arccos(':
        case 'arctan(':
        case 'log(':
        case 'ln(':
        case 'e^(':
          _openedParenthesis = true;
          _canSolve = false;
          
          _expression.add(value);
          if (expression == '(') {
            _expressionDisplayer.add(expression); 
          } else {
            _expressionDisplayer.add(expression + '(');
          }
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
        sendSnackbar('Only + & - operators allowed in average mode');
      } else if (_globalFunction == 'PEG') {
        sendSnackbar('Only can introduce 1 percentage at a time');
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
          _functionEnd = ')';
        break;
        case 'TIP':
          _mode = value;
          var solver = new SolveMainCalculator(_expression, _globalFunction);
          String result = solver.solveExpression();
          double onlyTip = double.parse(result) * 0.1;

          _expression = onlyTip.toString().split('');
          _expressionDisplayer = onlyTip.toString().split('');
          _result = '';
        break;
        case '%':
          _mode = 'Percentage';
          _globalFunction = 'PEG';
          var solver = new SolveMainCalculator(_expression, _globalFunction);
          String result = solver.solveExpression();

          _expressionDisplayer.add(function);
          _result = result;
          _resultAnimationController.forward();
        break;
        case 'RAND':
          var rng = new Random();
          String randomNumber = rng.nextInt(100).toString();

          _expression.add(randomNumber);
          _expressionDisplayer.add(randomNumber);
          _inputAnimationController.forward();
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
      _hasOperator = false;
      _canSolve = true;

      if (_expression.last == ')' && _expressionDisplayer.last == ')') {
        _openedParenthesis = true;
      } else {
        _openedParenthesis = false;
      }

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
      resetGlobalFunction();
      _inputAnimationController.reverse();
      _resultAnimationController.reverse();

      _openedParenthesis = false;
      _hasOperator = false;
      _canSolve = true;
      _functionEnd = '';

      Timer(Duration(milliseconds: 200), () {
        _expression = [];
        _expressionDisplayer = [];
        _result = '';
      });
    });
  }

  void enterExpression() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_openedParenthesis) {
        sendSnackbar('Close all parenthesis');
      } else {
        var solver = new SolveMainCalculator(_expression, _globalFunction);

        String result = solver.solveExpression();
        HistoryItem historyItem = HistoryItem(
          expression: _expression,
          expressionDisplayer: _expressionDisplayer,
          result: result
        );
        _calculatorHistory.add(historyItem);
        prefs.setString('main_calculator_history', jsonEncode(_calculatorHistory));

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

    void openCalculatorOptions() {
      HapticFeedback.lightImpact();
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30)
          )
        ),
        builder: (context) => buildCalculatorOptions()
      );
    }
  
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
                          mode: 'History',
                          rightButtonFunction: openCalculatorOptions,
                          mathAPIAvaliable: widget.mathAPIAvaliable,
                        ),
                        InputResultPad(
                          expression: _expressionDisplayer,
                          result: _result,
                          inputAnimation: _inputAnimation,
                          resultAnimation: _resultAnimation,
                          functionEnd: _functionEnd,
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

  Widget buildCalculatorOptions() => MainCalculatorOptions(
    history: _calculatorHistory,
    setItemsFromHistory: setItemsFromHistory,
    resetHistory: resetHistory,
    setANS: setANS,
  );
}