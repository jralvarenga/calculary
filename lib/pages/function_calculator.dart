import 'package:calculary/services/solve_function_calculator.dart';
import 'package:calculary/widgets/function_calculator/function_calculator_menu.dart';
import 'package:calculary/widgets/function_calculator/function_pad.dart';
import 'package:calculary/widgets/function_calculator/input_result_pad.dart';
import 'package:calculary/widgets/number_pad.dart';
import 'package:calculary/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FunctionCalculator extends StatefulWidget {
  const FunctionCalculator({ Key? key }) : super(key: key);

  @override
  _FunctionCalculatorState createState() => _FunctionCalculatorState();
}

class _FunctionCalculatorState extends State<FunctionCalculator> with TickerProviderStateMixin {
  List<String> _expression = [];
  List<String> _expressionDisplayer = [];
  String _xValue = '?';
  String _result = '';
  int _inputIndex = 0;
  String _mode = 'function';
  String _initialModeText = 'f(x)=';
  String _finalModeText = '';

  // Derivative options
  String _dxOrder = '1';

  // Solver conditions
  bool _openedParenthesis = false;
  bool _hasOperator = false;
  bool _canSolve = true;

  void changeInputIndex(int index) {
    setState(() {
      _inputIndex = index;
    });
  }

  void sendSnackbar(String text) {
    final snackBar = SnackBar(
      content: Text(text)
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void addNumberExpression(String expression, String value) {
    setState(() {
      switch (value) {
        // Pi
        case '3.14159265':
        // Euler number
        case '2.718281828':
          switch (_inputIndex) {
            case 0:
              _expression.add(value);
              _expressionDisplayer.add(expression);
            break;
            case 1:
              if (_xValue == '?') {
                _xValue = value; 
              } else {
                _xValue += value;
              }
            break;
          }
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
        break;
        case '(':
        case '^(':
        case 'sqrt(':
        case 'sin(':
        case 'cos(':
        case 'tan(':
        case 'asin(':
        case 'acos(':
        case 'atan(':
        case 'log(':
        case 'ln(':
        case 'exp(':
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
        break;
        default:
          switch (_inputIndex) {
            case 0:
              _expression.add(value);
              _expressionDisplayer.add(expression);
            break;
            case 1:
              if (_xValue == '?') {
                _xValue = value; 
              } else {
                _xValue += value;
              }
            break;
          }
        break;
      }

      if (_canSolve && !_openedParenthesis && _hasOperator) {
      }
    });
  }

  void addOperator(String operator, String value) {
    setState(() {
      _expressionDisplayer.add(operator);
      _expression.add(value);

      _hasOperator = true;
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
      
      switch (_inputIndex) {
        case 0:
          _expressionDisplayer.removeLast();
          _expression.removeLast();  
        break;
        case 1:
          print('hi');
          _xValue = _xValue.substring(0, _xValue.length - 1);
        break;
      }
    });
  }

  void enterExpression() async {
    if (_xValue == '?' && _mode == 'function') {
      sendSnackbar('Try plotting this function or give it an x value');
      return;
    }
    String result = 'x';
    switch (_mode) {
      case 'function':
        var solver = new SolveFunctionCalculator(x: _xValue, fx: _expression, mode: _mode);
        result = await solver.solveFunction();
      break;
      case 'derivative':
        var solver = new SolveFunctionCalculator(dxOrder: _dxOrder, fx: _expression, mode: _mode);
        result = await solver.solveFunction();
      break;
      default:
        var solver = new SolveFunctionCalculator(x: _xValue, fx: _expression, mode: _mode);
        result = await solver.solveFunction();
    }

    setState(() {
      _result = result;
      _inputIndex = 0;
    });
  }

  void deleteAllInput() {
    setState(() {
      _openedParenthesis = false;
      _hasOperator = false;
      _canSolve = true;
      _expression = [];
      _expressionDisplayer = [];
      _xValue = '?';
      _result = '';
    });
  }

  void changeCalculatorMode(String mode, String initialModeText, String finalModeText) {
    Navigator.of(context).pop();
    setState(() {
      _mode = mode;
      _initialModeText = initialModeText;
      _finalModeText = finalModeText;
    });
  }

  @override
  Widget build(BuildContext context) {

    void openFunctionMenu() {
      HapticFeedback.lightImpact();
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30)
          )
        ),
        builder: (context) => functionMenu()
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
                      children: [
                        TopBar(
                          mode: 'Function',
                          rightButtonFunction: openFunctionMenu
                        ),
                        SizedBox(height: 20),
                        InputResultPadFunctionCalculator(
                          mode: _mode,
                          expression: _expressionDisplayer,
                          result: _result,
                          xValue: _xValue,
                          inputIndex: _inputIndex,
                          changeInputIndex: changeInputIndex,
                          initialModeText: _initialModeText,
                          finalModeText: _finalModeText,
                        ),
                        SizedBox(height: 20),
                        FunctionPadFunctionCalculator(
                          addOperator: addOperator,
                          addNumberExpression: addNumberExpression,
                          addGlobalFunction: () => print('object')
                        ),
                        NumberPad(
                          addNumberExpression: addNumberExpression,
                          addOperator: addOperator,
                          deleteFromExpression: deleteFromExpression,
                          deleteAllInput: deleteAllInput,
                          enterExpression: enterExpression,
                          productIcon: '*',
                        )
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

  Widget functionMenu() => FunctionCalculatorMenu(
    changeCalculatorMode: changeCalculatorMode,
  );
}