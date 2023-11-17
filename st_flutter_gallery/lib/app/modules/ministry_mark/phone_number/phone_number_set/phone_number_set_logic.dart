import 'dart:async';
import 'dart:typed_data';

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
import 'package:st/utils/encrypt/sm4_ebc.dart';

const int z1 = 0x01;
const int z2 = 0x02;
const int z3 = 0x04;
const int z4 = 0x08;
const int z5 = 0x10;
const int z6 = 0x20;
const int z7 = 0x40;
const int z8 = 0x80;

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

    const data = 'Hello! SM-CRYPTO @greenking19';

    Sm4EBC.encrypt(data);
    search();
    var value = 0;
    value |= z1;
    value |= z2;
    // value |= z3;
    // value |= z4;
    // value |= z5;
    // value |= z6;
    // value |= z7;
    value |= z8;

    final data16 = Uint16List.fromList([value]);
    super.onInit();
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
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
