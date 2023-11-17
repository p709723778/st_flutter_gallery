import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/models/recorder_test/recorder_test_set_req_model.dart';
import 'package:st/app/models/recorder_test/recorder_test_set_resp_model.dart';

class RecorderTestLogic extends GetxController {
  /// 是否记录仪测试中
  bool isTesting = false;

  /// 收到的测试数据
  final List<RecorderTestSetRespModel> testRecordList = [];

  final TextEditingController textEditingController = TextEditingController();

  late StreamSubscription<RecorderTestSetRespModel> _streamSubscription;

  Timer? timer;

  @override
  void onInit() {
    _streamSubscription = SocketMessageManager.instance
        .on<RecorderTestSetRespModel>()
        .listen((event) {
      isTesting = true;
      testRecordList.add(event);
      update();
    });
    super.onInit();
  }

  @override
  void onClose() {
    stopTest();

    timer?.cancel();
    _streamSubscription.cancel();

    textEditingController.dispose();
    super.onClose();
  }

  void startTest() {
    if (textEditingController.text.isEmpty) {
      showToast('请输入持续发送时间');
      return;
    }
    final seconds = int.parse(textEditingController.text);
    if (seconds > 0) {
      timer = Timer.periodic(Duration(seconds: seconds), (timer) {
        final dataLengthByteData = ByteData(2)..setUint16(0, seconds);

        final dataLengthU8List = dataLengthByteData.buffer.asUint8List();

        final model = RecorderTestSetReqModel(
          dataBytes: dataLengthU8List,
        );

        SocketMessageManager.instance.sendMessage(model.commandFrame);
      });
    }

    isTesting = true;
    update();
  }

  void stopTest() {
    isTesting = false;
    timer?.cancel();
    update();

    var number = 0;
    if (textEditingController.text.isNotEmpty) {
      number = int.parse(textEditingController.text);
    }

    final dataLengthByteData = ByteData(2)..setUint16(0, number);

    final dataLengthU8List = dataLengthByteData.buffer.asUint8List();

    final model = RecorderTestSetReqModel(
      dataBytes: dataLengthU8List,
      commandType: RecorderTestSetReqModel.commandTypeEnd,
    );

    SocketMessageManager.instance.sendMessage(model.commandFrame);
  }
}
