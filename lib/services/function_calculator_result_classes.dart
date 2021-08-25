class FunctionData {
  String fx;
  double value;
  double result;

  Map toJson() => {
    'fx': fx,
    'value': value,
  };

  factory FunctionData.fromJson(Map<String, dynamic> json) {
    return FunctionData(
      result: json['result'],
    );
  }

  FunctionData({
    this.fx = 'x',
    this.value = 0,
    this.result = 0
  });
}

class DerivativenData {
  String fx;
  String order;
  double x;
  var derivative;

  Map toJson() => {
    'fx': fx,
    'x': x,
  };

  factory DerivativenData.fromJson(Map<String, dynamic> json) {
    return DerivativenData(
      derivative: json['derivative'],
      order: json['order'].toString()
    );
  }

  DerivativenData({
    this.fx = 'x',
    this.derivative = 'x',
    this.order = '1',
    this.x = 1
  });
}

class IntegralData {
  String fx;
  String order;
  String integral;
  String a;
  String b;

  Map toJson() => {
    'fx': fx,
    'a': a,
    'b': b
  };

  factory IntegralData.fromJson(Map<String, dynamic> json) {
    return IntegralData(
      integral: json['integral'],
    );
  }

  IntegralData({
    this.fx = 'x',
    this.integral = 'x',
    this.order = '1',
    this.a = '0',
    this.b = '1',
  });
}

class PlotData {
  String fx;
  String from;
  String to;
  List<double> x;
  List<double> y;

  Map toJson() => {
    'fx': fx,
    'from': double.parse(from),
    'to': double.parse(to),
  };

  factory PlotData.fromJson(Map<String, List<double>> json) {
    return PlotData(
      x: json['x']!,
      y: json['y']!,

    );
  }

  PlotData({
    this.fx = 'x',
    this.from = '-10',
    this.to = '10',
    this.x = const [0],
    this.y = const [0],
  });
}