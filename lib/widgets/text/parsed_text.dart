import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'match_text.dart';


class ParsedText extends StatelessWidget {
  final TextStyle style;
  final List<MatchText> parse;
  final String text;
  final TextAlign alignment;
  final TextDirection textDirection;
  final bool softWrap;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int maxLines;
  final StrutStyle strutStyle;
  final TextWidthBasis textWidthBasis;
  final bool selectable;
  final GestureTapCallback onTap;

  ParsedText({
    Key key,
    @required this.text,
    this.parse = const <MatchText>[],
    this.style,
    this.alignment = TextAlign.start,
    this.textDirection,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.textScaleFactor = 1.0,
    this.strutStyle,
    this.textWidthBasis = TextWidthBasis.parent,
    this.maxLines,
    this.onTap,
    this.selectable = false,
  }) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    String newString = text;

    parse.forEach((e) { 
      RegExp regExp = RegExp(e.pattern);
      newString = newString.splitMapJoin(regExp,
          onMatch: (m) => "%%%%${m.group(0)}%%%%", onNonMatch: (m) => "$m");
    });

    List<String> splits = newString.split("%%%%");

    List<TextSpan> widgets = splits.map<TextSpan>((element) {
      TextSpan widget = TextSpan(text: "$element");

      for (final e in parse) {
        if (e.type == ParsedType.CUSTOM) {
          RegExp customRegExp = RegExp(e.pattern);

          bool matched = customRegExp.hasMatch(element);

          if (matched) {
            if (e.renderText != null) {
              Map<String, String> result = e.renderText(str: element, pattern: e.pattern);
              widget = TextSpan(
                style: e.style != null ? e.style : style,
                text: "${result['display']}",
                recognizer: TapGestureRecognizer()
                    ..onTap = () => e.onTap(result['display'], result['value'])
              );
            } else {
              widget = TextSpan(
                style: e.style != null ? e.style : style,
                text: "$element",
                recognizer: TapGestureRecognizer()
                    ..onTap = () => e.onTap(element)
              );
            }
            break;
          }
        }
      }

      return widget;
    }).toList();

    if (selectable) {
      return SelectableText.rich(
        TextSpan(
          children: <TextSpan>[...widgets],
          style: style
        ),
        maxLines: maxLines,
        strutStyle: strutStyle,
        textWidthBasis: textWidthBasis,
        textAlign: alignment,
        textDirection: textDirection,
        onTap: onTap,
      );
    }

    return RichText(
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis,
      textAlign: alignment,
      textDirection: textDirection,
      text: TextSpan(
        children: <TextSpan>[...widgets],
        style: style
      ),
    );
  }
}