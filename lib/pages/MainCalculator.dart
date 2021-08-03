import 'package:calculary/widgets/FunctionsPad.dart';
import 'package:calculary/widgets/NumberPad.dart';
import 'package:flutter/material.dart';

class MainCalculator extends StatefulWidget {
  MainCalculator({Key? key, required this.title}) : super(key: key);

  final String title;
  
  @override
  _MainCalculator createState() => _MainCalculator();
}

class _MainCalculator extends State<MainCalculator> {
  String _expretion = '';
  String _currentOperator = '';

  void addNumber(String number) {
    print(number);
  }

  void addOperator(String function) {
    print(function);
  }

  void deleteFromExpretion() {
    print('delete');
  }

  void enterExpretion() {
    print('enter');
  }
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FunctionsPad(
                addOperator: addOperator
              ),
              NumberPad(
                addNumber: addNumber,
                addOperator: addOperator,
                deleteFromExpretion: deleteFromExpretion,
                enterExpretion: enterExpretion
              )
            ]
          ),
        ),
      ),
    );
  }
}
