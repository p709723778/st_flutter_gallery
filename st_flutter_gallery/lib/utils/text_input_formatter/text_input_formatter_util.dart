import 'package:flutter/services.dart';
import 'package:st/utils/text_input_formatter/integer_input_formatter.dart';

class TextInputFormatterUtil {
  /// ip地址
  static final ipAddress = FilteringTextInputFormatter.allow(RegExp('[0-9.]'));

  /// 正负数整形(不包含小数点)
  static final numbers = IntegerInputFormatter();
}
