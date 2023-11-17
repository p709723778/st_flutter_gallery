import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/models/recorder_life_cycle/recorder_life_cycle_get_resp_model.dart';
import 'package:st/app/modules/ministry_mark/recorder_life_cycle/recorder_life_cycle_set/recorder_life_cycle_set_logic.dart';

class RecorderLifeCycleSetPage extends StatelessWidget {
  const RecorderLifeCycleSetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<RecorderLifeCycleSetLogic>();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetBuilder<RecorderLifeCycleSetLogic>(
        init: logic,
        builder: (logic) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                '记录仪生命周期状态设置',
                style: TextStyle(fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: logic.done,
                  child: const Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                ),
              ],
              centerTitle: true,
            ),
            body: ListView(
              padding: EdgeInsets.zero,
              children: ListTile.divideTiles(
                color: Colors.grey, // 分割线的颜色
                tiles: LifeCycleState.values.map(
                  (e) => ListTile(
                    title: Text(
                      e.title,
                      style: const TextStyle(fontSize: 14),
                    ),
                    trailing: Radio(
                      value: e,
                      onChanged: logic.onChanged,
                      groupValue: logic.state,
                    ),
                    onTap: () {
                      logic.onChanged(e);
                    },
                  ),
                ),
              ).toList(),
            ),
          );
        },
      ),
    );
  }
}
