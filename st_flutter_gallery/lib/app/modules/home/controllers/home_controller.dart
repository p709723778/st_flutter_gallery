import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/home/model/job_number_model.dart';
import 'package:st/app/modules/jobs/jobs_enum.dart';
import 'package:st/app/network_request/apis/apis.dart';
import 'package:st/app/network_request/http.dart';
import 'package:st/app/routes/app_pages.dart';
import 'package:st/helpers/logger/logger_helper.dart';

class HomeController extends GetxController {
  HomeController({this.context});

  late final BuildContext? context;
  static const int numbersID = 1;
  JobNumberModel jobNumberModel = JobNumberModel();

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    logger.info('onReady');
  }

  @override
  void onClose() {}

  Future<void> getJobNumbers() async {
    try {
      final apiResponseModel = await Http.get(
        Apis.jobHome,
      );
      jobNumberModel = JobNumberModel.fromJson(apiResponseModel?.data);
    } on Exception catch (e) {
      logger.warning(e);
    }

    update([numbersID]);
  }

  void startJobAction() {
    Get.toNamed(Routes.START_JOB_PAGE, arguments: JobActionType.start);
  }

  void replenishmentJobAction() {
    Get.toNamed(Routes.START_JOB_PAGE, arguments: JobActionType.replenishment);
  }

  void completedJobAction() {
    Get.toNamed(Routes.COMPLETED_JOB, arguments: JobActionType.completed);
  }

  void underwayJobAction() {
    Get.toNamed(Routes.UNDERWAY_JOB, arguments: JobActionType.underway);
  }
}
