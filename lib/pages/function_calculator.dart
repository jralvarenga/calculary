import 'dart:convert';

import 'package:calculary/services/solve_function_calculator.dart';
import 'package:calculary/widgets/function_calculator/function_calculator_menu.dart';
import 'package:calculary/widgets/function_calculator/function_pad.dart';
import 'package:calculary/widgets/function_calculator/input_result_pad.dart';
import 'package:calculary/widgets/function_calculator/plot_widget.dart';
import 'package:calculary/widgets/number_pad.dart';
import 'package:calculary/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FunctionCalculator extends StatefulWidget {
  const FunctionCalculator({
    Key? key,
    required this.mathAPIAvaliable
  }) : super(key: key);

  final bool mathAPIAvaliable;

  @override
  _FunctionCalculatorState createState() => _FunctionCalculatorState();
}

class _FunctionCalculatorState extends State<FunctionCalculator> with TickerProviderStateMixin {
  List<String> _expression = [];
  List<String> _expressionDisplayer = [];
  String _xValue = '?';
  String _result = '';
  bool _loadingResult = false;
  int _inputIndex = 0;
  String _mode = 'function';
  String _initialModeText = 'f(x)=';
  String _finalModeText = '';

  // Derivative options
  String _dxOrder = '1';
  String _dxXValue = '?';
  int _derivativeIndexOptions = 0;

  // Integral options
  String _integralAValue = '?';
  String _integralBValue = '?';
  int _integralIndexOptions = 0;

  // Plot options
  String _from = '-10';
  String _to = '10';
  int _plotIndexOptions = 0;
  List<dynamic> _xValues = [0];
  List<dynamic> _yValues = [0];

  // Solver conditions
  bool _openedParenthesis = false;
  bool _hasOperator = false;
  bool _canSolve = true;

  void changeInputIndex(int index) {
    setState(() {
      _inputIndex = index;
    });
  }

  void changeIntegralIndex(int index) {
    setState(() {
      _inputIndex = 1;
      _integralIndexOptions = index;
    });
  }

  void changePlotIndex(int index) {
    setState(() {
      _inputIndex = 1;
      _plotIndexOptions = index;
    });
  }

  void changeDerivativeIndex(int index) {
    setState(() {
      _inputIndex = 1;
      _derivativeIndexOptions = index;
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
        case 'pi':
        // Euler number
        case 'e':
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
              switch (_mode) {
                case 'derivative':
                  switch (_derivativeIndexOptions) {
                    case 0:
                      _dxOrder = value;
                    break;
                    case 1:
                      if (_dxXValue == '?') {
                        _dxXValue = value;
                      } else {
                        _dxXValue += value;
                      }
                    break;
                  }
                break;
                case 'integral':
                  switch (_integralIndexOptions) {
                    case 0:
                      if (_integralAValue == '?') {
                        _integralAValue = value;
                      } else {
                        _integralAValue += value;
                      }
                    break;
                    case 1:
                      if (_integralBValue == '?') {
                        _integralBValue = value;
                      } else {
                        _integralBValue += value;
                      }
                    break;
                  }
                break;
                case 'plot':
                  switch (_plotIndexOptions) {
                    case 0:
                      _from += value;
                    break;
                    case 1:
                      _to += value;
                    break;
                  }
                break;
                case 'function':
                  if (_xValue == '?') {
                    _xValue = value;
                  } else {
                    _xValue += value;
                  }
                break;
                default:
                  if (_xValue == '?') {
                    _xValue = value;
                  } else {
                    _xValue += value;
                  }
                break;
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
          switch (_mode) {
            case 'derivative':
              switch (_derivativeIndexOptions) {
                case 0:
                  _dxOrder = _dxOrder.substring(0, _dxOrder.length - 1);
                break;
                case 1:
                  _dxXValue = _dxXValue.substring(0, _dxXValue.length - 1);
                break;
              }
            break;
            case 'integral':
              switch (_integralIndexOptions) {
                case 0:
                  _integralAValue = _integralAValue.substring(0, _integralAValue.length - 1);
                break;
                case 1:
                  _integralBValue = _integralBValue.substring(0, _integralBValue.length - 1);
                break;
              }
            break;
            case 'plot':
              switch (_plotIndexOptions) {
                case 0:
                  _from = _from.substring(0, _from.length - 1);
                break;
                case 1:
                  _to = _to.substring(0, _to.length - 1);
                break;
              }
            break;
            case 'function':
              _xValue = _xValue.substring(0, _xValue.length - 1);
            break;
            default:
              _xValue = _xValue.substring(0, _xValue.length - 1);
            break;
          }
        break;
      }
    });
  }

