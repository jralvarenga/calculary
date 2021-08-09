import 'package:math_expressions/math_expressions.dart';

class FactorialRes {
  final factorial ;

  FactorialRes({required this.factorial});

  factory FactorialRes.fromJson(Map<String, dynamic> json) {
    return FactorialRes(
      factorial: json['id'],
    );
  }
}

class SolveMainCalculator {
  Parser p = Parser();
  String input;

  SolveMainCalculator(
    this.input,
  );

  // ignore: non_constant_identifier_names
  String format_string_result(String result) {
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

  // ignore: non_constant_identifier_names
  String factorial_solver(String number) {
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

  // ignore: non_constant_identifier_names
  String evaluate_every_instance() {
    ContextModel cm = ContextModel();
    var splitted = this.input.split(' ');
    var values = [];
    bool error = false;

    for (var i = 0; i < splitted.length; i++) {
      String _input = splitted[i];
      String expValue = '';

      if (_input.contains('!') == true) {
        // Is factorial case
        String value = factorial_solver(_input.replaceAll('!', ''));
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

  // ignore: non_constant_identifier_names
  String solve_expretion() {
    String evaluatedResult = evaluate_every_instance();
    if (evaluatedResult == 'ERROR') {
      return 'ERROR';
    } else {
      String result = format_string_result(evaluatedResult);
      return result;
    }
  }

  // ignore: non_constant_identifier_names
  bool has_number() {
    bool found = this.input.contains(new RegExp(r'[0-9]'));

    return found;
  }
}