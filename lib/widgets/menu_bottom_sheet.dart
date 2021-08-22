import 'package:calculary/services/custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MenuBottomSheet extends StatelessWidget {
  MenuBottomSheet({
    Key? key,
    required this.mathAPIAvaliable
  }) : super(key: key);
  
  final bool mathAPIAvaliable;

  @override
  Widget build(BuildContext context) {
    CustomTheme theme = Provider.of(context);
    var themeData = theme.themeData;

    void goToPage(String link) {
      Navigator.of(context).pop();
      switch (link) {
        case '/':
          Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);  
        break;
        case '/function':
        case '/numeric-methods-menu':
          if (!mathAPIAvaliable) {
            final snackBar = SnackBar(
              content: Text('MathAPI server not connected')
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);            
          } else {
            Navigator.pushNamed(context, link);
          }
        break;
        default:
          Navigator.pushNamed(context, link);
        break;
      }
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                        mathAPIAvaliable: mathAPIAvaliable,
                      ),
                      MenuBottomSheetItem(
                        itemName: 'N. methods',
                        itemFunction: () => goToPage('/numeric-methods-menu'),
                        icon: 'assets/numeric_methods.svg',
                        requiresInternet: true,
                        mathAPIAvaliable: mathAPIAvaliable,
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MenuBottomSheetItem(
                        itemName: 'Settings',
                        itemFunction: () => goToPage('/settings'),
                        icon: 'assets/settings.svg',
                      ),
                    ],
                  )
                ],
              ),
            )
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
    this.requiresInternet = false,
    this.mathAPIAvaliable = true
  }) : super(key: key);

  final String itemName;
  final itemFunction;
  final String icon;
  final bool requiresInternet;
  final bool mathAPIAvaliable;
  
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
          width: MediaQuery.of(context).size.width * 0.42,
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
                      fontWeight: FontWeight.bold,
                      color: mathAPIAvaliable ? theme.textColor : theme.paperTextColor
                    ),
                  ),
                  if (requiresInternet)
                    Icon(
                      mathAPIAvaliable ? Icons.signal_wifi_4_bar_outlined : Icons.signal_wifi_connected_no_internet_4_outlined,
                      size: 20,
                      color: mathAPIAvaliable ? theme.textColor : theme.paperTextColor
                    )
                ],
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    icon,
                    width: 45,
                    height: 45,
                    color: mathAPIAvaliable ? theme.textColor : theme.paperTextColor
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