import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/jobs/completed_job/model/completed_job_model.dart';
import 'package:st/app/modules/jobs/underway_job/model/records.dart';
import 'package:st/app/network_request/apis/apis.dart';
import 'package:st/app/network_request/http.dart';
import 'package:st/helpers/logger/logger_helper.dart';

class CompletedJobController extends GetxController {
  List tabs = <String>["自动记录(0条)", "补录信息（0条）"];

  late final easyRefreshControllerAuto = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  late final easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  int page = 1;
  int pageAuto = 1;
  int rows = 20;
  CompletedJobModel? completedJobModel;
  CompletedJobModel? completedJobModelAuto;

  static int listIAutoD = 1;
  static int listID = 2;
  static int tabBarID = 2;

  /// 自动完成记录
  final List<Records> listAuto = [];

  /// 补录完成记录
  final List<Records> list = [];

  @override
  Future<void> onInit() async {
    await getDataAuto();
    await getData();
    super.onInit();
  }

  @override
  void onClose() {}

  Future<void> onRefresh() async {
    page = 1;
    list.clear();

    easyRefreshController
      ..finishRefresh()
      ..resetHeader();

    await getData();

    update([tabBarID, listID]);
  }

  Future<void> onLoad() async {
    try {
      page++;
      await getData();

      update([tabBarID, listID]);
    } on Exception catch (e) {
      logger.info(e);
    }
  }

  Future<void> onRefreshAuto() async {
    pageAuto = 1;
    listAuto.clear();

    await getDataAuto();

    easyRefreshControllerAuto
      ..finishRefresh()
      ..resetHeader();

    update([tabBarID, listIAutoD]);
  }

  Future<void> onLoadAuto() async {
    try {
      pageAuto++;
      await getDataAuto();

      update([tabBarID, listIAutoD]);
    } on Exception catch (e) {
      logger.info(e);
    }
  }

  Future<void> getDataAuto() async {
    try {
      await EasyLoading.show(
        status: '正在加载...',
        maskType: EasyLoadingMaskType.clear,
      );
      final apiResponseModel = await Http.post(
        Apis.autoRecords,
        queryParameters: {
          'page': pageAuto,
          'rows': rows,
        },
      );

      completedJobModelAuto =
          CompletedJobModel.fromJson(apiResponseModel?.data);

      completedJobModelAuto?.records?.forEach(listAuto.add);
      if (listAuto.length >= (completedJobModelAuto?.total ?? 0)) {
        easyRefreshControllerAuto.finishLoad(
          IndicatorResult.noMore,
        );
      } else {
        easyRefreshControllerAuto
          ..finishLoad()
          ..resetFooter();
      }

      tabs = <String>[
        "自动记录(${completedJobModelAuto?.total ?? 0}条)",
        "补录信息（${completedJobModel?.total ?? 0}条）"
      ];

      update([tabBarID, listIAutoD]);

      await EasyLoading.dismiss();
    } on Exception catch (e) {
      await EasyLoading.dismiss();
      logger.warning(e);
      rethrow;
    }
  }

  Future<void> getData() async {
    try {
      await EasyLoading.show(
        status: '正在加载...',
        maskType: EasyLoadingMaskType.clear,
      );
      final apiResponseModel = await Http.post(
        Apis.repairRecords,
        queryParameters: {
          'page': page,
          'rows': rows,
        },
      );

      completedJobModel = CompletedJobModel.fromJson(apiResponseModel?.data);

      completedJobModel?.records?.forEach(list.add);
      if (list.length >= (completedJobModel?.total ?? 0)) {
        easyRefreshController.finishLoad(
          IndicatorResult.noMore,
        );
      } else {
        easyRefreshController
          ..finishLoad()
          ..resetFooter();
      }

      tabs = <String>[
        "自动记录(${completedJobModelAuto?.total ?? 0}条)",
        "补录信息（${completedJobModel?.total ?? 0}条）"
      ];

      update([tabBarID, listID]);

      await EasyLoading.dismiss();
    } on Exception catch (e) {
      await EasyLoading.dismiss();
      logger.warning(e);
    }
  }
}
