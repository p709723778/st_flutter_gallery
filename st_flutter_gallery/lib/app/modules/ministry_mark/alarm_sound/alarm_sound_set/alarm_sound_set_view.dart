import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/alarm_sound/alarm_sound_set/alarm_sound_set_logic.dart';

class AlarmSoundSetPage extends StatelessWidget {
  const AlarmSoundSetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<AlarmSoundSetLogic>();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetBuilder<AlarmSoundSetLogic>(
          init: logic,
          builder: (logic) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  '主动安全报警声音设置',
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
                padding: const EdgeInsets.all(20),
                children: [
                  ListTile(
                    title: const Text('报警开关'),
                    trailing: CupertinoSwitch(
                      // 当前 switch 的开关
                      value: logic.isOpen,
                      activeColor: Colors.blue,
                      // 点击或者拖拽事件
                      onChanged: logic.onChanged,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            );
          }),
    );
  }
}
