import 'package:flutter/material.dart';

class CounterCalculator extends StatefulWidget {
  CounterCalculator({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CounterCalculatorState createState() => _CounterCalculatorState();
}

class _CounterCalculatorState extends State<CounterCalculator> {
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: Text('hi'),
          ),
        ),
      )
    );
  }
}