import 'package:custom_qr_generator/custom_qr_generator.dart';
import 'package:flutter/material.dart';

class QRgenerator extends StatelessWidget {
  const QRgenerator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: QrPainter(
          data: "Welcome to Flutter",
          options: const QrOptions(
              shapes: QrShapes(
                  darkPixel: QrPixelShapeRoundCorners(cornerFraction: .5),
                  frame: QrFrameShapeRoundCorners(cornerFraction: .25),
                  ball: QrBallShapeRoundCorners(cornerFraction: .25)),
              colors: QrColors(
                  dark: QrColorLinearGradient(colors: [
                Color.fromARGB(255, 255, 0, 0),
                Color.fromARGB(255, 0, 0, 255),
              ], orientation: GradientOrientation.leftDiagonal)))),
      size: const Size(350, 350),
    );
  }
}
