import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/link_mode/wifi/wifi_logic.dart';
import 'package:st/utils/reg_exps/reg_exps.dart';

class WifiPage extends StatelessWidget {
  const WifiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<WifiLogic>();

    return GetBuilder<WifiLogic>(
      init: logic,
      builder: (logic) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'WIFI方式连接',
              style: TextStyle(fontSize: 16),
            ),
            centerTitle: true,
            actions: [
              if (logic.isConnect)
                TextButton(
                  onPressed: logic.disconnect,
                  child: const Icon(
                    Icons.wifi,
                    color: Colors.green,
                  ),
                )
              else
                TextButton(
                  onPressed: logic.connect,
                  child: const Icon(
                    Icons.wifi_off,
                    color: Colors.red,
                  ),
                ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              TextField(
                controller: logic.serverIpController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(regExp_IpAddress)),
                ],
                decoration: InputDecoration(
                  labelText: '服务器IP',
                  hintText: "请输入服务器IP(例如:${logic.serverIpController.text})",
                  border: const OutlineInputBorder(
                    ///设置边框四个角的弧度
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: logic.serverPortController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: '服务器端口',
                  hintText: "请输入服务器端口(例如:${logic.serverPortController.text})",
                  border: const OutlineInputBorder(
                    ///设置边框四个角的弧度
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
