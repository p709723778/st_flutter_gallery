import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/config/env_config.dart';
import 'package:st/helpers/debug_settings/env_setting/env_setting_logic.dart';

class EnvSettingPage extends StatefulWidget {
  const EnvSettingPage({super.key});

  @override
  State<EnvSettingPage> createState() => _EnvSettingPageState();
}

class _EnvSettingPageState extends State<EnvSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "环境切换设置".tr,
          style: const TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: GetBuilder<EnvSettingLogic>(
        init: EnvSettingLogic(),
        builder: (logic) {
          return ListView(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 16,
            ),
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.background,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Get.theme.shadowColor,
                      blurRadius: 7.5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        '环境切换(${EnvConfig.env.title})',
                        style: const TextStyle(fontSize: 18),
                      ),
                      leading: Icon(
                        CupertinoIcons.arrow_right_arrow_left_square_fill,
                        color: Get.theme.primaryColor,
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Get.theme.primaryColor,
                      ),
                      onTap: () async {
                        await logic.showNetworkActionSheet(context);
                      },
                    ),
                  ],
                ),
              ),
              if (logic.isCustomEnv) ...[
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: Get.theme.colorScheme.background,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Get.theme.shadowColor,
                        blurRadius: 7.5,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          '自定义环境地址',
                          style: Get.theme.textTheme.bodyLarge
                              ?.copyWith(fontSize: 14),
                        ),
                      ),
                      const Divider(height: 0.5),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '例如1:\n服务器域名是https://www.baidu.com/ \n就请输入: baidu.com\n例如2:\n服务器ip是http://127.0.0.1:8080/ \n就请输入: 127.0.0.1:8080',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFBAC5DB),
                              ),
                            ),
                            TextField(
                              controller: logic.textEditingController,
                              focusNode: logic.focusNode,
                              decoration: InputDecoration(
                                hintText: '请输入自定义域名地址',
                                suffixIcon: logic
                                        .textEditingController.text.isEmpty
                                    ? null
                                    : IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          color: Get.theme.primaryColor,
                                        ),
                                        onPressed: () {
                                          logic.textEditingController.clear();
                                          setState(() {});
                                        },
                                      ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            ElevatedButton(
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(104, 48),
                              ),
                              onPressed: logic.saveCustomEnv,
                              child: const Text(
                                "确定",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 14),
            ],
          );
        },
      ),
    );
  }
}
