import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/jobs/job_details/controllers/job_replenishment_controller.dart';
import 'package:st/app/modules/jobs/job_details/model/job_detail_model.dart';
import 'package:st/app/modules/jobs/job_details/model/job_detail_push_parameters.dart';
import 'package:st/app/modules/jobs/jobs_enum.dart';
import 'package:st/app/network_request/apis/apis.dart';
import 'package:st/app/network_request/http.dart';
import 'package:st/helpers/logger/logger_helper.dart';

class JobsJobDetailsController extends GetxController {
  JobDetailModel jobDetailModel = JobDetailModel();
  JobDetailPushParameters? jobDetailPushParameters;

  /// 补录控制器
  late final JobReplenishmentController jobReplenishmentController =
      JobReplenishmentController();

  @override
  Future<void> onInit() async {
    jobDetailPushParameters = Get.arguments;

    if (jobDetailPushParameters?.type == JobActionType.underway) {
    } else if (jobDetailPushParameters?.type == JobActionType.start) {
      // getData();
    } else if (jobDetailPushParameters?.type == JobActionType.replenishment) {
      // getData();
    } else if (jobDetailPushParameters?.type == JobActionType.completed) {
      // getData();
    }
    jobReplenishmentController.writeJobInfoModel =
        jobDetailPushParameters?.writeJobInfoModel;

    await getJobDetail();

    super.onInit();
  }

  Future<void> getJobDetail() async {
    try {
      if (jobDetailPushParameters?.type != JobActionType.start &&
          jobDetailPushParameters?.type != JobActionType.replenishment) {
        await EasyLoading.show(
          status: '正在加载...',
          maskType: EasyLoadingMaskType.clear,
        );
      }
      if (jobDetailPushParameters?.type != JobActionType.replenishment) {
        final apiResponseModel = await Http.post(
          Apis.jobBasicInfo,
          queryParameters: {'id': jobDetailPushParameters?.record?.id},
        );
        jobDetailModel = JobDetailModel.fromJson(apiResponseModel?.data);
        jobReplenishmentController.jobDetailModel = jobDetailModel;
      } else {
        if (jobReplenishmentController.writeJobInfoModel != null) {
          final tempJobDetailModel = JobDetailModel()
            ..convertToDetail(jobReplenishmentController.writeJobInfoModel!);
          jobDetailModel = tempJobDetailModel;
          jobReplenishmentController.jobDetailModel = tempJobDetailModel;
        }
      }
    } on Exception catch (e) {
      logger.warning(e);
    } finally {
      if (jobDetailPushParameters?.type != JobActionType.start &&
          jobDetailPushParameters?.type != JobActionType.replenishment) {
        await EasyLoading.dismiss();
      }
    }

    update();
  }

  @override
  void onClose() {}
}
