import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class TipDialog extends StatelessWidget {
  const TipDialog({
    Key? key,
    required this.tipInputController,
    required this.changeTipValue
  }) : super(key: key);

  final TextEditingController tipInputController;
  final changeTipValue;

  @override
  Widget build(BuildContext context) {

    void closeKeyboard() {
      FocusScopeNode currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    return GestureDetector(
      onTap: closeKeyboard,
      child: AlertDialog(
        title: Text(
          AppLocalizations.of(context)!.tip_value,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold
          )
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        content: Container(
          height: 100,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  child: TextField(
                    onChanged: (String text) => changeTipValue(text),
                    controller: tipInputController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                  ),
                ),
                Text('%')
              ],
            ),
          )
        ),
      ),
    );
  }
}