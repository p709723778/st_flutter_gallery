import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/platform_ip/platform_ip_set/platform_ip_set_logic.dart';
import 'package:st/utils/text_input_formatter/text_input_formatter_util.dart';

class PlatformIpSetPage extends StatelessWidget {
  const PlatformIpSetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<PlatformIpSetLogic>();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '平台IP设置',
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
          padding: const EdgeInsets.all(10),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    controller: logic.controller1,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [TextInputFormatterUtil.ipAddress],
                    decoration: const InputDecoration(
                      labelText: 'TCP1',
                      hintText: "请输入TCP1",
                      hintStyle: TextStyle(fontSize: 12),
                      labelStyle: TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                        ///设置边框四个角的弧度
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: logic.controllerPort1,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      labelText: '端口号',
                      hintText: "请输入端口号",
                      hintStyle: TextStyle(fontSize: 12),
                      labelStyle: TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                        ///设置边框四个角的弧度
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    controller: logic.controller2,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [TextInputFormatterUtil.ipAddress],
                    decoration: const InputDecoration(
                      labelText: 'TCP2',
                      hintText: "请输入TCP2",
                      hintStyle: TextStyle(fontSize: 12),
                      labelStyle: TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                        ///设置边框四个角的弧度
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: logic.controllerPort2,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      labelText: '端口号',
                      hintText: "请输入端口号",
                      hintStyle: TextStyle(fontSize: 12),
                      labelStyle: TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                        ///设置边框四个角的弧度
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    controller: logic.controller3,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [TextInputFormatterUtil.ipAddress],
                    decoration: const InputDecoration(
                      labelText: 'TCP3',
                      hintText: "请输入TCP3",
                      hintStyle: TextStyle(fontSize: 12),
                      labelStyle: TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                        ///设置边框四个角的弧度
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: logic.controllerPort3,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      labelText: '端口号',
                      hintText: "请输入端口号",
                      hintStyle: TextStyle(fontSize: 12),
                      labelStyle: TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                        ///设置边框四个角的弧度
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
