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