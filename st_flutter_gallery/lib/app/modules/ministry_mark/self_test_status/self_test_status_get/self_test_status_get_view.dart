import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/self_test_status/self_test_status_get/self_test_status_get_logic.dart';

class SelfTestStatusGetPage extends StatelessWidget {
  const SelfTestStatusGetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<SelfTestStatusGetLogic>();

    return GetBuilder<SelfTestStatusGetLogic>(
      init: logic,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                '安装自检状态查询',
                style: TextStyle(fontSize: 16),
              ),
              centerTitle: true,
            ),
            body: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                ListTile(
                  title: Text(
                    logic.selfCheckInfo,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
