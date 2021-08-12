import 'package:flutter/material.dart';

class CounterCalculator extends StatefulWidget {
  CounterCalculator({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CounterCalculator createState() => _CounterCalculator();
}

class _CounterCalculator extends State<CounterCalculator> {
  
  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.red,
      child: Center(
        child: Text('data'),
      ),
    );
  }
}