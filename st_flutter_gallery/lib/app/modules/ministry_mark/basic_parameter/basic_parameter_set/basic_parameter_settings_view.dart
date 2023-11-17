import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/routes/app_pages.dart';
import 'package:st/config/env_config.dart';

class BasicParameterSettingsPage extends StatelessWidget {
  const BasicParameterSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '基本参数设置',
            style: TextStyle(fontSize: 16),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: ListTile.divideTiles(
            color: Colors.grey, // 分割线的颜色
            tiles: [
              ListTile(
                title: const Text('算法标定设置'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.toNamed(Routes.MINISTRY_MARK_ALGORITHM_SETTING);
                },
              ),
              ListTile(
                title: const Text('BSD参数设置'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.toNamed(Routes.MINISTRY_MARK_BSD_PARAMS_SETTING);
                },
              ),
              ListTile(
                title: const Text('ADAS参数设置'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.toNamed(Routes.MINISTRY_MARK_ADAS_PARAMS_SETTING);
                },
              ),
              ListTile(
                title: const Text('DSM参数设置'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.toNamed(Routes.MINISTRY_MARK_DSM_PARAMS_SETTING);
                },
              ),
              ListTile(
                title: const Text('记录仪参数设置'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.toNamed(Routes.MINISTRY_MARK_RECORDER_PARAMS_SET);
                },
              ),
              ListTile(
                title: const Text('平台IP端口设置'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.toNamed(Routes.MINISTRY_MARK_PLATFORM_IP_SETTING);
                },
              ),
              ListTile(
                title: const Text('平台域名设置'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.toNamed(Routes.MINISTRY_MARK_PLATFORM_DOMAIN_NAME_SET);
                },
              ),
              ListTile(
                title: const Text('平台电话号码设置'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.toNamed(Routes.MINISTRY_MARK_PHONE_NUMBER_SETTING);
                },
              ),
              ListTile(
                title: const Text('驾驶人IC卡读卡'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.toNamed(Routes.MINISTRY_MARK_DRIVER_IC_SET);
                },
              ),
              ListTile(
                title: const Text('4G的APN域名设置'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.toNamed(Routes.MINISTRY_MARK_APN_4G_SET);
                },
              ),
              ListTile(
                title: const Text('主动安全报警声音设置'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.toNamed(Routes.MINISTRY_MARK_ALARM_SOUND_SETTING);
                },
              ),
              ListTile(
                title: const Text('记录仪生命周期状态设置'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.toNamed(Routes.MINISTRY_MARK_RECORDER_LIFE_CYCLE_SET);
                },
              ),
              ListTile(
                title: const Text('速度类型设置'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.toNamed(Routes.MINISTRY_MARK_SPEED_TYPE_SET);
                },
              ),
              ListTile(
                title: const Text('车辆参数信息设置'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.toNamed(Routes.MINISTRY_MARK_CAR_PARAMS_SET);
                },
              ),
            ],
          ).toList().sublist(0, EnvConfig.isBuildPackage ? 13 : 14),
        ),
      ),
    );
  }
}
