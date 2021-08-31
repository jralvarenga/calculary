import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  String expression;
  List<String> expressionDisplayer;
  String result;

  Map toJson() => {
    'expression': expression,
    'expressionDisplayer': expressionDisplayer,
    'result': result,
  };

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      expression: json["expression"].toString(),
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
  String _expression = '';
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
      _expression = lastHistoryItem.result;
      _expressionDisplayer.add(lastHistoryItem.result);
    });
    _inputAnimationController.forward();
    Navigator.of(context).pop();
  }
  
  void addNumberExpression(String expression, String value) async {
    final prefs = await SharedPreferences.getInstance();
    _inputAnimationController.forward();
    if (_mode == 'Tip') {
      _mode = 'Calculator';
    }
    // Divition in zero handler
    List<String> splittedExpression = _expression.split('#');
    if (splittedExpression.length > 0) {
      if (splittedExpression.last == '/' && value == '0') {
        _canSolve = false;
      }
    }

    switch (value) {
      // Pi
      case '3.14159265':
      // Euler number
      case '2.718281828':
        setState(() {
          _expression += "#" + value;
          _expressionDisplayer.add(expression);
          _result = value;
        });

        _resultAnimationController.forward();
      break;
      case '!':
        setState(() {
          _expression += "#" + value;
          _expressionDisplayer.add(value);            
        });
        
        List<String> splittedExpression = _expression.split('#');
        var solver = new SolveMainCalculator(splittedExpression, _globalFunction);
        String result = solver.solveExpression();
        setState(() {
          _result = result;
        });
        _resultAnimationController.forward();
      break;
      case '(':
      case '^(':
      case 'sqrt(':
      case 'log10(':
      case 'ln(':
      case 'e^(':
        setState(() {
          _openedParenthesis = true;
          _canSolve = false;
          _expression += "#" + value;
          if (expression == '(') {
            _expressionDisplayer.add(expression); 
          } else {
            _expressionDisplayer.add(expression + '(');
          }
        });
      break;
      case 'sin(':
      case 'cos(':
      case 'tan(':
        String angularUnits = (prefs.getString('angular_units') ?? 'RAD');
        setState(() {
          _openedParenthesis = true;
          _canSolve = false;
          if (angularUnits == 'DEG') {
            _expression += "#" + value + '(3.14159265359/180)*';
          } else {
            _expression += "#" + value;
          }
          
          _expressionDisplayer.add(expression + '(');
        });
      break;
      case 'arcsin(':
      case 'arccos(':
      case 'arctan(':
        String angularUnits = (prefs.getString('angular_units') ?? 'RAD');
        setState(() {
          _openedParenthesis = true;
          _canSolve = false;
          if (angularUnits == 'DEG') {
            _expression += "#(180/3.14159265359)*" + value;
          } else {
            _expression += "#" + value;
          }
          
          _expressionDisplayer.add(expression + '(');
        });
      break;
      case ')':
        setState(() {
          _openedParenthesis = false;
          _canSolve = true;
          _expression += "#" + value;
          _expressionDisplayer.add(expression);            
        });
        
        List<String> splittedExpression = _expression.split('#');
        var solver = new SolveMainCalculator(splittedExpression, _globalFunction);
        String result = solver.solveExpression();
        setState(() {
          _result = result;
          _resultAnimationController.forward();
        });
      break;
      default:
        setState(() {
          _expression += "#" + value;
          _expressionDisplayer.add(expression);
        });
      break;
    }

    print(_expression);
    if (_canSolve && !_openedParenthesis && _hasOperator) {
      _resultAnimationController.forward();
      List<String> splittedExpression = _expression.split('#');
      var solver = new SolveMainCalculator(splittedExpression, _globalFunction);
      String result = solver.solveExpression();
      setState(() {
        _result = result;
      });
    }
  }

  void addOperator(String operator, String value) {
    setState(() {
      if (_mode == 'Tip') {
        _mode = 'Calculator';
      }
      // Verifies AVG mode
      if (_globalFunction == 'AVG' && (operator == 'x' || operator == '/')) {
        sendSnackbar(
          AppLocalizations.of(context)!.only_plus_minus_op
        );
      } else if (_globalFunction == 'PEG') {
        sendSnackbar(
          AppLocalizations.of(context)!.only_one_percentage
        );
      } else {
          _expression += "#" + value;
        _expressionDisplayer.add(operator);
      }

      _hasOperator = true;
    });
  }

  void addGlobalFunction(String function, String value) async {
    final prefs = await SharedPreferences.getInstance();
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
          String tipValue = (prefs.getString('tip_value') ?? '10');
          double tip = double.parse(tipValue) / 100;
          
          List<String> splittedExpression = _expression.split('#');
          var solver = new SolveMainCalculator(splittedExpression, _globalFunction);
          String result = solver.solveExpression();
          HistoryItem resultItem = HistoryItem(
            expression: _expression,
            expressionDisplayer: _expressionDisplayer,
            result: result
          );
          
          double resultTip = double.parse(result) * tip;
          String tipExpression = result + '*' + tip.toString();
          String tipExpressionDisplayer = result + 'x' + tip.toString();
          HistoryItem tipItem = HistoryItem(
            expression: tipExpression,
            expressionDisplayer: tipExpressionDisplayer.split(''),
            result: resultTip.toString()
          );

          _calculatorHistory.add(resultItem);
          prefs.setString('main_calculator_history', jsonEncode(_calculatorHistory));
          _calculatorHistory.add(tipItem);
          prefs.setString('main_calculator_history', jsonEncode(_calculatorHistory));

          _expression = resultTip.toString();
          _expressionDisplayer = resultTip.toString().split('');
          _result = '';
        break;
        case '%':
          _mode = 'Percentage';
          _globalFunction = 'PEG';
          List<String> splittedExpression = _expression.split('#');
          var solver = new SolveMainCalculator(splittedExpression, _globalFunction);
          String result = solver.solveExpression();

          _expressionDisplayer.add(function);
          _result = result;
          _resultAnimationController.forward();
        break;
        case 'RAND':
          var rng = new Random();
          String randomNumber = rng.nextInt(100).toString();

          _expression += "#" + randomNumber;
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
      
      List<String> splittedExpression = _expression.split('#');
      if (splittedExpression.last == ')' && _expressionDisplayer.last == ')') {
        _openedParenthesis = true;
      } else {
        _openedParenthesis = false;
      }

      if (_expressionDisplayer.length == 1) {
        _inputAnimationController.reverse();
        _resultAnimationController.reverse();

        Timer(Duration(milliseconds: 200), () {
          _expression = "";
          _expressionDisplayer = [];
        });
      } else {
        _expressionDisplayer.removeLast();
        splittedExpression.removeLast();
        _expression = splittedExpression.join('#');

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
        _expression = '';
        _expressionDisplayer = [];
        _result = '';
      });
    });
  }

  void enterExpression() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_openedParenthesis) {
        sendSnackbar(
          AppLocalizations.of(context)!.close_all_parenthesis
        );
      } else {
        List<String> splittedExpression = _expression.split('#');
        var solver = new SolveMainCalculator(splittedExpression, _globalFunction);

        String result = solver.solveExpression();
        HistoryItem historyItem = HistoryItem(
          expression: _expression,
          expressionDisplayer: _expressionDisplayer,
          result: result
        );
        _calculatorHistory.add(historyItem);
        prefs.setString('main_calculator_history', jsonEncode(_calculatorHistory));

        _resultAnimationController.reverse();
        _expression = result;
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
                          mode: AppLocalizations.of(context)!.history,
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