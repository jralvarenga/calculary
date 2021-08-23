import 'package:calculary/services/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NMTopBar extends StatefulWidget {
  NMTopBar({
    Key? key,
    required this.mode,
  }) : super(key: key);

  final String mode;

  @override
  _NMTopBarState createState() => _NMTopBarState();
}

class _NMTopBarState extends State<NMTopBar> {

  @override
  Widget build(BuildContext context) {
    CustomTheme theme = Provider.of(context);
    var themeData = theme.themeData;

    void returnToMenu() {
      Navigator.pop(context);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Material(
          borderRadius: BorderRadius.circular(100),
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: returnToMenu,
            child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(
                  Icons.arrow_back,
                  size: 25,
                ),
              )
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 7, bottom: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: themeData.dialogBackgroundColor,
          ),
          child: Text(
            widget.mode,
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
        )
      ],
    );
  }
}