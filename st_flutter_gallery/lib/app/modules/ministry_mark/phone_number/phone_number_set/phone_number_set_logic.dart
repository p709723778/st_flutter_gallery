import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/models/phone_number/phone_number_get_req_model.dart';
import 'package:st/app/models/phone_number/phone_number_get_resp_model.dart';
import 'package:st/app/models/phone_number/phone_number_set_req_model.dart';
import 'package:st/app/models/phone_number/phone_number_set_resp_model.dart';
import 'package:st/extension/string_extension.dart';
import 'package:st/helpers/logger/logger_helper.dart';
import 'package:st/utils/bcd_data/bcd_data_util.dart';

class PhoneNumberSetLogic extends GetxController {
  final TextEditingController controller1 = TextEditingController();

  late StreamSubscription _streamSubscription;

  @override
  void onInit() {
    _streamSubscription = SocketMessageManager.instance
        .on<PhoneNumberGetRespModel>()
        .listen((event) {
      EasyLoading.dismiss();

      if (event.phoneNumber.hasValue) {
        showToast('手机号码查询成功');
        controller1.text = event.phoneNumber;
        update();
      } else {
        showToast('手机号码查询失败');
      }
    });

    _streamSubscription = SocketMessageManager.instance
        .on<PhoneNumberSetRespModel>()
        .listen((event) {
      EasyLoading.dismiss();
      if (event.result == 0) {
        showToast('手机号码设置成功');
      } else {
        showToast('手机号码设置失败');
      }
      update();
    });

    search();

    super.onInit();
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
    controller1.dispose();
    super.onClose();
  }

  void search() {
    final model = PhoneNumberGetReqModel(dataBytes: []);
    SocketMessageManager.instance.sendMessage(model.commandFrame);
  }

  void done() {
    final phoneNumber = controller1.text;

    if (phoneNumber.isEmpty || phoneNumber.length > 20) {
      showToast('请输入正确的手机号码');
      return;
    }

    final bcdBytes = BcdDataUtil.convertStringToBCD2(phoneNumber);
    logger.info("BCD码数据类型：$bcdBytes");

    final bytes = BcdDataUtil.convertBCDToBytes(bcdBytes, 10);
    logger.info("字节数据类型：$bytes");

    final model = PhoneNumberSetReqModel(dataBytes: bytes);
    SocketMessageManager.instance.sendMessage(model.commandFrame);
  }
}
