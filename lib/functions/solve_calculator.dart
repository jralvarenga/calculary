import 'package:math_expressions/math_expressions.dart';

class SolveMainCalculator {
  Parser p = Parser();
  String input;
  String globalFunction;

  SolveMainCalculator(
    this.input,
    this.globalFunction
  );

  String formatResult(String result) {
    print(result);
    var number = double.parse(result);

    if (number % 1 != 0) {
      return number.toString();
    } else {
      if (result.length > 9) {
        return number.toStringAsFixed(9).toString();
      } else {
        return number.round().toString();
      }
    }
  }

  String factorialSolver(String number) {
    var factorial = 1;
    var num = double.parse(number);
    print(num is int);

    if (num is int) {
      for (var i = 1; i <= num; i++) {
        factorial = factorial*i;
      }
      return factorial.toString();
    } else {
      return 'error';
    }
  }

  String evaluateAllInstances() {
    ContextModel cm = ContextModel();
    var splitted = this.input.split(' ');
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

  String getExpretionAvg() {
    ContextModel cm = ContextModel();
    Expression exp = p.parse(this.input);
    var splitted = this.input.split(new RegExp(r'[+-]'));
    int total = splitted.length;

    String expValue = exp.evaluate(EvaluationType.REAL, cm).toString();
    var result = (double.parse(expValue) / total);
    return result.toString();
  }

  String solveExpretion() {
    String evaluatedResult = '';

    if (this.globalFunction == 'AVG') {
      evaluatedResult = getExpretionAvg();
    } else {
      evaluatedResult = evaluateAllInstances();
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
    bool found = this.input.contains(new RegExp(r'[0-9]'));

    return found;
  }
}