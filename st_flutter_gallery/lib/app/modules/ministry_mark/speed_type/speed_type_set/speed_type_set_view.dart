import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/speed_type/speed_type_set/speed_type_set_logic.dart';

class SpeedTypeSetPage extends StatelessWidget {
  const SpeedTypeSetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<SpeedTypeSetLogic>();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetBuilder<SpeedTypeSetLogic>(
        init: logic,
        builder: (logic) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                '速度类型设置',
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
                tiles: SpeedType.values.map(
                  (e) => ListTile(
                    title: Text(
                      e.title,
                      style: const TextStyle(fontSize: 14),
                    ),
                    trailing: Radio(
                      value: e,
                      onChanged: logic.onChanged,
                      groupValue: logic.type,
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
