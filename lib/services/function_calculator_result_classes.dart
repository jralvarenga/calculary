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
  String derivative;

  Map toJson() => {
    'fx': fx,
    'order': int.parse(order)
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
    this.order = '1'
  });
}