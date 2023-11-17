import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/models/apn_4g/apn_4g_get_req_model.dart';
import 'package:st/app/models/apn_4g/apn_4g_get_resp_model.dart';
import 'package:st/app/models/apn_4g/apn_4g_set_req_model.dart';
import 'package:st/app/models/apn_4g/apn_4g_set_resp_model.dart';
import 'package:st/extension/string_extension.dart';

class Apn4gSetLogic extends GetxController {
  final TextEditingController controller1 = TextEditingController();

  late StreamSubscription _streamSubscription;

  @override
  void onInit() {
    _streamSubscription =
        SocketMessageManager.instance.on<Apn4gGetRespModel>().listen((event) {
      EasyLoading.dismiss();

      if (event.apnDomain.hasValue) {
        showToast('APN查询成功');
        controller1.text = event.apnDomain;
        update();
      } else {
        showToast('APN查询失败');
      }
    });

    _streamSubscription =
        SocketMessageManager.instance.on<Apn4gSetRespModel>().listen((event) {
      EasyLoading.dismiss();
      if (event.result == 0) {
        showToast('APN设置成功');
      } else {
        showToast('APN设置失败');
      }
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
    final model = Apn4gGetReqModel(dataBytes: []);
    SocketMessageManager.instance.sendMessage(model.commandFrame);
  }

  void done() {
    final apnDomain = controller1.text;

    if (apnDomain.isEmpty) {
      showToast('请输入APN域名');
      return;
    }
    if (apnDomain.length > 23) {
      showToast('APN域名最多23位');
      return;
    }

    final apnDomainBytes = utf8.encode(apnDomain);

    final apnDomainLen = ByteData(1)..setUint8(0, apnDomain.length);

    final data = [
      ...apnDomainLen.buffer.asUint8List(),
      ...apnDomainBytes,
    ];

    final model = Apn4gSetReqModel(
      dataBytes: data,
      // dataLength: dataLength,
    );
    SocketMessageManager.instance.sendMessage(model.commandFrame);
  }
}
