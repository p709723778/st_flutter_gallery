import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/jobs/underway_job/model/records.dart';
import 'package:st/app/modules/jobs/underway_job/model/underway_job_model.dart';
import 'package:st/app/network_request/apis/apis.dart';
import 'package:st/app/network_request/http.dart';
import 'package:st/helpers/logger/logger_helper.dart';

class UnderwayJobController extends GetxController {
  late final easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  int page = 1;
  int rows = 20;

  final List<Records> list = [];
  UnderwayJobModel? underwayJobModel;
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> onRefresh() async {
    page = 1;
    list.clear();
    await getData();

    easyRefreshController
      ..finishRefresh()
      ..resetHeader();
    update();
  }

  Future<void> onLoad() async {
    try {
      page++;
      await getData();

      if (list.length >= (underwayJobModel?.total ?? 0)) {
        easyRefreshController.finishLoad(
          IndicatorResult.noMore,
        );
      } else {
        easyRefreshController
          ..finishLoad()
          ..resetFooter();
      }

      update();
    } on Exception catch (e) {
      logger.info(e);
    }
  }

  Future<void> getData() async {
    try {
      await EasyLoading.show(
        status: '正在加载...',
        maskType: EasyLoadingMaskType.clear,
      );
      final apiResponseModel = await Http.post(
        Apis.afootJobs,
        queryParameters: {
          'page': page,
          'rows': rows,
        },
      );

      underwayJobModel = UnderwayJobModel.fromJson(apiResponseModel?.data);

      underwayJobModel?.records?.forEach(list.add);
      if (list.length >= (underwayJobModel?.total ?? 0)) {
        easyRefreshController.finishLoad(
          IndicatorResult.noMore,
        );
      }

      update();

      await EasyLoading.dismiss();
    } on Exception catch (e) {
      await EasyLoading.dismiss();
      logger.warning(e);
      rethrow;
    }
  }

  @override
  void onClose() {}
}