  void enterExpression() async {
    setState(() {
      _loadingResult = true;
    });
    String result = 'x';
    switch (_mode) {
      case 'function':
        if (_xValue == '?') {
          sendSnackbar('Try plotting this function or give it an x value');
          setState(() => _loadingResult = false);
          return;
        }
        var solver = new SolveFunctionCalculator(x: _xValue, fx: _expression, mode: _mode);
        result = await solver.solveFunction();
      break;
      case 'derivative':
        bool evaluateDx = true;
        if (_dxOrder == '?' || _dxOrder == '' || _dxOrder == '0') {
          sendSnackbar("Order of dx can't be null or 0");
          setState(() => _loadingResult = false);
          return;
        }
        if (_dxXValue == '?' || _dxXValue == '') {
          evaluateDx = false;
        }
        var solver = new SolveFunctionCalculator(
          evaluateDx: evaluateDx,
          dxX: (_dxXValue == '?' || _dxXValue == '') ? 1 : double.parse(_dxXValue),
          dxOrder: _dxOrder,
          fx: _expression,
          mode: _mode
        );
        result = await solver.solveFunction();
      break;
      case 'integral':
        bool evaluateIntegral = true;
        if ((_integralAValue == '?' || _integralAValue == '') || (_integralBValue == '?' || _integralBValue == '')) {
          evaluateIntegral = false;
        }
        var solver = new SolveFunctionCalculator(evaluateIntegral: evaluateIntegral, a: _integralAValue, b: _integralBValue, fx: _expression, mode: _mode);
        result = await solver.solveFunction();
      break;
      case 'plot':
        if ((_from == '?' || _from == '') || (_to == '?' || _to == '')) {
          sendSnackbar("Limits need to have a value");
          setState(() => _loadingResult = false);
          return;
        }
        result = '';
        var solver = new SolveFunctionCalculator(from: _from, to: _to, fx: _expression, mode: _mode);
        String values = await solver.solveFunction();
        List<dynamic> xValues = jsonDecode(values.split(';')[0]);
        List<dynamic> yValues = jsonDecode(values.split(';')[1]);
        setState(() {
          _xValues = xValues;
          _yValues = yValues;
        });
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => PlotWidget(
            x: _xValues,
            y: _yValues,
          )
        ));
      break;
      default:
        if (_xValue == '?') {
          sendSnackbar('Try plotting this function or give it an x value');
          setState(() => _loadingResult = false);
          return;
        }
        var solver = new SolveFunctionCalculator(x: _xValue, fx: _expression, mode: _mode);
        result = await solver.solveFunction();
    }

    setState(() {
      _result = result;
      _inputIndex = 0;
      _loadingResult = false;
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
      _dxOrder = '1';
      _dxXValue = '?';
      _integralAValue = '?';
      _integralBValue = '?';
      _from = '-10';
      _to = '10';
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
                          mode: 'Modes',
                          rightButtonFunction: openFunctionMenu,
                          mathAPIAvaliable: widget.mathAPIAvaliable,
                        ),
                        SizedBox(height: 20),
                        InputResultPadFunctionCalculator(
                          loadingResult: _loadingResult,
                          mode: _mode,
                          expression: _expressionDisplayer,
                          result: _result,
                          xValue: _xValue,
                          inputIndex: _inputIndex,
                          changeInputIndex: changeInputIndex,
                          initialModeText: _initialModeText,
                          finalModeText: _finalModeText,

                          dxOrder: _dxOrder,
                          dxXValue: _dxXValue,
                          changeDerivativeIndex: changeDerivativeIndex,
                          derivativeIndexOptions: _derivativeIndexOptions,

                          from: _from,
                          to: _to,
                          changePlotIndex: changePlotIndex,
                          plotIndexOptions: _plotIndexOptions,

                          integralAValue: _integralAValue,
                          integralBValue: _integralBValue,
                          changeIntegralIndex: changeIntegralIndex,
                          integralIndexOptions: _integralIndexOptions,
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