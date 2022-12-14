import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/jobs/start_job_page/model/write_job_info_model.dart';
import 'package:st/app/modules/query_site_number/model/query_site_numver_model.dart';
import 'package:st/app/network_request/apis/apis.dart';
import 'package:st/app/network_request/http.dart';
import 'package:st/helpers/logger/logger_helper.dart';

class QuerySiteNumberController extends GetxController {
  late final easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  final List<QuerySiteNumberModel> list = [];
  WriteJobInfoModel? writeJobInfoModel;

  @override
  void onInit() {
    writeJobInfoModel = Get.arguments;
    getDrillNumbers();
    super.onInit();
  }

  @override
  void onClose() {}

  Future<void> getDrillNumbers() async {
    try {
      await EasyLoading.show(
        status: '正在加载...',
        maskType: EasyLoadingMaskType.clear,
      );
      final apiResponseModel = await Http.post(
        Apis.drillNumbers,
        queryParameters: {
          'workFace': writeJobInfoModel?.workFaceModel?.value,
          'drillSite': writeJobInfoModel?.querySiteModel?.value,
        },
      );

      final data = apiResponseModel?.data as List;
      for (final item in data) {
        list.add(QuerySiteNumberModel.fromJson(item));
      }
    } on Exception catch (e) {
      logger.warning(e);
    } finally {
      await EasyLoading.dismiss();
    }
    update();
  }
}
