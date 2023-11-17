import 'package:flutter/services.dart';

class IntegerInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final integerRegex = RegExp(r'^-?\d*$');
    if (integerRegex.hasMatch(newValue.text)) {
      return newValue;
    }

    return oldValue;
  }
}
