import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:st/app/models/recorder_test/recorder_test_set_resp_model.dart';
import 'package:st/app/modules/ministry_mark/recorder_test/recorder_test_logic.dart';

class RecorderTestPage extends StatelessWidget {
  const RecorderTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<RecorderTestLogic>();

    return GetBuilder<RecorderTestLogic>(
      init: logic,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                '记录仪测试',
                style: TextStyle(fontSize: 16),
              ),
              centerTitle: true,
              actions: [
                if (logic.isTesting)
                  TextButton(
                    onPressed: logic.stopTest,
                    child: const Icon(
                      Icons.stop_circle_outlined,
                      color: Colors.red,
                    ),
                  )
                else
                  TextButton(
                    onPressed: logic.startTest,
                    child: const Icon(
                      Icons.not_started_outlined,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
            body: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: logic.textEditingController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: '定位数据持续发送时间(秒)',
                      hintText: "请输入定位数据持续发送时间(秒)",
                      border: OutlineInputBorder(
                        ///设置边框四个角的弧度
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  children: ListTile.divideTiles(
                    color: Colors.grey, // 分割线的颜色
                    tiles: logic.testRecordList.map(item).toList(),
                  ).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget item(RecorderTestSetRespModel model) {
    return ListTile(
      title: Text('时间 ${model.time}'),
      subtitle: Column(
        children: [
          Text('GGA 数据 ${model.ggaData}'),
          Text('RMC 数据 ${model.rmcData}'),
        ],
      ),
    );
  }
}
