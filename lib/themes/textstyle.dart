import 'package:flutter/material.dart';

class NanumTitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final TextAlign textAlign;
  final Color color;
  final FontWeight fontWeight;
  final int maxLine;
  const NanumTitleText({
    Key? key,
    required this.text,
    this.fontSize = 17,
    this.textAlign = TextAlign.center,
    this.color = Colors.black,
    this.fontWeight = FontWeight.normal,
    this.maxLine = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontFamily: 'NanumSquareEB',
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}

class NanumBodyText extends StatelessWidget {
  final String text;
  final double fontSize;
  final TextAlign textAlign;
  final Color color;
  final FontWeight fontWeight;
  const NanumBodyText({
    Key? key,
    required this.text,
    this.fontSize = 14,
    this.textAlign = TextAlign.center,
    this.color = Colors.black,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontFamily: 'NanumSquare_acB',
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      //textAlign: textAlign,
    );
  }
}

class NanumText extends StatelessWidget {
  final String text;
  final double fontSize;
  final TextAlign textAlign;
  final Color color;
  final FontWeight fontWeight;
  const NanumText({
    Key? key,
    required this.text,
    this.fontSize = 12,
    this.textAlign = TextAlign.center,
    this.color = Colors.grey,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontFamily: 'NanumSquareB',
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
      //textAlign: textAlign,
    );
  }
}
