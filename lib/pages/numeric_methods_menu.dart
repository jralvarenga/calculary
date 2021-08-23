import 'package:calculary/pages/numeric_methods.dart';
import 'package:calculary/services/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NumericMethodsMenu extends StatefulWidget {
  const NumericMethodsMenu({
    Key? key
  }) : super(key: key);

  @override
  _NumericMethodsMenuState createState() => _NumericMethodsMenuState();
}

class _NumericMethodsMenuState extends State<NumericMethodsMenu> {
  @override
  Widget build(BuildContext context) {
    CustomTheme theme = Provider.of(context);
    var themeData = theme.themeData;

    void goToMethod(String link) {
      switch (link) {
        case 'newton-rhapson':
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => NumericMethods(
              methodName: 'Newton-Rhapson',
              methodURI: 'https://mathapi.vercel.app/api/methods/function-root/newton-rhapson/',
            )
          ));
        break;
        case 'bisection':
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => NumericMethods(
              methodName: 'Bisection',
              methodURI: 'https://mathapi.vercel.app/api/methods/function-root/bisection/',
            )
          ));
        break;
        case 'fixed-point':
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => NumericMethods(
              methodName: 'Fixed point',
              methodURI: 'https://mathapi.vercel.app/api/methods/function-root/fixed-point/',
              
            )
          ));
        break;
        case 'simpson':
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => NumericMethods(
              methodName: "Simpson's rule",
              methodURI: 'https://mathapi.vercel.app/api/methods/integral/simpson/',
            )
          ));
        break;
        case 'trapz':
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => NumericMethods(
              methodName: "Trapz rule",
              methodURI: 'https://mathapi.vercel.app/api/methods/integral/trapz/',
            )
          ));
        break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: theme.textColor
        ),
        title: Text(
          'Numeric methods',
          style: TextStyle(
            color: theme.textColor,
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: themeData.dialogBackgroundColor,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      SizedBox(width: 0),
                      Text(
                        'Function root',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),
                Material(
                  child: InkWell(
                    onTap: () => goToMethod('newton-rhapson'),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          SizedBox(width: 50),
                          Text(
                            'Newton-Rhapson method',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                    )
                  ),
                ),
                Material(
                  child: InkWell(
                    onTap: () => goToMethod('bisection'),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          SizedBox(width: 50),
                          Text(
                            'Bisection  method',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                    )
                  ),
                ),
                Material(
                  child: InkWell(
                    onTap: () => goToMethod('fixed-point'),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          SizedBox(width: 50),
                          Text(
                            'Fixed point',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                    )
                  ),
                ),

                // Integral mehtods
                Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      SizedBox(width: 0),
                      Text(
                        'Integral',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),
                Material(
                  child: InkWell(
                    onTap: () => goToMethod('simpson'),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          SizedBox(width: 50),
                          Text(
                            "Simpson's rule",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                    )
                  ),
                ),
                Material(
                  child: InkWell(
                    onTap: () => goToMethod('trapz'),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          SizedBox(width: 50),
                          Text(
                            'Trapezoidal rule',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                    )
                  ),
                ),
              ],
            ),
          )
        ),
      )
    );
  }
}