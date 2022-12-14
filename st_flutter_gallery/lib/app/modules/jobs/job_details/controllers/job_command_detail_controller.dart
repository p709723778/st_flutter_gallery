import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/jobs/job_details/model/job_command_detail_model.dart';
import 'package:st/app/modules/jobs/job_details/model/job_command_detail_records.dart';
import 'package:st/app/modules/jobs/job_details/model/job_detail_model.dart';
import 'package:st/app/modules/jobs/job_details/model/job_repair_people.dart';
import 'package:st/app/network_request/apis/apis.dart';
import 'package:st/app/network_request/http.dart';
import 'package:st/helpers/logger/logger_helper.dart';

class JobCommandDetailController extends GetxController {
  JobCommandDetailController({this.jobDetailModel});

  late final JobDetailModel? jobDetailModel;

  JobCommandDetailModel? jobCommandDetailModel;
  JobRepairPeople? jobRepairPeople;

  final List<JobCommandDetailRecords> list = [];

  static const int RepairPeopleID = 0;

  @override
  void onInit() {
    getJobCommandDetail();
    getJobRepairPeople();
    super.onInit();
  }

  Future<void> getJobCommandDetail() async {
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

      jobCommandDetailModel =
          JobCommandDetailModel.fromJson(apiResponseModel?.data);

      jobCommandDetailModel?.records?.forEach(list.add);

      update();
      await EasyLoading.dismiss();
    } on Exception catch (e) {
      logger.warning(e);
      await EasyLoading.dismiss();
    }
  }

  Future<void> getJobRepairPeople() async {
    try {
      final apiResponseModel = await Http.post(
        Apis.repairPeople,
        queryParameters: {
          'taskAccountId': jobDetailModel?.id,
        },
      );

      jobRepairPeople = JobRepairPeople.fromJson(apiResponseModel?.data);

      update([RepairPeopleID]);
    } on Exception catch (e) {
      logger.warning(e);
    }
  }
}
