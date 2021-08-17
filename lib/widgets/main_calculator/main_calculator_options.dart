import 'package:calculary/services/custom_theme.dart';
import 'package:calculary/widgets/main_calculator/history_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HistoryItemData {
  List<String> expression;
  List<String> expressionDisplayer;
  String result;

  factory HistoryItemData.fromJson(Map<String, dynamic> json) {
    return HistoryItemData(
      expression: List<String>.from(json["expression"].map((x) => x)),
      expressionDisplayer: List<String>.from(json["expressionDisplayer"].map((x) => x)),
      result: json['result'] as String,
    );
  }
  
  HistoryItemData({
    Key? key,
    required this.expression,
    required this.expressionDisplayer,
    required this.result,
  });
}

class MainCalculatorOptions extends StatefulWidget {
  const MainCalculatorOptions({
    Key? key,
    required this.history,
    required this.setItemsFromHistory,
    required this.resetHistory,
    required this.setANS
  }) : super(key: key);

  final List history;
  final Function setItemsFromHistory;
  final resetHistory;
  final setANS;

  @override
  _MainCalculatorOptionsState createState() => _MainCalculatorOptionsState();
}

class _MainCalculatorOptionsState extends State<MainCalculatorOptions> {

  @override
  Widget build(BuildContext context) {
    CustomTheme theme = Provider.of(context);
    var themeData = theme.themeData;
    final List calculatorHistory = widget.history;

    void selectHistoryItem(int index) {
      HapticFeedback.lightImpact();
      List reversedHistory = calculatorHistory.reversed.toList();
      var historyItem = reversedHistory[index];
      widget.setItemsFromHistory(historyItem);
    }

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: widget.setANS,
                style: TextButton.styleFrom(
                  backgroundColor: themeData.dialogBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  )
                ),
                child: Text(
                  'ANS',
                  style: TextStyle(
                    color: theme.textColor
                  ),
                )
              ),
              Text(
                'History',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              TextButton(
                onPressed: widget.resetHistory,
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
                itemCount: calculatorHistory.length,
                separatorBuilder: (_, i) => SizedBox(
                  height: 10,
                ),
                itemBuilder: (_, i) => Container(
                  child: HistoryItem(
                    index: i,
                    expression: calculatorHistory.reversed.toList()[i].expressionDisplayer.join(),
                    result: calculatorHistory.reversed.toList()[i].result,
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