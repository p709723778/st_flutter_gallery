import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

const String dateTimeFormat = "yy-MM-dd HH:mm:ss";

/// 证件有效期
const String dateTimeFormatCer = "yyyy-MM-dd";

const int daySinceEpoch = 24 * 60 * 60 * 1000;

class DateTimePickerUtil {
  static const String MIN_DATETIME = '2020-01-01 00:00:00';
  static const String MAX_DATETIME = '2050-01-01 00:00:00';

  /// Display time picker.
  static void showDateTimePicker(
    BuildContext? context, {
    String? dateFormat,
    Function()? onCancel,
    Function()? onClose,
    Function(DateTime dateTime, List<int> selectedIndex)? onChange,
    Function(DateTime dateTime, List<int> selectedIndex)? onConfirm,
  }) {
    final dateTime = DateTime.now();

    const locale = DateTimePickerLocale.zh_cn;

    DatePicker.showDatePicker(
      context ?? Get.context!,
      minDateTime: DateTime.parse(MIN_DATETIME),
      maxDateTime: DateTime.parse(MAX_DATETIME),
      initialDateTime: dateTime,
      dateFormat: dateFormat ?? dateTimeFormat,
      locale: locale,
      pickerMode: DateTimePickerMode.datetime, // show TimePicker
      onCancel: onCancel,
      onClose: onClose,
      onChange: onChange,
      onConfirm: onConfirm,
    );
  }

  static String convertDateFormat(String input) {
    final inputFormat = DateFormat('yy年MM月dd日HH时mm分ss秒');
    final outputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

    final dateTime = inputFormat.parse(input);
    final result = outputFormat.format(dateTime);

    return result;
  }
}
