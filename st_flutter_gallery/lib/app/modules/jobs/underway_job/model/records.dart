import 'package:st/app/modules/jobs/start_job_page/model/shift_model.dart';
import 'package:st/app/modules/jobs/underway_job/model/newest_model.dart';

class Records {
  Records({
    this.id,
    this.drillTaskId,
    this.shift,
    this.newest,
    this.repairRecord,
    this.workFace,
    this.drillSite,
    this.drillNumber,
    this.holeDepth,
    this.startTime,
    this.endTime,
  });

  Records.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    drillTaskId = json['drillTaskId'];
    shift = json['shift'] != null ? ShiftModel.fromJson(json['shift']) : null;
    newest =
        json['newest'] != null ? NewestModel.fromJson(json['newest']) : null;
    repairRecord = json['repairRecord'];
    workFace = json['workFace'];
    drillSite = json['drillSite'];
    drillNumber = json['drillNumber'];
    holeDepth = json['holeDepth'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }
  String? id;
  String? drillTaskId;
  ShiftModel? shift;
  NewestModel? newest;

  bool? repairRecord;
  String? workFace;
  String? drillSite;
  String? drillNumber;
  double? holeDepth;
  int? startTime;
  int? endTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['drillTaskId'] = drillTaskId;
    if (shift != null) {
      map['shift'] = shift?.toJson();
    }
    if (newest != null) {
      map['newest'] = newest?.toJson();
    }
    map['repairRecord'] = repairRecord;
    map['workFace'] = workFace;
    map['drillSite'] = drillSite;
    map['drillNumber'] = drillNumber;
    map['holeDepth'] = holeDepth;
    map['startTime'] = startTime;
    map['endTime'] = endTime;
    return map;
  }
}
