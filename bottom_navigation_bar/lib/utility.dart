import 'package:flutter/material.dart';

const primaryRed = const Color(0xFFCD2B2B);


TextStyle appBoldFont(Color fontColor, double fontSize) => TextStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.w900,
    color: fontColor);

TextStyle appRegularFont(Color fontColor, double fontSize) => TextStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.w500,
    color: fontColor);
