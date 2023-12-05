import 'dart:async';

import 'package:fast_gbk/fast_gbk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/models/text_commands/text_commands_get_req_model.dart';
import 'package:st/app/models/text_commands/text_commands_get_resp_model.dart';
import 'package:st/extension/string_extension.dart';

class TextCommandsLogic extends GetxController {
  final TextEditingController textEditingController = TextEditingController();

  late StreamSubscription _streamSubscription;

  String? textCommandsContent;

  @override
  void onInit() {
    _streamSubscription = SocketMessageManager.instance
        .on<TextCommandsGetRespModel>()
        .listen((event) {
      EasyLoading.dismiss();

      if (event.textCommands.hasValue) {
        showToast('文本指令设置成功');
        textCommandsContent = event.textCommands;
        update();
      } else {
        showToast('文本指令设置失败');
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    textEditingController.dispose();
    _streamSubscription.cancel();
    super.onClose();
  }

  String get textCommands {
    return textCommandsContent ?? '';
  }

  void copy() {
    if (textCommands.noValue) return;
    Clipboard.setData(ClipboardData(text: textCommands ?? ''));
    showToast('复制内容成功');
  }

  void done() {
    final textCommand = textEditingController.text;
    if (textCommand.noValue) {
      showToast('请输入文本指令');
      return;
    }

    final dataBytes = gbk.encode(textCommand);

    final model = TextCommandsGetReqModel(dataBytes: dataBytes);
    SocketMessageManager.instance.sendMessage(model.commandFrame);
  }
}
