import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/models/speed_type/speed_type_get_req_model.dart';
import 'package:st/app/models/speed_type/speed_type_get_resp_model.dart';
import 'package:st/app/models/speed_type/speed_type_set_req_model.dart';
import 'package:st/app/models/speed_type/speed_type_set_resp_model.dart';

enum SpeedType {
  gps(1, 'GPS速度'),
  electron(2, '电子速度');

  const SpeedType(this.value, this.title);

  final int value;

  final String title;

  static SpeedType fromString(int value) {
    return values.firstWhere(
      (v) => v.value == value,
      orElse: () => SpeedType.gps,
    );
  }
}

class SpeedTypeSetLogic extends GetxController {
  SpeedType type = SpeedType.gps;
  late StreamSubscription _streamSubscription;

  @override
  void onInit() {
    type = SpeedType.gps;

    _streamSubscription = SocketMessageManager.instance
        .on<SpeedTypeSetRespModel>()
        .listen((event) {
      EasyLoading.dismiss();
      if (event.result == 0) {
        showToast('速度类型设置成功');
      } else {
        showToast('速度类型设置失败');
      }
      update();
    });

    _streamSubscription = SocketMessageManager.instance
        .on<SpeedTypeGetRespModel>()
        .listen((event) {
      type = SpeedType.fromString(event.state);
      EasyLoading.dismiss();
      showToast('速度类型查询成功');

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
        .sendMessage(SpeedTypeGetReqModel().commandFrame);
  }

  void done() {
    // 一个字节：
    // 0x1：GPS速度
    // 0x2：电子速度

    SocketMessageManager.instance.sendMessage(
      SpeedTypeSetReqModel(
        dataBytes: [type.value],
      ).commandFrame,
    );
  }

  void onChanged(SpeedType? value) {
    type = value ?? SpeedType.gps;
    update();
  }
}
