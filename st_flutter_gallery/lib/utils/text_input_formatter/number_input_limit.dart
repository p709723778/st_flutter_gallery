import 'package:flutter/services.dart';

class NumberInputLimit extends TextInputFormatter {
  NumberInputLimit({
    this.inputScope = '-.0123456789',
    this.digit,
    this.max,
    this.isNegative = false,
    this.isInputZero = true,
  });

  ///输入字符的范围
  String inputScope;

  ///允许的小数位数
  final int? digit;

  ///允许的最大值
  final double? max;

  ///是否支持 false不支持负数(默认不支持)
  final bool isNegative;

  /// 是否支持输入0
  final bool isInputZero;

  ///获取value小数点后有几位
  static int getDecimalAfterLength(String value) {
    if (value.contains(".")) {
      return value.split(".")[1].length;
    } else {
      return 0;
    }
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    //上次文本
    final oldContent = oldValue.text;
    //最新文本
    var newContent = newValue.text;
    //上次文本长度
    final oldLength = oldContent.length;
    //最新文本长度
    final newLength = newContent.length;
    //上次文本光标位置
    final oldBaseOffset = oldValue.selection.baseOffset;
    //最新文本光标位置
    final newBaseOffset = newValue.selection.baseOffset;
    //光标位置
    var offset = newBaseOffset;

    if (newLength > oldLength) {
      //输入的字符
      final inputContent = newContent.substring(oldBaseOffset, newBaseOffset);
      if (!isNegative) {
        inputScope = inputScope.replaceAll("-", "");
      }
      if (newLength == 1 && !isInputZero && inputContent == '0') {
        newContent = oldContent;
        offset = oldBaseOffset;
      } else if (newLength == 1 && inputContent == '.') {
        newContent = oldContent;
        offset = oldBaseOffset;
      } else if (inputContent == '.' && oldContent.contains('.')) {
        newContent = oldContent;
        offset = oldBaseOffset;
      } else if (inputScope.contains(inputContent)) {
        if (oldLength > 0) {
          if ((max != null && double.parse(newContent) > max!) ||
              (digit != null && getDecimalAfterLength(newContent) > digit!)) {
            newContent = oldContent;
            offset = oldBaseOffset;
          } else if (inputContent == '-') {
            newContent = oldContent;
            offset = oldBaseOffset;
          } else if (oldContent.substring(0, 1) == "-") {
            //上次文本首字符是-
            if ((oldContent.contains(".") && inputContent == ".") ||
                inputContent == "-" ||
                (oldContent.contains(".") &&
                    newLength > 2 &&
                    newContent.substring(2, 3) != "." &&
                    newContent.substring(1, 2) == "0") ||
                (newLength > 2 && newContent.substring(0, 3) == "-00") ||
                (newLength > 2 &&
                    !newContent.contains(".") &&
                    newContent.substring(1, 2) == "0") ||
                (oldContent.substring(0, 1) == "-" &&
                    newContent.substring(0, 1) != "-")) {
              newContent = oldContent;
              offset = oldBaseOffset;
            }
          } else if (oldContent.substring(0, 1) == "0") {
            //上次文本首字符是0
            if (newLength > 1 && newContent.substring(0, 2) == "00" ||
                (newContent.contains("-") &&
                    newContent.substring(0, 1) != "-") ||
                (oldContent.contains(".") && inputContent == ".") ||
                (newContent.substring(0, 1) == "0" &&
                    newLength > 1 &&
                    newContent.substring(1, 2) != ".")) {
              newContent = oldContent;
              offset = oldBaseOffset;
            }
          } else if (newContent.contains(".")) {
            //上次文本首字符是.
            if ((oldLength > 1 &&
                    oldContent.substring(0, 2) == "0." &&
                    inputContent == ".") ||
                (newContent.substring(0, 1) != "-" &&
                    newContent.contains("-")) ||
                (oldContent.contains(".") && inputContent == ".") ||
                (oldContent.contains(".") &&
                    oldContent.substring(0, 1) != "." &&
                    newContent.substring(0, 1) == "0")) {
              newContent = oldContent;
              offset = oldBaseOffset;
            }
          }
        }
      } else {
        //输入限制范围外字符
        newContent = oldContent;
        offset = oldBaseOffset;
      }
    }

    return TextEditingValue(
      text: newContent,
      selection: TextSelection.collapsed(offset: offset),
    );
  }
}
