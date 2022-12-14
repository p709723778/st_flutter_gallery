import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/modules/jobs/job_details/model/job_detail_push_parameters.dart';
import 'package:st/app/modules/jobs/jobs_enum.dart';
import 'package:st/app/modules/jobs/start_job_page/model/drill_info_model.dart';
import 'package:st/app/modules/jobs/start_job_page/model/monitor_on_model.dart';
import 'package:st/app/modules/jobs/start_job_page/model/monitor_position_model.dart';
import 'package:st/app/modules/jobs/start_job_page/model/shift_model.dart';
import 'package:st/app/modules/jobs/start_job_page/model/write_job_info_model.dart';
import 'package:st/app/modules/jobs/underway_job/model/records.dart';
import 'package:st/app/modules/views/text_field_edit_page.dart';
import 'package:st/app/network_request/apis/apis.dart';
import 'package:st/app/network_request/http.dart';
import 'package:st/app/routes/app_pages.dart';
import 'package:st/helpers/logger/logger_helper.dart';
import 'package:st/utils/date_time/date_time_util.dart';

class StartJobPageController extends GetxController {
  WriteJobInfoModel writeJobInfoModel = WriteJobInfoModel();

  @override
  void onInit() {
    final JobActionType type = Get.arguments;
    writeJobInfoModel.jobActionType = type;
    if (writeJobInfoModel.jobActionType == JobActionType.replenishment) {
      writeJobInfoModel.repairRecord = true;
    }

    final dateString =
        DateFormat("yyyy-MM-dd").format(writeJobInfoModel.constructDate!);
    writeJobInfoModel.constructDateString = dateString;

    super.onInit();
  }

  @override
  void onClose() {}

  Future<bool> save() async {
    if (!checkInput()) return false;

    if (writeJobInfoModel.jobActionType == JobActionType.replenishment) {
      return true;
    }
    try {
      await EasyLoading.show(
        status: '正在加载...',
        maskType: EasyLoadingMaskType.clear,
      );
      final apiResponseModel = await Http.post(
        Apis.nextStep,
        data: writeJobInfoModel,
      );

      final writeJobId = apiResponseModel?.data;

      writeJobInfoModel.id = writeJobId;
      showToast('保存成功');

      update();
      await EasyLoading.dismiss();
    } on Exception catch (e) {
      logger.warning(e);
      await EasyLoading.dismiss();
      rethrow;
    }
    return true;
  }

  Future<void> nextPage() async {
    try {
      final isOk = await save();
      if (!isOk) return;
      await Get.toNamed(
        Routes.JOBS_JOB_DETAILS,
        arguments: JobDetailPushParameters(
          type: writeJobInfoModel.jobActionType,
          writeJobInfoModel: writeJobInfoModel,
          record: Records(
            id: writeJobInfoModel.id,
            workFace: writeJobInfoModel.workFaceModel?.key,
            repairRecord: writeJobInfoModel.repairRecord,
            shift: writeJobInfoModel.shift,
            drillSite: writeJobInfoModel.drillInfoModel?.drillSite,
            holeDepth: writeJobInfoModel.drillInfoModel?.holeDepth,
            drillNumber: writeJobInfoModel.drillInfoModel?.drillNumber,
          ),
        ),
      );
    } on Exception catch (e) {
      logger.warning(e);
    } finally {
      await EasyLoading.dismiss();
    }
  }

  bool checkInput() {
    if (writeJobInfoModel.workFaceModel?.key == null) {
      showToast('请选择工作面');
      return false;
    }

    if (writeJobInfoModel.querySiteModel?.key == null) {
      showToast('请选择钻场');
      return false;
    }

    if (writeJobInfoModel.querySiteNumberModel?.key == null) {
      showToast('请选择钻孔编号');
      return false;
    }

    if (writeJobInfoModel.constructDateString == null) {
      showToast('请选择作业时间');
      return false;
    }

    if (writeJobInfoModel.shift == null) {
      showToast('请选择施工班次');
      return false;
    }

    if (writeJobInfoModel.captain == null) {
      showToast('请输入施工机长');
      return false;
    }

    if (writeJobInfoModel.crewMembers == null) {
      showToast('请输入班组人员');
      return false;
    }
    // if (writeJobInfoModel.jobAzimuth == null) {
    //   showToast('请输入方位角');
    //   return false;
    // }
    //
    // if (writeJobInfoModel.jobDip == null) {
    //   showToast('请输入倾角');
    //   return false;
    // }

    if (writeJobInfoModel.monitorOn == null) {
      showToast('请选择监控是否开启');
      return false;
    }

    if (writeJobInfoModel.monitorPosition == null) {
      showToast('请选择监控位置确认');
      return false;
    }

    return true;
  }

  Future showQueryWorkFace() async {
    final model = await Get.toNamed(Routes.QUERY_WORK_FACE);
    if (model == null) return;
    writeJobInfoModel
      ..workFaceModel = model
      ..querySiteModel = null
      ..querySiteNumberModel = null;
    update();
  }

  Future showQuerySite() async {
    if (writeJobInfoModel.workFaceModel?.key == null) {
      showToast('请选择工作面');
      return;
    }

    final model = await Get.toNamed(
      Routes.QUERY_SITE,
      arguments: writeJobInfoModel.workFaceModel,
    );
    if (model == null) return;

    writeJobInfoModel
      ..querySiteModel = model
      ..querySiteNumberModel = null;
    update();
  }

