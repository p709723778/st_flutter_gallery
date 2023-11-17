import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/models/phone_number/phone_number_get_req_model.dart';
import 'package:st/app/models/phone_number/phone_number_get_resp_model.dart';
import 'package:st/extension/string_extension.dart';

class PhoneNumberGetLogic extends GetxController {
  final TextEditingController controller1 = TextEditingController();

  late StreamSubscription<PhoneNumberGetRespModel> _streamSubscription;

  @override
  void onInit() {
    _streamSubscription = SocketMessageManager.instance
        .on<PhoneNumberGetRespModel>()
        .listen((event) {
      EasyLoading.dismiss();

      if (event.phoneNumber.hasValue) {
        showToast('手机号码查询成功');
        controller1.text = event.phoneNumber.substring(0, 11);
        update();
      } else {
        showToast('手机号码查询失败');
      }
    });

    done();
    super.onInit();
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
    super.onClose();
  }

  void done() {
    final model = PhoneNumberGetReqModel(dataBytes: []);
    SocketMessageManager.instance.sendMessage(model.commandFrame);
  }
}
