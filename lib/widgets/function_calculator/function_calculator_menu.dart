import 'package:calculary/services/custom_theme.dart';
import 'package:charcode/charcode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FunctionCalculatorMenu extends StatelessWidget {
  const FunctionCalculatorMenu({
    Key? key,
    required this.changeCalculatorMode
  }) : super(key: key);

  final changeCalculatorMode;

  @override
  Widget build(BuildContext context) {
    CustomTheme theme = Provider.of(context);
    var themeData = theme.themeData;

    return Container(
      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 8,
            decoration: BoxDecoration(
              color: themeData.dialogBackgroundColor,
              borderRadius: BorderRadius.circular(20)
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MenuBottomSheetItem(
                itemName: 'Fx',
                itemFunction: () => changeCalculatorMode('function', 'f(x)=', ''),
              ),
              MenuBottomSheetItem(
                itemName: 'Derivative',
                itemFunction: () => changeCalculatorMode('derivative', 'd/dx(', ')'),
              ),
            ]
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MenuBottomSheetItem(
                itemName: 'Plot',
                itemFunction: () => changeCalculatorMode('plot', 'Plot: f(x)=', ''),
              ),
              MenuBottomSheetItem(
                itemName: 'Integral',
                itemFunction: () => changeCalculatorMode('integral', String.fromCharCode($int) + '(', ')dx'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class MenuBottomSheetItem extends StatelessWidget {
  MenuBottomSheetItem({
    Key? key,
    required this.itemName,
    required this.itemFunction,
  }) : super(key: key);

  final String itemName;
  final itemFunction;
  
  @override
  Widget build(BuildContext context) {
    CustomTheme theme = Provider.of(context);
    var themeData = theme.themeData;

    return Material(
      color: themeData.dialogBackgroundColor,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: itemFunction,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.40,
          padding: EdgeInsets.all(20),
          child: Center(
            child: Text(
              itemName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
          )
        )
      ),
    );
  }
}