  Future showQuerySiteNumber() async {
    if (writeJobInfoModel.workFaceModel?.key == null) {
      showToast('请选择工作面');
      return;
    }

    if (writeJobInfoModel.querySiteModel?.key == null) {
      showToast('请选择钻场');
      return;
    }

    final model = await Get.toNamed(
      Routes.QUERY_SITE_NUMBER,
      arguments: writeJobInfoModel,
    );

    if (model == null) return;

    writeJobInfoModel.querySiteNumberModel = model;
    update();
    await getDrillInfo();
  }

  Future<void> getDrillInfo() async {
    try {
      await EasyLoading.show(
        status: '正在加载...',
        maskType: EasyLoadingMaskType.clear,
      );
      final apiResponseModel = await Http.post(
        Apis.drillTaskBy,
        queryParameters: {
          'workFace': writeJobInfoModel.workFaceModel?.key,
          'drillSite': writeJobInfoModel.querySiteModel?.key,
          'drillNumber': writeJobInfoModel.querySiteNumberModel?.key,
        },
      );
      writeJobInfoModel.drillInfoModel =
          DrillInfoModel.fromJson(apiResponseModel?.data);
    } on Exception catch (e) {
      logger.warning(e);
    } finally {
      await EasyLoading.dismiss();
    }
    update();
  }

  Future showWorkingTimeActionSheet(BuildContext context) async {
    try {
      final apiResponseModel = await Http.get(
        Apis.shifts,
      );

      final shiftList = <ShiftModel>[];

      final data = apiResponseModel?.data as List;
      for (final item in data) {
        shiftList.add(ShiftModel.fromJson(item));
      }

      if (shiftList.isEmpty) return;
      await showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            title: Text("施工班次".tr),
            actions: shiftList
                .map(
                  (e) => CupertinoActionSheetAction(
                    onPressed: () {
                      writeJobInfoModel.shift = e;
                      update();
                      Get.back();
                    },
                    child: Text(e.message ?? ''),
                  ),
                )
                .toList(),
          );
        },
      );
    } on Exception catch (e) {
      logger.warning(e);
    } finally {
      await EasyLoading.dismiss();
    }
  }

  Future showMonitoringIsEnabledActionSheet(BuildContext context) async {
    try {
      final apiResponseModel = await Http.get(
        Apis.monitorOns,
      );

      final monitorOnList = <MonitorOnModel>[];

      final data = apiResponseModel?.data as List;
      for (final item in data) {
        monitorOnList.add(MonitorOnModel.fromJson(item));
      }

      if (monitorOnList.isEmpty) return;
      await showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            title: Text("监控是否开启".tr),
            actions: monitorOnList
                .map(
                  (e) => CupertinoActionSheetAction(
                    onPressed: () {
                      writeJobInfoModel.monitorOn = e;
                      update();
                      Get.back();
                    },
                    child: Text(e.message ?? ''),
                  ),
                )
                .toList(),
          );
        },
      );
    } on Exception catch (e) {
      logger.warning(e);
    } finally {
      await EasyLoading.dismiss();
    }
  }

  Future showMonitoringLocationActionSheet(BuildContext context) async {
    try {
      final apiResponseModel = await Http.get(
        Apis.monitorPosition,
      );

      final monitorPositionList = <MonitorPositionModel>[];

      final data = apiResponseModel?.data as List;
      for (final item in data) {
        monitorPositionList.add(MonitorPositionModel.fromJson(item));
      }

      if (monitorPositionList.isEmpty) return;

      await showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            title: Text("监控位置确认".tr),
            actions: monitorPositionList
                .map(
                  (e) => CupertinoActionSheetAction(
                    onPressed: () {
                      writeJobInfoModel.monitorPosition = e;
                      update();
                      Get.back();
                    },
                    child: Text(e.message ?? ''),
                  ),
                )
                .toList(),
          );
        },
      );
    } on Exception catch (e) {
      logger.warning(e);
    } finally {
      await EasyLoading.dismiss();
    }
  }

  Future showWorkerCaptain() async {
    final text = await Get.to(
      const TextFieldEditPage(
        title: '施工机长',
        hintText: '请输入施工机长名字',
      ),
    );
    if (text == null) return;
    writeJobInfoModel.captain = text;
    update();
  }

  Future showWorkerName() async {
    final text = await Get.to(
      const TextFieldEditPage(
        title: '班组人员',
        hintText: '请输入班组人员名字',
      ),
    );

    if (text == null) return;
    writeJobInfoModel.crewMembers = text;
    update();
  }

  Future showAzimuth() async {
    final text = await Get.to(
      const TextFieldEditPage(
        title: '方位角',
        hintText: '请输入方位角(范围值0 ~ 360)',
        maxLength: 3,
        inputContentType: InputContentType.azimuthLimit,
      ),
    );

    if (text == null) return;
    final num = int.tryParse(text) ?? 0;
    if (num > 360) {
      showToast('方位角不能大于360 或小于0');
      return;
    }

    writeJobInfoModel.jobAzimuth = num;
    update();
  }

  Future showDip() async {
    final text = await Get.to(
      const TextFieldEditPage(
        title: '倾角',
        hintText: '请输入倾角(范围值-90 ~ 90)',
        maxLength: 3,
        inputContentType: InputContentType.dipLimit,
      ),
    );
    if (text == null) return;

    final num = int.tryParse(text) ?? 0;
    if (num > 90 || num < -90) {
      showToast('倾角不能大于90 或小于 -90');
      return;
    }
    writeJobInfoModel.jobDip = num;
    update();
  }

  void setDateTime(DateTime dateTime) {
    writeJobInfoModel.constructDate = DateTimeUtil.dayConvertDateTime(dateTime);

    final dateString = DateFormat("yyyy-MM-dd").format(dateTime);
    writeJobInfoModel.constructDateString = dateString;
    update();
  }
}
