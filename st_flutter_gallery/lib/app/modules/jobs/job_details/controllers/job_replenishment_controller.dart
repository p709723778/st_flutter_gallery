import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/modules/jobs/job_details/model/job_detail_model.dart';
import 'package:st/app/modules/jobs/job_details/model/job_replenishment_model.dart';
import 'package:st/app/modules/jobs/start_job_page/model/write_job_info_model.dart';
import 'package:st/app/modules/views/text_field_edit_page.dart';
import 'package:st/app/network_request/apis/apis.dart';
import 'package:st/app/network_request/http.dart';
import 'package:st/app/routes/app_pages.dart';
import 'package:st/helpers/logger/logger_helper.dart';

class JobReplenishmentController extends GetxController {
  JobReplenishmentController({this.jobDetailModel, this.writeJobInfoModel});

  RxBool isDaZuanSelect = false.obs;
  RxBool isTuiGanSelect = false.obs;
  RxBool isKuoKongSelect = false.obs;
  RxBool isFengKongSelect = false.obs;
  RxBool isZhuJiangSelect = false.obs;

  JobDetailModel? jobDetailModel;

  WriteJobInfoModel? writeJobInfoModel;
  JobReplenishmentModel jobReplenishmentModelDaZuan =
      JobReplenishmentModel(jobInstruct: '1');

  JobReplenishmentModel jobReplenishmentModelTuiGan =
      JobReplenishmentModel(jobInstruct: '2');

  JobReplenishmentModel jobReplenishmentModelKuoKong =
      JobReplenishmentModel(jobInstruct: '3');

  JobReplenishmentModel jobReplenishmentModelFengKong =
      JobReplenishmentModel(jobInstruct: '4');

  JobReplenishmentModel jobReplenishmentModelZhuJiang =
      JobReplenishmentModel(jobInstruct: '5');

  final TextEditingController textEditingControllerDaZuan =
      TextEditingController();
  final TextEditingController textEditingControllerTuiGan =
      TextEditingController();
  final TextEditingController textEditingControllerKuoKong =
      TextEditingController();
  final TextEditingController textEditingControllerFengKong =
      TextEditingController();
  final TextEditingController textEditingControllerZhuJiang =
      TextEditingController();

  @override
  void onInit() {
    textEditingControllerDaZuan.addListener(() {
      jobReplenishmentModelDaZuan.remarks = textEditingControllerDaZuan.text;
    });
    textEditingControllerTuiGan.addListener(() {
      jobReplenishmentModelTuiGan.remarks = textEditingControllerTuiGan.text;
    });
    textEditingControllerKuoKong.addListener(() {
      jobReplenishmentModelKuoKong.remarks = textEditingControllerKuoKong.text;
    });
    textEditingControllerFengKong.addListener(() {
      jobReplenishmentModelFengKong.remarks =
          textEditingControllerFengKong.text;
    });
    textEditingControllerZhuJiang.addListener(() {
      jobReplenishmentModelZhuJiang.remarks =
          textEditingControllerZhuJiang.text;
    });

    jobReplenishmentModelDaZuan.setDateTime(writeJobInfoModel!);
    jobReplenishmentModelTuiGan.setDateTime(writeJobInfoModel!);
    jobReplenishmentModelKuoKong.setDateTime(writeJobInfoModel!);
    jobReplenishmentModelFengKong.setDateTime(writeJobInfoModel!);
    jobReplenishmentModelZhuJiang.setDateTime(writeJobInfoModel!);

    super.onInit();
  }

