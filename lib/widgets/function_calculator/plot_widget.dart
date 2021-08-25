import 'dart:math' as math;
import 'package:flutter/material.dart';

class PlotWidget extends StatelessWidget {
  const PlotWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        child: CustomPaint(
          size: Size(100, 300),
          painter: FunctionPainter(),
        ),
      ),
    );
  }
}

class FunctionPainter extends CustomPainter {
  @override void paint(Canvas canvas, Size size){
    final midY = size.height/2;
    final midX = size.width/2;
    final paint = Paint()..style = PaintingStyle.fill

    ..color = Colors.black;

    canvas.drawLine(Offset(0, midY), Offset(size.width,midY), paint);
    canvas.drawLine(Offset(midX, 0), Offset(midX, size.height), paint);

    var pt = Offset(0,midY);
    for(double i = 0; i < 100; i += 0.5){
      final npt = Offset(i, midY - 30);
      canvas.drawLine(pt, npt, paint);
      pt = npt;
    }
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}