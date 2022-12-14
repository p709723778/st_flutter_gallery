import 'package:st/app/modules/jobs/start_job_page/model/monitor_on_model.dart';
import 'package:st/app/modules/jobs/start_job_page/model/monitor_position_model.dart';
import 'package:st/app/modules/jobs/start_job_page/model/shift_model.dart';
import 'package:st/app/modules/jobs/start_job_page/model/write_job_info_model.dart';

class JobDetailModel {
  JobDetailModel({
    this.workFace,
    this.drillSite,
    this.drillNumber,
    this.drillGap,
    this.baseline,
    this.miningLine,
    this.holeHeight,
    this.designLine,
    this.azimuth,
    this.holeDepth,
    this.dip,
    this.openHoleDepth,
    this.id,
    this.constructDate,
    this.shift,
    this.captain,
    this.crewMembers,
    this.jobAzimuth,
    this.jobDip,
    this.monitorOn,
    this.monitorPosition,
  });

  JobDetailModel.fromJson(Map<String, dynamic> json) {
    workFace = json['workFace'];
    drillSite = json['drillSite'];
    drillNumber = json['drillNumber'];
    drillGap = json['drillGap'];
    baseline = json['baseline'];
    miningLine = json['miningLine'];
    holeHeight = json['holeHeight'];
    designLine = json['designLine'];
    azimuth = json['azimuth'];
    holeDepth = json['holeDepth'];
    dip = json['dip'];
    openHoleDepth = json['openHoleDepth'];
    id = json['id'];
    constructDate = json['constructDate'];
    shift = json['shift'] != null ? ShiftModel.fromJson(json['shift']) : null;
    captain = json['captain'];
    crewMembers = json['crewMembers'];
    jobAzimuth = json['jobAzimuth'];
    jobDip = json['jobDip'];
    monitorOn = json['monitorOn'] != null
        ? MonitorOnModel.fromJson(json['monitorOn'])
        : null;
    monitorPosition = json['monitorPosition'] != null
        ? MonitorPositionModel.fromJson(json['monitorPosition'])
        : null;
  }
  String? workFace;
  String? drillSite;
  String? drillNumber;
  int? drillGap;
  int? baseline;
  int? miningLine;
  double? holeHeight;
  double? designLine;
  int? azimuth;
  double? holeDepth;
  int? dip;
  double? openHoleDepth;
  String? id;
  int? constructDate;
  ShiftModel? shift;
  String? captain;
  String? crewMembers;
  int? jobAzimuth;
  int? jobDip;
  MonitorOnModel? monitorOn;
  MonitorPositionModel? monitorPosition;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['workFace'] = workFace;
    map['drillSite'] = drillSite;
    map['drillNumber'] = drillNumber;
    map['drillGap'] = drillGap;
    map['baseline'] = baseline;
    map['miningLine'] = miningLine;
    map['holeHeight'] = holeHeight;
    map['designLine'] = designLine;
    map['azimuth'] = azimuth;
    map['holeDepth'] = holeDepth;
    map['dip'] = dip;
    map['openHoleDepth'] = openHoleDepth;
    map['id'] = id;
    map['constructDate'] = constructDate;
    if (shift != null) {
      map['shift'] = shift?.toJson();
    }
    map['captain'] = captain;
    map['crewMembers'] = crewMembers;
    map['jobAzimuth'] = jobAzimuth;
    map['jobDip'] = jobDip;
    if (monitorOn != null) {
      map['monitorOn'] = monitorOn?.toJson();
    }
    if (monitorPosition != null) {
      map['monitorPosition'] = monitorPosition?.toJson();
    }
    return map;
  }

  void convertToDetail(WriteJobInfoModel writeJobInfoModel) {
    workFace = writeJobInfoModel.workFaceModel?.value ?? '';
    drillSite = writeJobInfoModel.querySiteModel?.value ?? '';
    drillNumber = writeJobInfoModel.querySiteNumberModel?.value ?? '';
    drillGap = writeJobInfoModel.drillInfoModel?.drillGap ?? 0;
    baseline = writeJobInfoModel.drillInfoModel?.baseline ?? 0;
    miningLine = writeJobInfoModel.drillInfoModel?.miningLine ?? 0;
    holeHeight = writeJobInfoModel.drillInfoModel?.holeHeight ?? 0;
    designLine = writeJobInfoModel.drillInfoModel?.designLine ?? 0;
    azimuth = writeJobInfoModel.drillInfoModel?.azimuth ?? 0;
    holeDepth = writeJobInfoModel.drillInfoModel?.holeDepth ?? 0;
    dip = writeJobInfoModel.drillInfoModel?.dip ?? 0;
    openHoleDepth = writeJobInfoModel.drillInfoModel?.openHoleDepth ?? 0;
    id = writeJobInfoModel.id;
    constructDate = writeJobInfoModel.constructDate?.millisecondsSinceEpoch;
    shift = writeJobInfoModel.shift;
    captain = writeJobInfoModel.captain;
    crewMembers = writeJobInfoModel.crewMembers;
    jobAzimuth = writeJobInfoModel.jobAzimuth;
    jobDip = writeJobInfoModel.jobDip;
    monitorOn = writeJobInfoModel.monitorOn;
    monitorPosition = writeJobInfoModel.monitorPosition;
  }
}
