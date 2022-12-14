class DateTimeUtil {
  static int millisecond = 1000;
  static int second = 60;
  static int minute = 60;
  static int hours = 24;

  /// 将时间戳 精确到天的毫秒时间戳
  static int dayConvertMillisecondsSinceEpoch(DateTime dateTime) {
    final milliseconds = dateTime.millisecondsSinceEpoch ~/
        (hours * minute * second * millisecond);
    final dayMillisecondsSinceEpoch =
        milliseconds * (hours * minute * second * millisecond);
    return dayMillisecondsSinceEpoch;
  }

  static DateTime dayConvertDateTime(DateTime dateTime) {
    final milliseconds = dateTime.millisecondsSinceEpoch ~/
        (hours * minute * second * millisecond);

    final dayMillisecondsSinceEpoch =
        milliseconds * (hours * minute * second * millisecond);
    final t = DateTime.fromMillisecondsSinceEpoch(
      dayMillisecondsSinceEpoch,
      isUtc: true,
    );
    return t;
  }
}
