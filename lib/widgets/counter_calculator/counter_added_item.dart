// ignore: must_be_immutable
import 'package:calculary/services/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterAddedItem extends StatelessWidget {
  CounterAddedItem({
    Key? key,
    required this.addedAmount,
    required this.itemIndex,
    required this.removeFromCount
  }) : super(key: key);

  final String addedAmount;
  final int itemIndex;
  final Function removeFromCount;

  @override
  Widget build(BuildContext context) {
    CustomTheme theme = Provider.of(context);
    var themeData = theme.themeData;

    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: themeData.dialogBackgroundColor,
          width: 2
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Added amount: ' + addedAmount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
          IconButton(
            onPressed: () => removeFromCount(itemIndex),
            icon: Icon(
              Icons.delete
            )
          ),
        ],
      ),    
    );
  }
}