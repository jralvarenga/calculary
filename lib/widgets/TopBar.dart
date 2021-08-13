import 'package:calculary/services/CustomTheme.dart';
import 'package:calculary/widgets/MenuBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopBar extends StatefulWidget {
  TopBar({
    Key? key,
    required this.mode,
    required this.rightButtonFunction,
  }) : super(key: key);

  final String mode;
  final rightButtonFunction;

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {

  @override
  Widget build(BuildContext context) {
    CustomTheme theme = Provider.of(context);
    var themeData = theme.themeData;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30)
              )
            ),
            builder: (context) => buildSheet()
          ),
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

  Widget buildSheet() => MenuBottomSheet();
}