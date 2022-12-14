import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:get/get.dart';

const String dateTimeFormat = 'yyyy-M月-d日  H时:m分:s';
const String dateTimeDayFormat = "yyyy-M月-d日";

const String dateTimeServerFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";

const String dateTimeReplenishmentFormat = "yyyy-MM-dd HH:mm:ss";

const int daySinceEpoch = 24 * 60 * 60 * 1000;

class DateTimePickerUtil {
  static const String MIN_DATETIME = '2020-01-01 00:00:00';
  static const String MAX_DATETIME = '2050-01-01 00:00:00';

  /// Display time picker.
  static void showDateTimePicker(
    BuildContext? context, {
    String? dateFormat,
    DateTime? initialDateTime,
    DateTime? minDateTime,
    DateTime? maxDateTime,
    Function()? onCancel,
    Function()? onClose,
    Function(DateTime dateTime, List<int> selectedIndex)? onChange,
    Function(DateTime dateTime, List<int> selectedIndex)? onConfirm,
  }) {
    final dateTime = DateTime.now();

    const locale = DateTimePickerLocale.zh_cn;

    DatePicker.showDatePicker(
      context ?? Get.context!,
      minDateTime: minDateTime ?? DateTime(dateTime.year - 2),
      maxDateTime: maxDateTime ?? DateTime.parse(MAX_DATETIME),
      initialDateTime: initialDateTime ?? dateTime,
      dateFormat: dateFormat ?? dateTimeFormat,
      locale: locale,
      pickerMode: DateTimePickerMode.datetime, // show TimePicker
      onCancel: onCancel,
      onClose: onClose,
      onChange: onChange,
      onConfirm: onConfirm,
    );
  }
}
