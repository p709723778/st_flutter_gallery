import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/platform_ip/platform_ip_get/platform_ip_get_logic.dart';

class PlatformIpGetPage extends StatelessWidget {
  const PlatformIpGetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<PlatformIpGetLogic>();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '平台IP端口查询',
            style: TextStyle(fontSize: 16),
          ),
          centerTitle: true,
        ),
        body: GetBuilder<PlatformIpGetLogic>(
          init: logic,
          builder: (logic) {
            return ListView(
              children: ListTile.divideTiles(
                color: Colors.grey, // 分割线的颜色
                tiles: [
                  ListTile(
                    title: const Text(
                      '端口信息:',
                    ),
                    subtitle: Text(
                      logic.platformIpGetRespModel?.tcpInfo ?? '',
                    ),
                  ),
                ],
              ).toList(),
            );
          },
        ),
      ),
    );
  }
}
