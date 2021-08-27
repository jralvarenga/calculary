import 'dart:convert';
import 'dart:ui';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:calculary/services/custom_theme.dart';
import 'package:calculary/widgets/counter_calculator/counter_added_item.dart';
import 'package:calculary/widgets/counter_calculator/counter_options.dart';
import 'package:calculary/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  CounterCalculator({
    Key? key,
    required this.mathAPIAvaliable
  }) : super(key: key);
  
  final bool mathAPIAvaliable;

  @override
  _CounterCalculatorState createState() => _CounterCalculatorState();
}

class _CounterCalculatorState extends State<CounterCalculator> {
  String mode = 'Counter options';
  String _count = '0';
  String _tip = '0';
  List _counterItems = [];
  late TextEditingController _inputControler = TextEditingController(text: '1');

  @override
  void initState() {
    super.initState();
    getPreviewsCounter();
  }

  void getPreviewsCounter() async {
    final prefs = await SharedPreferences.getInstance();
    String previewsCount = (prefs.getString('counter_calculator_count') ?? '0');
    String previewsTip = (prefs.getString('counter_calculator_tip') ?? '0');
    var previewsCounterItemsJson = (prefs.getString('counter_calculator_items') ?? '[]');
    final parsedPreviewsItemsJson = jsonDecode(previewsCounterItemsJson).cast<Map<String, dynamic>>();
    List previewsCounterItems = parsedPreviewsItemsJson.map<CounterItemData>((json) => CounterItemData.fromJson(json)).toList();
    String previewsInputText = (prefs.getString('counter_calculator_input_value') ?? '1');

    setState(() {
      _count = previewsCount;
      _counterItems = previewsCounterItems;
      _tip = previewsTip;
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
    String tip = (prefs.getString('tip_value') ?? '10');
    String counterNewValue = _inputControler.text;
    counterNewValue =  counterNewValue.replaceAll(',', '.');
    counterNewValue =  counterNewValue.replaceAll(' ', '');
    var newCounter = double.parse(_count) + double.parse(counterNewValue);
    newCounter.toStringAsFixed(2);
    var newTip = newCounter + newCounter*(double.parse(tip)/100);

    HapticFeedback.lightImpact();
    setState(() {
      _count = newCounter.toString();
      _tip = newTip.toString();
      _counterItems.add(CounterItemData(
        amount: counterNewValue
      ));

      prefs.setString('counter_calculator_count', _count);
      prefs.setString('counter_calculator_tip', _tip);
      prefs.setString('counter_calculator_items', jsonEncode(_counterItems));
      prefs.setString('counter_calculator_input_value', _inputControler.text);
    });
  }

  void removeFromCount(int i) async {
    final prefs = await SharedPreferences.getInstance();
    String tip = (prefs.getString('tip_value') ?? '10');
    List reversedItems = _counterItems.reversed.toList();
    var newCounter = double.parse(_count) - double.parse(reversedItems[i].amount);
    reversedItems.removeAt(i);
    var newTip = newCounter + newCounter*(double.parse(tip)/100);

    HapticFeedback.lightImpact();
    setState(() {
      _count = newCounter.toString();
      _tip = newTip.toString();
      _counterItems = reversedItems.reversed.toList();
      
      prefs.setString('counter_calculator_count', _count);
      prefs.setString('counter_calculator_tip', _tip);
      prefs.setString('counter_calculator_items', jsonEncode(_counterItems));
      prefs.setString('counter_calculator_input_value', _inputControler.text);
    });
  }

  void resetCounter() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _count = '0';
      _tip = '0';
      _counterItems = [];
      
      prefs.setString('counter_calculator_count', _count);
      prefs.setString('counter_calculator_tip', _tip);
      prefs.setString('counter_calculator_items', jsonEncode(_counterItems));
      prefs.setString('counter_calculator_input_value', '1');
    });

    Navigator.of(context).pop();
  }
  
  @override
  Widget build(BuildContext context) {
    CustomTheme theme = Provider.of(context);
    var themeData = theme.themeData;

    void openCounterOptions() {
      HapticFeedback.lightImpact();

      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30)
          )
        ),
        builder: (context) => buildSheet()
      );
    }

    void unFocusKeyboard() {
      FocusScopeNode currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    return GestureDetector(
      // Dismise keyboard
      onTap: unFocusKeyboard,
      child: Scaffold(
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
                            mode: AppLocalizations.of(context)!.counter_options,
                            rightButtonFunction: () => openCounterOptions(),
                            mathAPIAvaliable: widget.mathAPIAvaliable,
                          ),
                          Container(
                            alignment: Alignment(1, 1),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 60, bottom: 30),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: themeData.dialogBackgroundColor,
                                      ),
                                      child: Text(
                                        "Tip: $_tip"
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 30),
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
                                        AppLocalizations.of(context)!.add,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white
                                        ),
                                      ),
                                    ),
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
      ),
    );
  }

  Widget buildSheet() => CounterOptions(
    resetCounter: resetCounter
  );
}