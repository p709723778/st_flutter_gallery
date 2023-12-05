import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/text_commands/text_commands_logic.dart';

class TextCommandsPage extends StatelessWidget {
  const TextCommandsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<TextCommandsLogic>();

    return GetBuilder<TextCommandsLogic>(
      init: logic,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                '文本指令',
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
              children: [
                const SizedBox(height: 20),
                TextField(
                  controller: logic.textEditingController,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    labelText: '文本指令',
                    hintText: "请输入文本指令",
                    hintStyle: TextStyle(fontSize: 12),
                    labelStyle: TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                      ///设置边框四个角的弧度
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  subtitle: Text(logic.textCommands),
                  onTap: logic.copy,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
