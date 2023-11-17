import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/phone_number/phone_number_get/phone_number_get_logic.dart';

class PhoneNumberGetPage extends StatelessWidget {
  const PhoneNumberGetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<PhoneNumberGetLogic>();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '平台电话号码查询',
            style: TextStyle(fontSize: 16),
          ),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: ListTile.divideTiles(
            color: Colors.grey, // 分割线的颜色
            tiles: [
              TextField(
                controller: logic.controller1,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: '手机号码',
                  hintText: "请输入手机号码",
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
