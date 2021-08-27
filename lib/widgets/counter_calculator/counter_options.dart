import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
                          AppLocalizations.of(context)!.reset_counter,
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