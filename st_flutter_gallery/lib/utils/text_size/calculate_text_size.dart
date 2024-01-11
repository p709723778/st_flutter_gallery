import 'package:flutter/material.dart';

class CalculateTextSize {
  static Size boundingTextSize(
    BuildContext context,
    String text,
    TextStyle style, {
    int maxLines = 2 ^ 31,
    double maxWidth = double.infinity,
  }) {
    if (text.isEmpty) {
      return Size.zero;
    }
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      locale: Localizations.localeOf(context),
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
    )..layout(maxWidth: maxWidth);
    return textPainter.size;
  }
}
