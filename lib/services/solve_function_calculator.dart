import 'dart:convert';

import 'package:calculary/services/function_calculator_result_classes.dart';
import 'package:http/http.dart' as http;

class SolveFunctionCalculator {
  List<String> fx;
  String x;
  String mode;

  SolveFunctionCalculator({
    required this.x,
    required this.fx,
    required this.mode,
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
      return FunctionData.fromJson(jsonDecode(response.body)).result.toString();
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
  
  Future<String> solveFunction() async {
    String fx = this.fx.join();
    switch (this.mode) {
      case 'function':
        String url = 'https://mathapi.vercel.app/api/function/solve/';
        String formatedData = formatForFunction(fx);

        String result = await sendData(formatedData, url);
        return result;
      default:
        return '';
    }
  }

}