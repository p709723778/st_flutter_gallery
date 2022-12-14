import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/constants/const_types.dart';
import 'package:st/app/modules/jobs/job_details/model/job_command_detail_model.dart';
import 'package:st/app/modules/jobs/job_details/model/job_command_detail_records.dart';
import 'package:st/app/modules/jobs/job_details/model/job_command_model.dart';
import 'package:st/app/modules/jobs/job_details/model/job_detail_model.dart';
import 'package:st/app/modules/views/dialog_widget1.dart';
import 'package:st/app/modules/views/dialog_widget2.dart';
import 'package:st/app/modules/views/dialog_widget3.dart';
import 'package:st/app/modules/views/dialog_widget4.dart';
import 'package:st/app/modules/views/dialog_widget5.dart';
import 'package:st/app/network_request/apis/apis.dart';
import 'package:st/app/network_request/http.dart';
import 'package:st/helpers/logger/logger_helper.dart';

class JobCommandActionsController extends GetxController {
  JobCommandActionsController({this.jobDetailModel});

  late final JobDetailModel? jobDetailModel;

  JobCommandDetailModel? jobCommandDetailModel;

  final List<JobCommandDetailRecords> list = [];

  JobCommandModel currentJobCommandModel =
      JobCommandModel(code: ConstTypes.DaZuanType, message: '打钻');

  /// 开始结束按钮状态 1 开始  2 结束  3 已结束
  int actionBtnState = 1;

  @override
  void onInit() {
    getJobCommandActionsDetail();
    super.onInit();
  }

  Future<void> getJobCommandActionsDetail() async {
    try {
      await EasyLoading.show(
        status: '正在加载...',
        maskType: EasyLoadingMaskType.clear,
      );
      final apiResponseModel = await Http.post(
        Apis.instructRecords,
        // data: {'page': 1, 'rows': 10, 'taskAccountId': jobDetailModel?.id},
        queryParameters: {
          'page': 1,
          'rows': 20,
          'taskAccountId': jobDetailModel?.id,
        },
      );

      list.clear();
      jobCommandDetailModel =
          JobCommandDetailModel.fromJson(apiResponseModel?.data);

      jobCommandDetailModel?.records?.forEach(list.add);

      refreshActionState();
      update();
      await EasyLoading.dismiss();
    } on Exception catch (e) {
      logger.warning(e);
      await EasyLoading.dismiss();
    }
  }

  Future<void> startJob() async {
    if (checkExistStartJob()) {
      return;
    }
    var result = false;
    if (currentJobCommandModel.code == ConstTypes.DaZuanType) {
      result = await Get.dialog(
        const DialogWidget3(
          title: '是否开始打钻',
        ),
      );
    } else if (currentJobCommandModel.code == ConstTypes.TuiGanType) {
      result = await Get.dialog(
        const DialogWidget3(
          title: '是否开始退杆',
        ),
      );
    } else if (currentJobCommandModel.code == ConstTypes.KuoKongType) {
      result = await Get.dialog(
        const DialogWidget3(
          title: '是否开始扩孔',
        ),
      );
    } else if (currentJobCommandModel.code == ConstTypes.FengKongType) {
      result = await Get.dialog(
        const DialogWidget3(
          title: '是否开始封孔',
        ),
      );
    } else if (currentJobCommandModel.code == ConstTypes.ZhuJiangType) {
      result = await Get.dialog(
        const DialogWidget3(
          title: '是否开始注浆',
        ),
      );
    }

    if (result) {
      await startActionRequest();
    }
  }

