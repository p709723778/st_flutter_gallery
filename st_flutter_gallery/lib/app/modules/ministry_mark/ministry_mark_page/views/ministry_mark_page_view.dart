import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/routes/app_pages.dart';
import 'package:st/config/env_config.dart';

class MinistryMarkPageView extends StatefulWidget {
  const MinistryMarkPageView({super.key});

  @override
  State<MinistryMarkPageView> createState() => _MinistryMarkPageViewState();
}

class _MinistryMarkPageViewState extends State<MinistryMarkPageView>
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
            '部标功能设置',
            style: TextStyle(fontSize: 16),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: ListTile.divideTiles(
            color: Colors.grey, // 分割线的颜色
            tiles: [
              ListTile(
                leading: const Icon(Icons.receipt_long_outlined),
                title: const Text('记录仪测试'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.toNamed(Routes.MINISTRY_MARK_RECORDER_TEST);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings_applications),
                title: const Text('基本参数设置'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.toNamed(
                    Routes.MINISTRY_MARK_BASIC_PARAMETER_SETTINGS_VIEW,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.content_paste_search),
                title: const Text('基本参数查询'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.toNamed(Routes.MINISTRY_MARK_BASIC_PARAMETER_GET_VIEW);
                },
              ),
              ListTile(
                leading: const Icon(Icons.dataset),
                title: const Text('数据摘要测试'),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Get.toNamed(Routes.MINISTRY_DATA_SUMMARY_TEST);
                },
              ),
            ],
          ).toList().sublist(0, EnvConfig.isBuildPackage ? 3 : 4),
        ),
      ),
    );
  }
}
