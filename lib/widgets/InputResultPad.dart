import 'package:flutter/material.dart';

class InputResultPad extends StatelessWidget {
  InputResultPad({
    Key? key,
    required this.input,
    required this.result,
    required this.visibleInput,
    required this.visibleResult,
  }) : super(key: key);

  final String input;
  final String result;
  final bool visibleInput;
  final bool visibleResult;
  
  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment(1.0, 1.0),
      child: Column(
        children: [
          // Input container
          Container(
            alignment: Alignment(1, 1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100)
            ),
            child: AnimatedOpacity(
              opacity: visibleInput ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 15),
                child: Text(
                  input,
                  style: TextStyle(
                    fontSize: 45,
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
          // Result container
          Container(
            alignment: Alignment(1, 1),
            child: AnimatedOpacity(
              opacity: visibleResult ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  result,
                  style: TextStyle(
                    fontSize: 25,
                    color: Color.fromRGBO(114, 114, 114, 1),
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            )
          )
        ],
      )
    );
  }
}