import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/models/platform_ip/platform_ip_get_req_model.dart';
import 'package:st/app/models/platform_ip/platform_ip_get_resp_model.dart';
import 'package:st/extension/string_extension.dart';

class PlatformIpGetLogic extends GetxController {
  late StreamSubscription<PlatformIpGetRespModel> _streamSubscription;

  PlatformIpGetRespModel? platformIpGetRespModel;
  @override
  void onInit() {
    _streamSubscription = SocketMessageManager.instance
        .on<PlatformIpGetRespModel>()
        .listen((event) {
      if (event.tcpInfo.hasValue) {
        showToast('平台IP端口查询成功');
      } else {
        showToast('平台IP端口查询失败');
      }
      EasyLoading.dismiss();
      platformIpGetRespModel = event;

      update();
    });
    search();
    super.onInit();
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
    super.onClose();
  }

  void search() {
    final reqModel = PlatformIpGetReqModel(dataBytes: []);
    SocketMessageManager.instance.sendMessage(reqModel.commandFrame);
  }
}
