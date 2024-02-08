import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';

class MainText extends StatelessWidget {
  final String text;
  final double textSize;
  final double strokeWidth;
  const MainText(
      {super.key,
      required this.text,
      required this.textSize,
      required this.strokeWidth});

  @override
  Widget build(BuildContext context) {
    return StrokeText(
      text: text,
      textStyle: TextStyle(
        color: Color.fromRGBO(202, 34, 44, 1),
        fontWeight: FontWeight.w900,
        fontSize: textSize,
        fontFamily: 'Roboto',
        fontStyle: FontStyle.italic,
      ),
      strokeColor: Color.fromRGBO(196, 199, 134, 1),
      strokeWidth: strokeWidth,
    );
  }
}
