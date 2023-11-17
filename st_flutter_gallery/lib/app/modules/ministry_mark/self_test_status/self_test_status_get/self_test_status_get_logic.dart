import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/models/self_test_status/self_test_status_get_req_model.dart';
import 'package:st/app/models/self_test_status/self_test_status_get_resp_model.dart';

class SelfTestStatusGetLogic extends GetxController {
  late StreamSubscription _streamSubscription;

  SelfTestStatusGetRespModel? model;

  int flag1 = 0x01;
  int flag2 = 0x02;
  int flag3 = 0x04;
  int flag4 = 0x08;
  int flag5 = 0x10;
  int flag6 = 0x20;
  int flag7 = 0x40;
  int flag8 = 0x80;

  @override
  void onInit() {
    _streamSubscription = SocketMessageManager.instance
        .on<SelfTestStatusGetRespModel>()
        .listen((event) {
      if (event.dataBytes.isNotEmpty) {
        model = event;
        showToast('安装自检状态查询成功');
      } else {
        showToast('安装自检状态查询失败');
      }
      EasyLoading.dismiss();

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
    SocketMessageManager.instance
        .sendMessage(SelfTestStatusGetReqModel().commandFrame);
  }

  /// 自检信息
  String get selfCheckInfo {
    var text = '';

    if (model != null) {
      text += '唯一性编码状态: ${(model!.state & flag1) != 0 ? '正常' : ' 异常'}\n\n';
      text += 'vin状态: ${(model!.state & flag2) != 0 ? '正常' : ' 异常'}\n\n';
      text += '速度信号状态: ${(model!.state & flag3) != 0 ? '正常' : ' 异常'}\n\n';
      text += '定位状态: ${(model!.state & flag4) != 0 ? '正常' : ' 异常'}\n\n';
      text += '开关量状态: ${(model!.state & flag5) != 0 ? '正常' : ' 异常'}\n\n';
    } else {
      text += '唯一性编码状态: \n\n';
      text += 'vin状态: \n\n';
      text += '速度信号状态: \n\n';
      text += '定位状态: \n\n';
      text += '开关量状态: \n\n';
    }

    return text;
  }
}