  Future<void> onConform() async {
    if (!checkInput()) return;

    try {
      /// 先保存
      await EasyLoading.show(
        status: '正在加载...',
        maskType: EasyLoadingMaskType.clear,
      );
      final saveApiResponseModel = await Http.post(
        Apis.nextStep,
        data: writeJobInfoModel,
      );

      final writeJobId = saveApiResponseModel?.data;

      jobDetailModel?.id = writeJobId;

      jobReplenishmentModelDaZuan.setJobDetailModelData(jobDetailModel!);
      jobReplenishmentModelTuiGan.setJobDetailModelData(jobDetailModel!);
      jobReplenishmentModelKuoKong.setJobDetailModelData(jobDetailModel!);
      jobReplenishmentModelFengKong.setJobDetailModelData(jobDetailModel!);
      jobReplenishmentModelZhuJiang.setJobDetailModelData(jobDetailModel!);

      final listData = [
        if (isDaZuanSelect.value) jobReplenishmentModelDaZuan.toJson(),
        if (isTuiGanSelect.value) jobReplenishmentModelTuiGan.toJson(),
        if (isKuoKongSelect.value) jobReplenishmentModelKuoKong.toJson(),
        if (isFengKongSelect.value) jobReplenishmentModelFengKong.toJson(),
        if (isZhuJiangSelect.value) jobReplenishmentModelZhuJiang.toJson(),
      ];
      logger.info(jsonEncode(listData));
      final apiResponseModel = await Http.post(
        Apis.instructAddRecord,
        data: listData,
      );
      logger.info(apiResponseModel);
      update();
      await EasyLoading.dismiss();
      showToast('提交成功');

      Get.until((route) => route.settings.name == Routes.HOME);
    } on Exception catch (e) {
      logger.warning(e);
      await EasyLoading.dismiss();
    }
  }

  bool checkInput() {
    if (!isDaZuanSelect.value &&
        !isTuiGanSelect.value &&
        !isKuoKongSelect.value &&
        !isFengKongSelect.value &&
        !isZhuJiangSelect.value) {
      showToast('请至少选择一个指令');
      return false;
    }

    if (isDaZuanSelect.value) {
      if (!jobReplenishmentModelDaZuan.checkStartEndTime()) {
        showToast('开始时间不能晚于结束时间');
        return false;
      }

      if (jobReplenishmentModelDaZuan.drillPipeLength == null) {
        showToast('请输入钻杆长度');
        return false;
      }

      if (jobReplenishmentModelDaZuan.dutyFootage == null) {
        showToast('请输入当班进尺');
        return false;
      }

      if (jobReplenishmentModelDaZuan.boreholeDiameter == null) {
        showToast('请输入钻孔直径');
        return false;
      }
    }

    if (isTuiGanSelect.value) {
      if (!jobReplenishmentModelTuiGan.checkStartEndTime()) {
        showToast('开始时间不能晚于结束时间');
        return false;
      }
      logger.info('退杆暂无校验字段');
    }

    if (isKuoKongSelect.value) {
      if (!jobReplenishmentModelKuoKong.checkStartEndTime()) {
        showToast('开始时间不能晚于结束时间');
        return false;
      }

      if (jobReplenishmentModelKuoKong.reamingDiameter == null) {
        showToast('请输入扩孔直径');
        return false;
      }

      if (jobReplenishmentModelKuoKong.reamingDepth == null) {
        showToast('请输入扩孔深度');
        return false;
      }
    }

    if (isFengKongSelect.value) {
      if (!jobReplenishmentModelFengKong.checkStartEndTime()) {
        showToast('开始时间不能晚于结束时间');
        return false;
      }

      if (jobReplenishmentModelFengKong.sealingLength == null) {
        showToast('请输入封孔长度');
        return false;
      }
    }

    if (isZhuJiangSelect.value) {
      if (!jobReplenishmentModelZhuJiang.checkStartEndTime()) {
        showToast('开始时间不能晚于结束时间');
        return false;
      }
      logger.info('注浆暂无校验字段');
    }

    return true;
  }

  Future showDrillPipeLength() async {
    final text = await Get.to(
      const TextFieldEditPage(
        title: '钻杆长度',
        hintText: '请输入钻杆长度',
        inputContentType: InputContentType.precisionLimit,
      ),
    );

    if (text == null) return;
    final num = double.tryParse(text) ?? 0;
    if (num > double.maxFinite) {
      showToast('钻杆长度不能大于${double.maxFinite}');
      return;
    }

    jobReplenishmentModelDaZuan.drillPipeLength = double.tryParse(text);
    update();
  }

