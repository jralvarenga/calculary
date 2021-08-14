import 'dart:convert';
import 'dart:ui';

import 'package:calculary/services/CustomTheme.dart';
import 'package:calculary/widgets/TopBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterItemData {
  String amount;

  Map toJson() => {
    'amount': amount,
  };

  factory CounterItemData.fromJson(Map<String, dynamic> json) {
    return CounterItemData(
      amount: json['amount'] as String,
    );
  }

  CounterItemData({
    Key? key,
    required this.amount,
  });
}

class AllCounterData {
  String count;
  List counterItems;
  String addAmount;

  AllCounterData({
    Key? key,
    required this.count,
    required this.counterItems,
    this.addAmount = '1'
  });
}

class CounterCalculator extends StatefulWidget {
  CounterCalculator({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CounterCalculatorState createState() => _CounterCalculatorState();
}

class _CounterCalculatorState extends State<CounterCalculator> {
  String mode = 'Counter options';
  String _count = '0';
  List _counterItems = [];
  late TextEditingController _inputControler;

  @override
  void initState() {
    super.initState();
    getPreviewsCounter();
  }

  void getPreviewsCounter() async {
    final prefs = await SharedPreferences.getInstance();
    String previewsCount = (prefs.getString('counter_calculator_count') ?? '0');
    var previewsCounterItemsJson = (prefs.getString('counter_calculator_items') ?? '[]');
    final parsedPreviewsItemsJson = jsonDecode(previewsCounterItemsJson).cast<Map<String, dynamic>>();
    List previewsCounterItems = parsedPreviewsItemsJson.map<CounterItemData>((json) => CounterItemData.fromJson(json)).toList();
    String previewsInputText = (prefs.getString('counter_calculator_input_value') ?? '1');

    setState(() {
      _count = previewsCount;
      _counterItems = previewsCounterItems;
      _inputControler = TextEditingController(text: previewsInputText);
    });
  }

  @override
  void dispose() {
    _inputControler.dispose();
    super.dispose();
  }

  void addToCounter() async {
    final prefs = await SharedPreferences.getInstance();
    String counterNewValue = _inputControler.text;
    var newCounter = double.parse(_count) + double.parse(counterNewValue);

    newCounter.toStringAsFixed(2);
    setState(() {
      _count = newCounter.toString();
      _counterItems.add(CounterItemData(
        amount: counterNewValue
      ));

      prefs.setString('counter_calculator_count', _count);
      prefs.setString('counter_calculator_items', jsonEncode(_counterItems));
      prefs.setString('counter_calculator_input_value', _inputControler.text);
    });
  }

  void removeFromCount(int i) async {
    final prefs = await SharedPreferences.getInstance();
    List reversedItems = _counterItems.reversed.toList();
    var newCounter = double.parse(_count) - double.parse(reversedItems[i].amount);
    reversedItems.removeAt(i);

    setState(() {
      _count = newCounter.toString();
      _counterItems = reversedItems.reversed.toList();
      
      prefs.setString('counter_calculator_count', _count);
      prefs.setString('counter_calculator_items', jsonEncode(_counterItems));
      prefs.setString('counter_calculator_input_value', _inputControler.text);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    CustomTheme theme = Provider.of(context);
    var themeData = theme.themeData;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    child: Column(
                      children: [
                        TopBar(
                          mode: mode,
                          rightButtonFunction: () => print('hi')
                        ),
                        Container(
                          alignment: Alignment(1, 1),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 60, bottom: 60),
                                child: Center(
                                  child: Text(
                                    _count,
                                    style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(20),
                                child: Center(
                                  child: Container(
                                    child:Container(
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold
                                        ),
                                        controller: _inputControler,
                                      ),
                                    )
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: addToCounter,
                                    style: TextButton.styleFrom(
                                      backgroundColor: themeData.primaryColor,
                                      padding: EdgeInsets.only(top: 15, bottom: 15, right: 50, left: 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                    child: Text(
                                      'Add',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white
                                      ),
                                    )
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: Container(
                            child: ListView.separated(
                              itemCount: _counterItems.length,
                              separatorBuilder: (_, i) => SizedBox(
                                height: 5,
                              ),
                              itemBuilder: (_, i) => Container(
                                child: CounterAddedItem(
                                  addedAmount: _counterItems.reversed.toList()[i].amount,
                                  itemIndex: i,
                                  removeFromCount: removeFromCount
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              ],
            )
          ),
        ),
      )
    );
  }
}

// ignore: must_be_immutable
class CounterAddedItem extends StatelessWidget {
  CounterAddedItem({
    Key? key,
    required this.addedAmount,
    required this.itemIndex,
    required this.removeFromCount
  }) : super(key: key);

  String addedAmount;
  int itemIndex;
  Function removeFromCount;

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