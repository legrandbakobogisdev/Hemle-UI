// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  String label;
  String? fontFamily;
  double? fontSize;
  Color? color;
  FontWeight? fontWeight;
  TextAlign? textAlign;
  TextOverflow? overflow;
  int? maxLines;
  double? letterSpacing;
  double? height;
  TextDecoration? decoration;
  TextDecorationStyle? decorationStyle;
  Color? decorationColor;
  double? decorationThickness;
  TextStyle? style;
  FontStyle? fontstyle;

  CustomText({
    super.key,
    required this.label,
    this.fontFamily = "Inter",
    this.fontSize,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.letterSpacing,
    this.height,
    this.decoration,
    this.decorationStyle,
    this.decorationColor,
    this.decorationThickness,
    this.style,
    this.fontstyle
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        fontStyle: fontstyle,
        fontFamily: fontFamily,
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: height,
        decoration: decoration,
        decorationStyle: decorationStyle,
        decorationColor: decorationColor,
        decorationThickness: decorationThickness,
      ),
    );
  }
}
