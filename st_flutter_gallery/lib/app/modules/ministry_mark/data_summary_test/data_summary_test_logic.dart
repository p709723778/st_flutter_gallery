import 'dart:async';

import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/models/data_summary/data_summary_get_req_model.dart';
import 'package:st/app/models/data_summary/data_summary_get_resp_model.dart';
import 'package:st/extension/string_extension.dart';
import 'package:st/utils/bcd_data/bcd_data_util.dart';

class DataSummaryTestLogic extends GetxController {
  late StreamSubscription<DataSummaryGetRespModel> _streamSubscription;

  DataSummaryGetRespModel? dataSummarySetRespModel;
  @override
  void onInit() {
    _streamSubscription = SocketMessageManager.instance
        .on<DataSummaryGetRespModel>()
        .listen((event) {
      if (event.dataSummary.hasValue) {
        dataSummarySetRespModel = event;
        showToast('数据摘要测试成功');
        update();
      } else {
        showToast('数据摘要测试失败');
      }
    });

    super.onInit();
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
    super.onClose();
  }

  void done() {
    /// 通讯机时间
    final deviceDateBytes = BcdDataUtil.getDeviceDateTimeBcdBytes();

    final model = DataSummaryGetReqModel(dataBytes: deviceDateBytes);
    SocketMessageManager.instance.sendMessage(model.commandFrame);
  }

  String get recorderInfo {
    var text = '';
    text += '通讯机时间: ${dataSummarySetRespModel?.time ?? ''}\n';

    text +=
        '生产认证代码: ${dataSummarySetRespModel?.recorderUniqueNumber.authCode ?? ''}\n';
    text +=
        '认证产品型号: ${dataSummarySetRespModel?.recorderUniqueNumber.authModelNumber ?? ''}\n';
    text +=
        '生产日期: ${dataSummarySetRespModel?.recorderUniqueNumber.year ?? ''}年${dataSummarySetRespModel?.recorderUniqueNumber.month ?? ''}月${dataSummarySetRespModel?.recorderUniqueNumber.day ?? ''}日\n';
    text +=
        '生产流水号: ${dataSummarySetRespModel?.recorderUniqueNumber.lineNumber ?? ''}\n';
    text +=
        '制造商名称简称: ${dataSummarySetRespModel?.recorderUniqueNumber.manufacturerName ?? ''}\n';
    text +=
        '产品型号简称: ${dataSummarySetRespModel?.recorderUniqueNumber.productNumber ?? ''}\n';
    text += '数据摘要: ${dataSummarySetRespModel?.dataSummary ?? ''}\n';

    return text;
  }
}
