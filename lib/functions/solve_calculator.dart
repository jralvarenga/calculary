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
  String solve_expretion() {
    String _input = create_operators(this.input);
    Expression exp = p.parse(_input);
    ContextModel cm = ContextModel();

    //String result = exp.evaluate(EvaluationType.REAL, cm);//.toStringAsFixed(6);
    String evaluatedResult = exp.evaluate(EvaluationType.REAL, cm).toString();
    String result = format_string_result(evaluatedResult);

    return result;
  }

  // ignore: non_constant_identifier_names
  bool has_number() {
    bool found = this.input.contains(new RegExp(r'[0-9]'));

    return found;
  }
}