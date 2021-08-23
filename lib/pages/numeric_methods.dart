import 'package:calculary/widgets/numeric_methods/nm_top_bar.dart';
import 'package:flutter/material.dart';

class NumericMethods extends StatefulWidget {
  const NumericMethods({
    Key? key,
    required this.methodName,
    required this.methodURI
  }) : super(key: key);

  final String methodName;
  final String methodURI;

  @override
  _NumericMethodsState createState() => _NumericMethodsState();
}

class _NumericMethodsState extends State<NumericMethods> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    child: Column(
                      children: [
                        NMTopBar(
                          mode: widget.methodName
                        )
                      ],
                    ),
                  )
                )
              ],
            ),
          ),
        )
      )
    );
  }
}