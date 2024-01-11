import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:st/config/env_config.dart';

class EnvSettingLogic extends GetxController {
  bool isCustomEnv = false;
  final textEditingController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void onInit() {
    isCustomEnv = EnvConfig.env == Env.custom;

    textEditingController
      ..text = EnvConfig.getEnvCustomUrl()
      ..addListener(refreshText);
    super.onInit();
  }

  @override
  void onClose() {
    textEditingController
      ..removeListener(refreshText)
      ..dispose();
    focusNode.dispose();
    super.onClose();
  }

  void refreshText() {
    update();
  }

  Future<void> showNetworkActionSheet(BuildContext context) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: Text("切换网络环境".tr),
          message: Text("当前网络环境：${EnvConfig.env}\n*切换环境后请重启App*"),
          actions: <Widget>[
            CupertinoActionSheetAction(
              onPressed: () => setEnv(Env.pro),
              child: Text("正式".tr),
            ),
            CupertinoActionSheetAction(
              onPressed: () => setEnv(Env.pre),
              child: Text("预发布".tr),
            ),
            CupertinoActionSheetAction(
              onPressed: () => setEnv(Env.sandbox),
              child: Text("沙盒".tr),
            ),
            CupertinoActionSheetAction(
              onPressed: () => setEnv(Env.dev),
              child: const Text("开发"),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                isCustomEnv = true;
                update();
                Get.back();
              },
              child: Text("自定义".tr),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: Get.back,
            child: Text("取消".tr),
          ),
        );
      },
    );
  }

  void setEnv(Env env) {
    isCustomEnv = false;
    EnvConfig.setEnv(env);
    update();
    Get.back();
  }

  void saveCustomEnv() {
    EnvConfig.setEnvCustom(
      Env.custom,
      url: textEditingController.text,
    );
    focusNode.unfocus();
    update();
  }
}
