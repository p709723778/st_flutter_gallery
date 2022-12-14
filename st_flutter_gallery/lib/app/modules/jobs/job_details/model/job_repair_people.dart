import 'package:intl/intl.dart';
import 'package:st/utils/date_time/date_time_picker_util.dart';

class JobRepairPeople {
  JobRepairPeople({
    this.people,
    this.time,
  });

  JobRepairPeople.fromJson(Map json) {
    people = json['people'];
    time = json['time'];
  }
  String? people;
  int? time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['people'] = people ?? '';
    map['time'] = time;
    return map;
  }

  String get getTimeString {
    if (time != null && (time ?? 0) > 0) {
      return DateFormat(dateTimeReplenishmentFormat).format(
        DateTime.fromMillisecondsSinceEpoch(
          time!,
        ),
      );
    }
    return '';
  }
}
