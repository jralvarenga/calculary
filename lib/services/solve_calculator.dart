import 'package:calculary/function/gamma_function.dart';
import 'package:math_expressions/math_expressions.dart';

class SolveMainCalculator {
  Parser p = Parser();
  List<String> expression;
  String globalFunction;

  SolveMainCalculator(
    this.expression,
    this.globalFunction
  );

  String formatResult(String result) {
    List<String> decimals = result.split('.');

    if (decimals[1] == '0') {
      return decimals[0];
    }

    if (decimals[1].length >= 8) {
      var number = double.parse(result);
      var reduced = number.toStringAsFixed(8);
      return reduced.toString().replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
    }

    return result;
  }

  String factorialSolver(String number) {
    double num = double.parse(number);
    var factorial = gamma(num + 1);

    return factorial.toString();
  }

  String evaluateAllInstances() {
    ContextModel cm = ContextModel();
    String joinedExpression = this.expression.join();

    if (joinedExpression.contains(')(')) {
      joinedExpression = joinedExpression.replaceAll(')(', ')*(');
    }
    
    List<String> splitted = joinedExpression.split(' ');
    var values = [];
    bool error = false;

    for (var i = 0; i < splitted.length; i++) {
      String _input = splitted[i];
      String expValue = '';

      if (_input.contains('!') == true) {
        // Is factorial case
        String value = factorialSolver(_input.replaceAll('!', ''));
        if (value == 'error') {
          error = true;
          break; 
        }
        expValue = value;
      } else {
        // Default case
        Expression exp = p.parse(_input);
        expValue = exp.evaluate(EvaluationType.REAL, cm).toString();
      }
      values.add(expValue);
    }

    if (error) {
      return 'ERROR';
    } else {
      String newInput = values.join();
      Expression exp = p.parse(newInput);
      
      String evaluatedResult = exp.evaluate(EvaluationType.REAL, cm).toString();
      return evaluatedResult;
    }
  }

  String getExpressionAvg() {
    ContextModel cm = ContextModel();
    Expression exp = p.parse(this.expression.join());
    int total = this.expression.length;

    String expValue = exp.evaluate(EvaluationType.REAL, cm).toString();
    var result = (double.parse(expValue) / total);
    return result.toString();
  }

  String solveWithPercentage() {
    List<String> reversedExpression = this.expression.reversed.toList();
    int lastOperatorPosition = 0;
    String numberValuesAfterOperator = '';
    String percentageSign = '';

    for (var i = 0; i < reversedExpression.length; i++) {
      String item = reversedExpression[i];
      if (item == '+' || item == '-' || item == '*' || item == '/') {
        percentageSign = reversedExpression[i];
        lastOperatorPosition = i;
        break;
      }
    }
    
    for (var i = 0; i < lastOperatorPosition; i++) {
      numberValuesAfterOperator += reversedExpression[i];
    }
    for (var i = 0; i < lastOperatorPosition; i++) {
      reversedExpression.removeAt(i);
    }

    String percentageNumberString = numberValuesAfterOperator.split('').reversed.toList().join();
    double percentage = double.parse(percentageNumberString)/100;
    
    List<String> newExpression = reversedExpression.reversed.toList();
    newExpression.removeLast();
    this.expression = newExpression;
    var expressionResult = evaluateAllInstances();
    double expressionWithPercentage = percentage * double.parse(expressionResult);
    List<String> expressionEvaluator = [expressionResult, percentageSign, expressionWithPercentage.toString()];
    this.expression = expressionEvaluator;
    String result = evaluateAllInstances();

    return result;
  }

  String solveExpression() {
    String evaluatedResult = '';

    switch (this.globalFunction) {
      case 'AVG':
        evaluatedResult = getExpressionAvg();
      break;
      case 'PEG':
        evaluatedResult = solveWithPercentage();
      break;
      default:
        evaluatedResult = evaluateAllInstances();
      break;
    }
    
    if (evaluatedResult == 'ERROR') {
      return 'ERROR';
    } else {
      String result = formatResult(evaluatedResult);
      return result;
    }
  }

  // ignore: non_constant_identifier_names
  bool has_number() {
    bool found = this.expression.contains(new RegExp(r'[0-9]'));

    return found;
  }
}