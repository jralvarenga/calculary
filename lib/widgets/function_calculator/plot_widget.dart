import 'package:calculary/services/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlotWidget extends StatelessWidget {
  const PlotWidget({
    Key? key,
    required this.x,
    required this.y
  }) : super(key: key);

  final List<dynamic> x;
  final List<dynamic> y;

  @override
  Widget build(BuildContext context) {
    CustomTheme theme = Provider.of(context);
    var themeData = theme.themeData;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.dialogBackgroundColor,
        centerTitle: true,
        title: Text(
          'Function plot',
        )
      ),
      body: Center(
        child: Container(
          child: CustomPaint(
            size: Size(
              MediaQuery.of(context).size.width * 0.9,
              MediaQuery.of(context).size.height * 0.7,
            ),
            painter: FunctionPainter(
              x: x,
              y: y,
              theme: theme,
              widthSize: MediaQuery.of(context).size.width * 0.9,
              heightSize: MediaQuery.of(context).size.height * 0.7
            ),
          ),
        ),
      )
    );
  }
}

class FunctionPainter extends CustomPainter {
  const FunctionPainter({
    Key? key,
    required this.x,
    required this.y,
    required this.theme,
    required this.heightSize,
    required this.widthSize
  });

  final List<dynamic> x;
  final List<dynamic> y;
  final CustomTheme theme;
  final double widthSize;
  final double heightSize;

  @override
  void paint(Canvas canvas, Size size) {
    final midY = size.height/2;
    final midX = size.width/2;
    final axisPaint = Paint()..style = PaintingStyle.fill
      ..color = theme.paperTextColor
      ..strokeWidth = 0.5;
    final functionPaint = Paint()..style = PaintingStyle.fill
      ..color = theme.textColor
      ..strokeWidth = 2;

    canvas.drawLine(Offset(0, midY), Offset(size.width, midY), axisPaint);
    canvas.drawLine(Offset(midX, 0), Offset(midX, size.height), axisPaint);

    var pt = Offset(midX + x[0]*10, midY - y[0]*10);
    for(int i = 0; i < widthSize; i++){
      double xValue = x[i];
      double yValue = y[i];
      final npt = Offset(midX + xValue*10, midY - yValue*10);
      canvas.drawLine(pt, npt, functionPaint);
      pt = npt;
    }
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}