  Future<void> endJob() async {
    final model = list.firstWhere(
      (element) => element.jobInstruct?.code == currentJobCommandModel.code,
      orElse: JobCommandDetailRecords.new,
    );

    if (model.jobInstruct == null) {
      showToast('没找到对应开始作业');
      return;
    }

    String? remark = '';
    if (currentJobCommandModel.code == ConstTypes.DaZuanType) {
      DialogModel1? dialogModel1;
      dialogModel1 = await Get.dialog(const DialogWidget1());
      if (dialogModel1 == null) return;
      model
        ..drillPipeLength = double.tryParse(dialogModel1.zuanGanChangDu)
        ..dutyFootage = double.tryParse(dialogModel1.dangBanJinChi)
        ..boreholeDiameter = double.tryParse(dialogModel1.zuanKongZhiJing);
      remark = dialogModel1.remark;
    } else if (currentJobCommandModel.code == ConstTypes.KuoKongType) {
      DialogModel4? dialogModel4;
      dialogModel4 = await Get.dialog(const DialogWidget4());
      if (dialogModel4 == null) return;
      model
        ..reamingDiameter = double.tryParse(dialogModel4.kuoKongZhiJing)
        ..reamingDepth = double.tryParse(dialogModel4.kuoKongShenDu);
      remark = dialogModel4.remark;
    } else if (currentJobCommandModel.code == ConstTypes.FengKongType) {
      DialogModel5? dialogModel5;
      dialogModel5 = await Get.dialog(const DialogWidget5());
      if (dialogModel5 == null) return;
      model.sealingLength = double.tryParse(dialogModel5.fengKongChangDu);
      remark = dialogModel5.remark;
    } else {
      remark = await Get.dialog(const DialogWidget2());
      if (remark == null) return;
    }

    model.remarks = remark;

    await endJobActionRequest(model);
  }

  bool checkExistStartJob() {
    final model = list.firstWhere(
      (element) =>
          element.jobInstruct?.code != currentJobCommandModel.code &&
          element.startTime != null &&
          element.endTime == null,
      orElse: JobCommandDetailRecords.new,
    );
    if (model.jobInstruct?.code != null) {
      showToast('请先结束${model.jobInstruct?.message}作业');
      return true;
    }
    return false;
  }

  Future showCommandTypeSheet(BuildContext context) async {
    try {
      final apiResponseModel = await Http.get(
        Apis.instructions,
      );

      final jobCommandList = <JobCommandModel>[];

      final data = apiResponseModel?.data as List;
      for (final item in data) {
        jobCommandList.add(JobCommandModel.fromJson(item));
      }

      if (jobCommandList.isEmpty) return;

      await showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            title: Text("指令类型".tr),
            actions: jobCommandList
                .map(
                  (e) => CupertinoActionSheetAction(
                    onPressed: () {
                      currentJobCommandModel = e;
                      refreshActionState();
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

  Future<void> startActionRequest() async {
    try {
      await EasyLoading.show(
        status: '正在加载...',
        maskType: EasyLoadingMaskType.clear,
      );

      await Http.post(
        Apis.startJob,
        data: {
          'jobInstructEnum': currentJobCommandModel.code.toString(),
          'taskAccountId': jobDetailModel?.id,
        },
      );

      await EasyLoading.dismiss();
      await getJobCommandActionsDetail();
    } on Exception catch (e) {
      logger.warning(e);
      await EasyLoading.dismiss();
    }
  }

  Future<void> endJobActionRequest(JobCommandDetailRecords model) async {
    try {
      await EasyLoading.show(
        status: '正在加载...',
        maskType: EasyLoadingMaskType.clear,
      );
      await Http.post(
        Apis.endJob,
        data: model,
      );

      await EasyLoading.dismiss();

      await getJobCommandActionsDetail();
    } on Exception catch (e) {
      logger.warning(e);
      await EasyLoading.dismiss();
    }
  }

  void refreshActionState() {
    if (list.isEmpty) {
      actionBtnState = 1;
    } else {
      final isExist = list.any(
        (element) => element.jobInstruct?.code == currentJobCommandModel.code,
      );
      if (isExist) {
        for (final item in list) {
          if (item.jobInstruct?.code == currentJobCommandModel.code &&
              item.startTime == null &&
              item.endTime == null) {
            actionBtnState = 1;
          } else if (item.jobInstruct?.code == currentJobCommandModel.code &&
              item.startTime != null &&
              item.endTime == null) {
            actionBtnState = 2;
          } else if (item.jobInstruct?.code == currentJobCommandModel.code &&
              item.startTime != null &&
              item.endTime != null) {
            actionBtnState = 3;
          }
        }
      } else {
        actionBtnState = 1;
      }
    }
  }
}
