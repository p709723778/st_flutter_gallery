import 'package:intl/intl.dart';
import 'package:st/app/modules/jobs/job_details/model/job_detail_model.dart';
import 'package:st/app/modules/jobs/start_job_page/model/write_job_info_model.dart';
import 'package:st/utils/date_time/date_time_picker_util.dart';

class JobReplenishmentModel {
  JobReplenishmentModel({
    this.captain,
    this.createTime,
    this.createUserId,
    this.createUserName,
    this.drillPipeLength,
    this.dutyFootage,
    this.boreholeDiameter,
    this.reamingDiameter,
    this.reamingDepth,
    this.sealingLength,
    this.endTime,
    this.id,
    this.jobInstruct,
    this.remarks,
    this.startTime,
    this.taskAccountId,
    this.updateTime,
    this.updateUserId,
    this.updateUserName,
    this.version,
  });

  JobReplenishmentModel.fromJson(Map<String, dynamic> json) {
    captain = json['captain'];
    createTime = json['createTime'];
    createUserId = json['createUserId'];
    createUserName = json['createUserName'];
    drillPipeLength = json['drillPipeLength'];
    dutyFootage = json['dutyFootage'];
    boreholeDiameter = json['boreholeDiameter'];
    reamingDiameter = json['reamingDiameter'];
    reamingDepth = json['reamingDepth'];
    sealingLength = json['sealingLength'];
    endTime = json['endTime'];
    id = json['id'];
    jobInstruct = json['jobInstruct'];
    remarks = json['remarks'];
    startTime = json['startTime'];
    taskAccountId = json['taskAccountId'];
    updateTime = json['updateTime'];
    updateUserId = json['updateUserId'];
    updateUserName = json['updateUserName'];
    version = json['version'];
  }

  String? captain;
  String? createTime;
  String? createUserId;
  String? createUserName;
  double? drillPipeLength;
  double? dutyFootage;
  double? boreholeDiameter;
  double? reamingDiameter;
  double? reamingDepth;
  double? sealingLength;
  String? endTime;
  DateTime endDateTime = DateTime.now();
  String? id;
  String? jobInstruct;
  String? remarks;
  String? startTime;
  DateTime startDateTime = DateTime.now();
  String? taskAccountId;
  String? updateTime;
  String? updateUserId;
  String? updateUserName;
  int? version;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['captain'] = captain ?? '';
    map['createTime'] = createTime ?? '';
    map['createUserId'] = createUserId ?? '';
    map['createUserName'] = createUserName ?? '';
    map['drillPipeLength'] = drillPipeLength ?? 0.0;
    map['dutyFootage'] = dutyFootage ?? 0;
    map['boreholeDiameter'] = boreholeDiameter ?? 0;
    map['reamingDiameter'] = reamingDiameter ?? 0;
    map['reamingDepth'] = reamingDepth ?? 0;
    map['sealingLength'] = sealingLength ?? 0;
    map['endTime'] = endDateTime.millisecondsSinceEpoch;
    // map['id'] = id;
    map['jobInstruct'] = jobInstruct ?? '';
    map['remarks'] = remarks ?? '';
    map['startTime'] = startDateTime.millisecondsSinceEpoch;
    map['taskAccountId'] = taskAccountId ?? '';
    map['updateTime'] = updateTime ?? '';
    map['updateUserId'] = updateUserId ?? '';
    map['updateUserName'] = updateUserName ?? '';
    map['version'] = version ?? '';
    return map;
  }

  void setJobDetailModelData(JobDetailModel model) {
    if (model.id?.isNotEmpty ?? false) {
      taskAccountId = model.id;
    }
    if (model.captain?.isNotEmpty ?? false) {
      captain = model.captain;
    }
  }

  void setDateTime(WriteJobInfoModel writeJobInfoModel) {
    startDateTime = writeJobInfoModel.constructDate!;
    endDateTime = writeJobInfoModel.constructDate!;
  }

  bool checkStartEndTime() {
    if (startDateTime.millisecondsSinceEpoch >=
        endDateTime.millisecondsSinceEpoch) {
      return false;
    }
    return true;
  }

  String startDateTimeString() {
    return DateFormat(dateTimeReplenishmentFormat).format(
      startDateTime,
    );
  }

  String endDateTimeString() {
    return DateFormat(dateTimeReplenishmentFormat).format(
      endDateTime,
    );
  }
}
