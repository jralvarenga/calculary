import 'package:calculary/services/CustomTheme.dart';
import 'package:calculary/widgets/TopBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterCalculator extends StatefulWidget {
  CounterCalculator({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CounterCalculatorState createState() => _CounterCalculatorState();
}

class _CounterCalculatorState extends State<CounterCalculator> {
  String mode = 'Counter options';
  String _count = '0';
  late TextEditingController _inputControler;

  @override
  void initState() {
    super.initState();
    _inputControler = TextEditingController(text: '1');
  }

  @override
  void dispose() {
    _inputControler.dispose();
    super.dispose();
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () => print('delete'),
                                    icon: Icon(
                                      Icons.backspace,
                                      color: Colors.red[300],
                                    )
                                  ),
                                  TextButton(
                                    onPressed: () => print('add'),
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all<EdgeInsets>(
                                        EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10)
                                      ),
                                      backgroundColor: MaterialStateProperty.all(themeData.primaryColor),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        )
                                      )
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
                        )
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