import 'package:flutter/material.dart';

enum ParsedType { EMAIL, PHONE, URL, CUSTOM }

class MatchText {
  ParsedType type;
  String pattern;
  TextStyle style;
  Function onTap;
  Function({String str, String pattern}) renderText;

  MatchText({
    this.type = ParsedType.CUSTOM,
    this.pattern,
    this.style,
    this.onTap,
    this.renderText,
  });
}