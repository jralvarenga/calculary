import 'dart:ffi';

import 'package:math_expressions/math_expressions.dart';
// ignore: unused_import
import "dart:math" as math;

class SolveMainCalculator {
  Parser p = Parser();
  String input;

  SolveMainCalculator(
    this.input,
  );

  // ignore: non_constant_identifier_names
  String create_operators(String input) {
    var value = input.replaceAll('x', '*');
    value = input.replaceAll('pi', 'math.pi');

    return value;
  }

  // ignore: non_constant_identifier_names
  String format_string_result(String result) {
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

  // ignore: non_constant_identifier_names
  String evaluate_every_instance() {
    ContextModel cm = ContextModel();
    var splitted = this.input.split(' ');
    var values = [];
    for (var i = 0; i < splitted.length; i++) {
      String _input = splitted[i];
      Expression exp = p.parse(_input);

      String evValue = exp.evaluate(EvaluationType.REAL, cm).toString();
      values.add(evValue);
    }
    print(values);
    String newInput = values.join();
    Expression exp = p.parse(newInput);
    
    String evaluatedResult = exp.evaluate(EvaluationType.REAL, cm).toString();
    return evaluatedResult;
  }

  // ignore: non_constant_identifier_names
  String solve_expretion() {
    String evaluatedResult = evaluate_every_instance();
    String result = format_string_result(evaluatedResult);
    return result;
  }

  // ignore: non_constant_identifier_names
  bool has_number() {
    bool found = this.input.contains(new RegExp(r'[0-9]'));

    return found;
  }
}