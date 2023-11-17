import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/apn_4g/apn_4g_set/apn_4g_set_logic.dart';

class Apn4gSetPage extends StatelessWidget {
  const Apn4gSetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<Apn4gSetLogic>();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '4G的APN域名设置',
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
          children: ListTile.divideTiles(
            color: Colors.grey, // 分割线的颜色
            tiles: [
              TextField(
                maxLength: 23,
                controller: logic.controller1,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'APN域名',
                  hintText: "请输入APN域名",
                  border: OutlineInputBorder(
                    ///设置边框四个角的弧度
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ],
          ).toList(),
        ),
      ),
    );
  }
}
