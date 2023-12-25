import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/constants/sp_keys.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/modules/link_mode/link_mode_select/link_mode_select_logic.dart';
import 'package:st/app/modules/login/user_login_view.dart';
import 'package:st/app/routes/app_pages.dart';
import 'package:st/common/global.dart';
import 'package:st/services/sp_service/sp_service.dart';

class LinkModeSelectPage extends StatefulWidget {
  const LinkModeSelectPage({super.key});

  @override
  State<LinkModeSelectPage> createState() => _LinkModeSelectPageState();
}

class _LinkModeSelectPageState extends State<LinkModeSelectPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '连接方式',
            style: TextStyle(fontSize: 16),
          ),
          centerTitle: true,
        ),
        body: GetBuilder<LinkModeSelectLogic>(
          init: LinkModeSelectLogic(),
          builder: (logic) {
            return ListView(
              children: ListTile.divideTiles(
                color: Colors.grey, // 分割线的颜色
                tiles: [
                  ListTile(
                    leading: const Icon(Icons.wifi),
                    title: const Text(
                      'WIFI连接 ',
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '(请连接设备热点WIFI)',
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ),
                        Icon(Icons.keyboard_arrow_right),
                      ],
                    ),
                    onTap: () {
                      Get.toNamed(Routes.LINK_MODEL_WIFI);
                    },
                  ),
                  if (GetPlatform.isAndroid)
                    ListTile(
                      leading: const Icon(Icons.bluetooth),
                      title: RichText(
                        text: const TextSpan(
                          text: '蓝牙连接',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          children: [
                            TextSpan(
                              text: '(请使用手机系统蓝牙进行配对后进行操作)',
                              style: TextStyle(fontSize: 16, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        Get.toNamed(Routes.BLUETOOTH_SCAN_CLASSIC_SERVER_PAGE);
                      },
                    ),
                  ListTile(
                    leading: const Icon(Icons.link_sharp),
                    title: const Text(
                      '当前连接方式为: ',
                      style: TextStyle(fontSize: 14),
                    ),
                    trailing: Text(
                      SocketMessageManager.instance.linkType.title,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text(
                      '版本号: ',
                      style: TextStyle(fontSize: 14),
                    ),
                    trailing: Text(
                      '${Global.packageInfo?.version}_${Global.packageInfo?.buildNumber}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  // if (GetPlatform.isAndroid)
                  //   ListTile(
                  //     leading: const Icon(Icons.bluetooth),
                  //     title: const Text(
                  //       '蓝牙连接客户端模式(Beta)',
                  //       style: TextStyle(fontSize: 16),
                  //     ),
                  //     trailing: const Icon(Icons.keyboard_arrow_right),
                  //     onTap: () {
                  //       Get.toNamed(Routes.BLUETOOTH_SCAN_CLASSIC_PAGE);
                  //     },
                  //   ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text(
                      '退出登录',
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () async {
                      await SpService.setString(SpKeys.passWord, '');
                      unawaited(Get.offAll(const UserLoginPage()));
                    },
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
