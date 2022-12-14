import 'package:st/app/modules/jobs/job_details/model/job_command_model.dart';

class JobCommandDetailRecords {
  JobCommandDetailRecords({
    this.version,
    this.createUserId,
    this.updateUserId,
    this.createTime,
    this.updateTime,
    this.createUserName,
    this.updateUserName,
    this.id,
    this.taskAccountId,
    this.jobInstruct,
    this.drillPipeLength,
    this.dutyFootage,
    this.boreholeDiameter,
    this.reamingDiameter,
    this.reamingDepth,
    this.sealingLength,
    this.captain,
    this.startTime,
    this.endTime,
    this.remarks,
  });

  JobCommandDetailRecords.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    createUserId = json['createUserId'];
    updateUserId = json['updateUserId'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    createUserName = json['createUserName'];
    updateUserName = json['updateUserName'];
    id = json['id'];
    taskAccountId = json['taskAccountId'];
    jobInstruct = json['jobInstruct'] != null
        ? JobCommandModel.fromJson(json['jobInstruct'])
        : null;
    drillPipeLength = json['drillPipeLength'];
    dutyFootage = json['dutyFootage'];
    boreholeDiameter = json['boreholeDiameter'];
    reamingDiameter = json['reamingDiameter'];
    reamingDepth = json['reamingDepth'];
    sealingLength = json['sealingLength'];
    captain = json['captain'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    remarks = json['remarks'];
  }
  int? version;
  String? createUserId;
  String? updateUserId;
  int? createTime;
  int? updateTime;
  String? createUserName;
  String? updateUserName;
  String? id;
  String? taskAccountId;
  JobCommandModel? jobInstruct;
  double? drillPipeLength;
  double? dutyFootage;
  double? boreholeDiameter;
  double? reamingDiameter;
  double? reamingDepth;
  double? sealingLength;
  String? captain;
  int? startTime;
  int? endTime;
  String? remarks;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['version'] = version;
    map['createUserId'] = createUserId;
    map['updateUserId'] = updateUserId;
    map['createTime'] = createTime;
    map['updateTime'] = updateTime;
    map['createUserName'] = createUserName;
    map['updateUserName'] = updateUserName;
    map['id'] = id;
    map['taskAccountId'] = taskAccountId;
    if (jobInstruct != null) {
      map['jobInstruct'] = jobInstruct?.code;
    }
    map['drillPipeLength'] = drillPipeLength;
    map['dutyFootage'] = dutyFootage;
    map['boreholeDiameter'] = boreholeDiameter;
    map['reamingDiameter'] = reamingDiameter;
    map['reamingDepth'] = reamingDepth;
    map['sealingLength'] = sealingLength;
    map['captain'] = captain;
    map['startTime'] = startTime;
    map['endTime'] = endTime;
    map['remarks'] = remarks;
    return map;
  }
}
