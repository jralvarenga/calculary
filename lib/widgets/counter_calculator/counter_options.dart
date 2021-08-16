import 'package:calculary/services/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterOptions extends StatelessWidget {
  CounterOptions({
    Key? key,
    required this.resetCounter,
  }) : super(key: key);

  final resetCounter;
  
  @override
  Widget build(BuildContext context) {
    CustomTheme theme = Provider.of(context);
    var themeData = theme.themeData;

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Material(
                  color: themeData.dialogBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: resetCounter,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          'Reset Counter',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              )
            ],
          )
        ],
      ),
    );
  }
}