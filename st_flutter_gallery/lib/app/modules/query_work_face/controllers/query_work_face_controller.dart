import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/query_work_face/model/work_face_model.dart';
import 'package:st/app/network_request/apis/apis.dart';
import 'package:st/app/network_request/http.dart';
import 'package:st/helpers/logger/logger_helper.dart';

class QueryWorkFaceController extends GetxController {
  late final easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  final List<WorkFaceModel> list = [];
  @override
  void onInit() {
    getWorkFace();
    super.onInit();
  }

  Future<void> getWorkFace() async {
    try {
      await EasyLoading.show(
        status: '正在加载...',
        maskType: EasyLoadingMaskType.clear,
      );
      final apiResponseModel = await Http.get(
        Apis.workFaces,
      );

      final data = apiResponseModel?.data as List;
      for (final item in data) {
        list.add(WorkFaceModel.fromJson(item));
      }
    } on Exception catch (e) {
      logger.warning(e);
    } finally {
      await EasyLoading.dismiss();
    }
    update();
  }

  @override
  void onClose() {}
}
