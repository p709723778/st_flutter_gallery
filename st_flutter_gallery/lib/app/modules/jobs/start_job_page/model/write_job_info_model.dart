import 'package:st/app/modules/jobs/jobs_enum.dart';
import 'package:st/app/modules/jobs/start_job_page/model/drill_info_model.dart';
import 'package:st/app/modules/jobs/start_job_page/model/monitor_on_model.dart';
import 'package:st/app/modules/jobs/start_job_page/model/monitor_position_model.dart';
import 'package:st/app/modules/jobs/start_job_page/model/shift_model.dart';
import 'package:st/app/modules/query_site/model/query_site_model.dart';
import 'package:st/app/modules/query_site_number/model/query_site_numver_model.dart';
import 'package:st/app/modules/query_work_face/model/work_face_model.dart';
import 'package:st/utils/date_time/date_time_util.dart';
// import 'package:intl/intl.dart';

class WriteJobInfoModel {
  WriteJobInfoModel({
    this.jobActionType = JobActionType.none,
    this.repairRecord = false,
    this.jobAzimuth,
    this.jobDip,
  });

  factory WriteJobInfoModel.fromJson(Map<String, dynamic> json) =>
      WriteJobInfoModel(
        jobActionType: json["jobActionType"],
      );

  /// 作业类型
  JobActionType jobActionType;
  WorkFaceModel? workFaceModel;
  QuerySiteModel? querySiteModel;
  QuerySiteNumberModel? querySiteNumberModel;
  DrillInfoModel? drillInfoModel;
  DateTime? constructDate = DateTimeUtil.dayConvertDateTime(DateTime.now());

  /// 作业时间
  String? constructDateString;

  /// 班次
  ShiftModel? shift;

  /// 施工机长
  String? captain;

  /// 班组成员
  String? crewMembers;

  /// 工作方位角
  int? jobAzimuth;

  /// 工作倾角
  int? jobDip;

  /// 监控是否开启
  MonitorOnModel? monitorOn;

  /// 监控位置确认
  MonitorPositionModel? monitorPosition;

  /// 是否补录
  bool repairRecord;

  /// 作业id
  String? id;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      "captain": captain,
      // "constructDate":
      //     DateFormat("yyyy-MM-dd'T'00:00:00.000'Z'").format(constructDate!),

      "constructDate":
          DateTimeUtil.dayConvertMillisecondsSinceEpoch(constructDate!),

      "createTime": drillInfoModel?.createTime,
      "createUserId": drillInfoModel?.createUserId,
      "createUserName": drillInfoModel?.createUserName,
      "crewMembers": crewMembers,
      "drillTaskId": drillInfoModel?.id,
      "id": id,
      "jobAzimuth": jobAzimuth,
      "jobDip": jobDip,
      "monitorOn": monitorOn?.code?.toString(),
      "monitorPosition": monitorPosition?.code?.toString(),
      // "newest": "1",
      // "ranksAccountId": "string",
      "repairRecord": repairRecord,
      "shift": shift?.code?.toString(),
      // "state": "1",
      "updateTime": drillInfoModel?.updateTime,
      "updateUserId": drillInfoModel?.updateUserId,
      "updateUserName": drillInfoModel?.updateUserName,
      "version": drillInfoModel?.version
    }..removeWhere((key, value) => value == null);

    return data;
  }
}
