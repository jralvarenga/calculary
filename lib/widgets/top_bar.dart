import 'package:calculary/services/custom_theme.dart';
import 'package:calculary/widgets/menu_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class TopBar extends StatefulWidget {
  TopBar({
    Key? key,
    required this.mode,
    required this.rightButtonFunction,
    required this.mathAPIAvaliable
  }) : super(key: key);

  final String mode;
  final rightButtonFunction;
  final bool mathAPIAvaliable;

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {

  @override
  Widget build(BuildContext context) {
    CustomTheme theme = Provider.of(context);
    var themeData = theme.themeData;

    void showMenuBottomSheet() {
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => showMenuBottomSheet(),
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: themeData.dialogBackgroundColor,
            ),
            child: Icon(
              Icons.more_horiz,
              size: 30,
            ),
          )
        ),
        GestureDetector(
          onTap: widget.rightButtonFunction,
          child: Container(
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
        ),
      ],
    );
  }

  Widget buildSheet() => MenuBottomSheet(
    mathAPIAvaliable: widget.mathAPIAvaliable,
  );
}