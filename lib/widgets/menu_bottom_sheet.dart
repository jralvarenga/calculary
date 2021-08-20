import 'package:calculary/services/custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MenuBottomSheet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    CustomTheme theme = Provider.of(context);
    var themeData = theme.themeData;

    void goToPage(String link) {
      Navigator.of(context).pop();
      Navigator.pushNamed(context, link);
    }

    return Container(
      padding: EdgeInsets.only(top: 10, right: 25, left: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: themeData.backgroundColor
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 8,
            decoration: BoxDecoration(
              color: themeData.dialogBackgroundColor,
              borderRadius: BorderRadius.circular(20)
            ),
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MenuBottomSheetItem(
                itemName: 'Calculator',
                itemFunction: () => goToPage('/'),
                icon: 'assets/calculator.svg',
              ),
              MenuBottomSheetItem(
                itemName: 'Counter',
                itemFunction: () => goToPage('/counter'),
                icon: 'assets/counter.svg',
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MenuBottomSheetItem(
                itemName: 'Function',
                itemFunction: () => goToPage('/function'),
                icon: 'assets/function.svg',
                requiresInternet: true,
              ),
              /*MenuBottomSheetItem(
                itemName: 'Settings',
                itemFunction: () => print('hi'),
                icon: 'assets/settings.svg',
              ),*/
            ],
          )
        ],
      ),
    );
  }
}

class MenuBottomSheetItem extends StatelessWidget {
  MenuBottomSheetItem({
    Key? key,
    required this.itemName,
    required this.itemFunction,
    required this.icon,
    this.requiresInternet = false
  }) : super(key: key);

  final String itemName;
  final itemFunction;
  final String icon;
  final bool requiresInternet;
  
  @override
  Widget build(BuildContext context) {
    CustomTheme theme = Provider.of(context);
    var themeData = theme.themeData;

    return Material(
      color: themeData.dialogBackgroundColor,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: itemFunction,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.40,
          padding: EdgeInsets.all(18),
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    itemName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  if (requiresInternet)
                    Icon(Icons.wifi)
                ],
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    icon,
                    width: 45,
                    height: 45,
                  ),
                )
              )
            ],
          ),
        )
      ),
    );
  }
}