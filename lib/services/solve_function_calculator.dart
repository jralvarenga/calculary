import 'dart:convert';

import 'package:calculary/services/function_calculator_result_classes.dart';
import 'package:http/http.dart' as http;

class SolveFunctionCalculator {
  List<String> fx;
  String x;
  String mode;

  String dxOrder;
  double dxX;
  bool evaluateDx;

  String from;
  String to;

  bool evaluateIntegral;
  String a;
  String b;

  SolveFunctionCalculator({
    required this.fx,
    required this.mode,
    this.x = '1',
    this.dxOrder = '1',
    this.dxX = 1,
    this.evaluateDx = false,
    this.evaluateIntegral = false,
    this.a = '0',
    this.b = '1',
    this.from = '-10',
    this.to = '10'
  });

  Future<String> sendData(String body, String url) async {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String> {
        'Content-Type': 'application/json'
      },
      body: body
    );

    if (response.statusCode == 200) {
      switch (this.mode) {
        case 'function':
          return FunctionData.fromJson(jsonDecode(response.body)).result.toString();
        case 'derivative':
          if (this.evaluateDx) {
            return DerivativenData.fromJson(jsonDecode(response.body)).derivative.toString(); 
          } else {
            return DerivativenData.fromJson(jsonDecode(response.body)).derivative;
          }
        case 'integral':
          return IntegralData.fromJson(jsonDecode(response.body)).integral;
        case 'plot':
          String result = response.body;
          result = result.replaceAll('{"x": ', '');
          result = result.replaceAll(', "y": ', ';');
          result = result.replaceAll('}', '');
          return result;
        default:
          return FunctionData.fromJson(jsonDecode(response.body)).result.toString();
      }
    } else {
      return 'Error';
    }
  }

  String formatForFunction(String fx) {
    FunctionData data = FunctionData(
      fx: fx,
      value: double.parse(this.x)
    );
    return jsonEncode(data.toJson());
  }
  String formatForDerivative(String fx) {
    DerivativenData data = DerivativenData(
      fx: fx,
      x: this.dxX
    );
    return jsonEncode(data.toJson());
  }
  String formatForIntegral(String fx) {
    IntegralData data = IntegralData(
      fx: fx,
      a: this.a,
      b: this.b,
    );
    return jsonEncode(data.toJson());
  }
  String formatForPlot(String fx) {
    PlotData data = PlotData(
      fx: fx,
      from: this.from,
      to:  this.to,
    );
    return jsonEncode(data.toJson());
  }

  String formatExpressionInput(List<String> expression) {
    List<String> newExp = [];
    for (var i = 0; i < expression.length; i++) {
      String item = expression[i];
      if (item == 'x') {
        if (i != 0) {
          if (expression[i-1].contains(new RegExp(r'[0-9]')) || expression[i-1].contains(')')) {
            newExp.add('*');
          }
        }
      }
      newExp.add(item);
    }

    String joinedExpression = newExp.join();
    joinedExpression = joinedExpression.replaceAll(')(', ')*(');

    return joinedExpression;
  }
  
  Future<String> solveFunction() async {
    String fx = formatExpressionInput(this.fx);
    switch (this.mode) {
      case 'function':
        String url = 'https://mathapi.vercel.app/api/function/solve/';
        String formatedData = formatForFunction(fx);

        String result = await sendData(formatedData, url);
        return result;
      case 'derivative':
        String url = 'https://mathapi.vercel.app/api/derivative/';
        if (this.evaluateDx) {
          url = url + 'evaluate/';
        }

        url = url + '?order=' + this.dxOrder;
        String formatedData = formatForDerivative(fx);
        String result = await sendData(formatedData, url);
        return result;
      case 'integral':
        String url = 'https://mathapi.vercel.app/api/integral/';
        if (this.evaluateIntegral) {
          url = url + 'evaluate/';
        }

        String formatedData = formatForIntegral(fx);
        String result = await sendData(formatedData, url);
        return result;
      case 'plot':
        String url = 'https://mathapi.vercel.app/api/function/points/?step=0.5';
        String formatedData = formatForPlot(fx);
        String result = await sendData(formatedData, url);

        return result;
      default:
        return '';
    }
  }

}