  Future showDutyFootage() async {
    final text = await Get.to(
      const TextFieldEditPage(
        title: '当班进尺',
        hintText: '请输入当班进尺',
        inputContentType: InputContentType.precisionLimit,
      ),
    );
    if (text == null) return;
    final num = double.tryParse(text) ?? 0;
    if (num > double.maxFinite) {
      showToast('当班进尺不能大于${double.maxFinite}');
      return;
    }
    jobReplenishmentModelDaZuan.dutyFootage = double.tryParse(text);
    update();
  }

  Future showDutyFootage1() async {
    final text = await Get.to(
      const TextFieldEditPage(
        title: '钻孔直径',
        hintText: '请输入钻孔直径',
        inputContentType: InputContentType.precisionLimit,
      ),
    );
    if (text == null) return;
    final num = double.tryParse(text) ?? 0;
    if (num > double.maxFinite) {
      showToast('钻孔直径不能大于${double.maxFinite}');
      return;
    }
    jobReplenishmentModelDaZuan.boreholeDiameter = double.tryParse(text);
    update();
  }

  Future showDutyFootage2() async {
    final text = await Get.to(
      const TextFieldEditPage(
        title: '扩孔直径',
        hintText: '请输入扩孔直径',
        inputContentType: InputContentType.precisionLimit,
      ),
    );
    if (text == null) return;
    final num = double.tryParse(text) ?? 0;
    if (num > double.maxFinite) {
      showToast('扩孔直径不能大于${double.maxFinite}');
      return;
    }
    jobReplenishmentModelKuoKong.reamingDiameter = double.tryParse(text);
    update();
  }

  Future showDutyFootage3() async {
    final text = await Get.to(
      const TextFieldEditPage(
        title: '扩孔深度',
        hintText: '请输入扩孔深度',
        inputContentType: InputContentType.precisionLimit,
      ),
    );
    if (text == null) return;
    final num = double.tryParse(text) ?? 0;
    if (num > double.maxFinite) {
      showToast('扩孔深度不能大于${double.maxFinite}');
      return;
    }
    jobReplenishmentModelKuoKong.reamingDepth = double.tryParse(text);
    update();
  }

  Future showDutyFootage4() async {
    final text = await Get.to(
      const TextFieldEditPage(
        title: '封孔长度',
        hintText: '请输入封孔长度',
        inputContentType: InputContentType.precisionLimit,
      ),
    );
    if (text == null) return;
    final num = double.tryParse(text) ?? 0;
    if (num > double.maxFinite) {
      showToast('封孔长度不能大于${double.maxFinite}');
      return;
    }
    jobReplenishmentModelFengKong.sealingLength = double.tryParse(text);
    update();
  }

  Future showDaZuanCaptain() async {
    final text = await Get.to(
      const TextFieldEditPage(
        title: '班长',
        hintText: '请输入班长名字',
      ),
    );
    if (text == null) return;
    jobReplenishmentModelDaZuan.captain = text;
    update();
  }

  Future showTuiGanCaptain() async {
    final text = await Get.to(
      const TextFieldEditPage(
        title: '班长',
        hintText: '请输入班长名字',
      ),
    );
    if (text == null) return;
    jobReplenishmentModelTuiGan.captain = text;
    update();
  }

  Future showKuoKongCaptain() async {
    final text = await Get.to(
      const TextFieldEditPage(
        title: '班长',
        hintText: '请输入班长名字',
      ),
    );
    if (text == null) return;
    jobReplenishmentModelKuoKong.captain = text;
    update();
  }

  Future showFengKongCaptain() async {
    final text = await Get.to(
      const TextFieldEditPage(
        title: '班长',
        hintText: '请输入班长名字',
      ),
    );
    if (text == null) return;
    jobReplenishmentModelFengKong.captain = text;
    update();
  }

  Future showZhuJiangCaptain() async {
    final text = await Get.to(
      const TextFieldEditPage(
        title: '班长',
        hintText: '请输入班长名字',
      ),
    );
    if (text == null) return;
    jobReplenishmentModelZhuJiang.captain = text;
    update();
  }
}
