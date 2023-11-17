import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/models/recorder_life_cycle/recorder_life_cycle_get_req_model.dart';
import 'package:st/app/models/recorder_life_cycle/recorder_life_cycle_get_resp_model.dart';
import 'package:st/app/models/recorder_life_cycle/recorder_life_cycle_set_req_model.dart';
import 'package:st/app/models/recorder_life_cycle/recorder_life_cycle_set_resp_model.dart';

class RecorderLifeCycleSetLogic extends GetxController {
  LifeCycleState state = LifeCycleState.S_00H;

  late StreamSubscription _streamSubscription;

  @override
  void onInit() {
    state = LifeCycleState.S_00H;

    _streamSubscription = SocketMessageManager.instance
        .on<RecorderLifeCycleSetRespModel>()
        .listen((event) {
      EasyLoading.dismiss();
      if (event.result == 0) {
        showToast('记录仪生命周期状态设置成功');
      } else {
        showToast('记录仪生命周期状态设置失败');
      }
      update();
    });

    _streamSubscription = SocketMessageManager.instance
        .on<RecorderLifeCycleGetRespModel>()
        .listen((event) {
      state = LifeCycleState.fromString(event.state);
      EasyLoading.dismiss();
      showToast('记录仪生命周期状态查询成功');

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
        .sendMessage(RecorderLifeCycleGetReqModel().commandFrame);
  }

  void done() {
    SocketMessageManager.instance.sendMessage(
      RecorderLifeCycleSetReqModel(
        dataBytes: [state.value],
      ).commandFrame,
    );
  }

  void onChanged(LifeCycleState? value) {
    state = value ?? LifeCycleState.S_00H;
    update();
  }
}
