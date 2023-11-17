import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/models/alarm_sound/alarm_sound_get_req_model.dart';
import 'package:st/app/models/alarm_sound/alarm_sound_get_resp_model.dart';
import 'package:st/app/models/alarm_sound/alarm_sound_set_req_model.dart';
import 'package:st/app/models/alarm_sound/alarm_sound_set_resp_model.dart';

class AlarmSoundSetLogic extends GetxController {
  late StreamSubscription _streamSubscription;

  bool isOpen = false;

  @override
  void onInit() {
    _streamSubscription = SocketMessageManager.instance
        .on<AlarmSoundSetRespModel>()
        .listen((event) {
      EasyLoading.dismiss();
      if (event.result == 0) {
        showToast('主动安全报警声音设置成功');
      } else {
        showToast('主动安全报警声音设置失败');
      }
      update();
    });

    _streamSubscription = SocketMessageManager.instance
        .on<AlarmSoundGetRespModel>()
        .listen((event) {
      EasyLoading.dismiss();
      showToast('主动安全报警声音查询成功');
      isOpen = event.state == 1;
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

  void done() {
    AlarmSoundSetReqModel model;

    // 一个字节：
    // 0x1:开启
    // 0x2:关闭
    if (isOpen) {
      model = AlarmSoundSetReqModel(
        dataBytes: [1],
      );
    } else {
      model = AlarmSoundSetReqModel(
        dataBytes: [2],
      );
    }
    SocketMessageManager.instance.sendMessage(model.commandFrame);
  }

  void search() {
    final model = AlarmSoundGetReqModel(dataBytes: []);
    SocketMessageManager.instance
        .sendMessage(model.commandFrame, isToast: false);
    EasyLoading.show(
      status: '查询中...',
      maskType: EasyLoadingMaskType.black,
    );

    Future.delayed(const Duration(seconds: 3), EasyLoading.dismiss);
  }

  void onChanged(bool value) {
    isOpen = value;
    update();
  }
}
