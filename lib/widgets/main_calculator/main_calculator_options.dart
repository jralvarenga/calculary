import 'package:calculary/services/custom_theme.dart';
import 'package:calculary/widgets/main_calculator/history_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainCalculatorOptions extends StatelessWidget {
  const MainCalculatorOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomTheme theme = Provider.of(context);
    var themeData = theme.themeData;

    void selectHistoryItem(int index) {
      print(index);
    }

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'History',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.transparent
                ),
              ),
              Text(
                'History',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              TextButton(
                onPressed: () => print('clear'),
                style: TextButton.styleFrom(
                  backgroundColor: themeData.dialogBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  )
                ),
                child: Text(
                  'Clear',
                  style: TextStyle(
                    color: theme.textColor
                  ),
                )
              )
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              child: ListView.separated(
                itemCount: [1, 2, 3].length,
                separatorBuilder: (_, i) => SizedBox(
                  height: 10,
                ),
                itemBuilder: (_, i) => Container(
                  child: HistoryItem(
                    index: 2,
                    expression: '2+6-9+pi',
                    result: '455',
                    selectItem: selectHistoryItem,
                  ),
                ),
              ),
            )
          )
        ],
      ),
    );
  }
}