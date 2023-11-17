import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/data_summary_test/data_summary_test_logic.dart';

class DataSummaryTestPage extends StatelessWidget {
  const DataSummaryTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<DataSummaryTestLogic>();

    return GetBuilder<DataSummaryTestLogic>(
      init: logic,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                '数据摘要测试',
                style: TextStyle(fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: logic.done,
                  child: const Icon(
                    Icons.not_started_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
              centerTitle: true,
            ),
            body: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                ListTile(
                  title: Text(
                    logic.recorderInfo,
                    style: const TextStyle(fontSize: 16),
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
