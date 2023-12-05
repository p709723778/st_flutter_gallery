import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/routes/app_pages.dart';

class BasicParameterGetPage extends StatelessWidget {
  const BasicParameterGetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '基本参数查询',
            style: TextStyle(fontSize: 16),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: ListTile.divideTiles(
            color: Colors.grey, // 分割线的颜色
            tiles: [
              ListTile(
                title: const Text('获取安装自检状态'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.toNamed(Routes.MINISTRY_MARK_SELF_TEST_STATUS_GET);
                },
              ),
              // ListTile(
              //   title: const Text('采集指定的数据记录文件'),
              //   trailing: const Icon(Icons.keyboard_arrow_right),
              //   onTap: () {
              //     Get.toNamed(Routes.MINISTRY_DATA_RECORD_FILE);
              //   },
              // ),
              // ListTile(
              //   title: const Text('平台IP端口查询'),
              //   trailing: const Icon(Icons.keyboard_arrow_right),
              //   onTap: () {
              //     Get.toNamed(Routes.MINISTRY_MARK_PLATFORM_IP_GET);
              //   },
              // ),
              // ListTile(
              //   title: const Text('平台电话号码查询'),
              //   trailing: const Icon(Icons.keyboard_arrow_right),
              //   onTap: () {
              //     Get.toNamed(Routes.MINISTRY_MARK_PHONE_NUMBER_GET);
              //   },
              // ),
              // ListTile(
              //   title: const Text('车辆参数信息查询'),
              //   trailing: const Icon(Icons.keyboard_arrow_right),
              //   onTap: () {
              //     Get.toNamed(Routes.MINISTRY_MARK_CAR_PARAMS_GET);
              //   },
              // ),
              // ListTile(
              //   title: const Text('记录仪生命周期状态查询'),
              //   trailing: const Icon(Icons.keyboard_arrow_right),
              //   onTap: () {
              //     Get.toNamed(Routes.MINISTRY_MARK_RECORDER_LIFE_CYCLE_GET);
              //   },
              // ),
              // ListTile(
              //   title: const Text('驾驶人IC卡写卡'),
              //   trailing: const Icon(Icons.keyboard_arrow_right),
              //   onTap: () {
              //     Get.toNamed(Routes.MINISTRY_MARK_DRIVER_IC_GET);
              //   },
              // ),
              // ListTile(
              //   title: const Text('视频URL地址查询（仅WIFI支持）'),
              //   trailing: const Icon(Icons.keyboard_arrow_right),
              //   onTap: () {
              //     Get.toNamed(Routes.MINISTRY_MARK_VIDEO_URL_GET);
              //   },
              // ),
              // ListTile(
              //   title: const Text('速度类型查询'),
              //   trailing: const Icon(Icons.keyboard_arrow_right),
              //   onTap: () {
              //     Get.toNamed(Routes.MINISTRY_MARK_SPEED_TYPE_GET);
              //   },
              // ),
            ],
          ).toList(),
        ),
      ),
    );
  }
}
