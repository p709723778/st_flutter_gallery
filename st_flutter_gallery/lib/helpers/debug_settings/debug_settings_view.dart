import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:let_log/let_log.dart';
import 'package:st/config/env_config.dart';
import 'package:st/helpers/debug_settings/debug_settings_binding.dart';
import 'package:st/helpers/debug_settings/debug_settings_logic.dart';

class DebugSettingsPage extends StatefulWidget {
  const DebugSettingsPage({super.key});

  static bool _isShown = false;

  static void show() {
    if (_isShown) return;
    if (!kDebugMode && EnvConfig.env == Env.pro) return;

    _isShown = true;
    Get.to(const DebugSettingsPage(), binding: DebugSettingsBinding())
        ?.then((value) => _isShown = false);
  }

  @override
  State<DebugSettingsPage> createState() => _DebugSettingsState();
}

class _DebugSettingsState extends State<DebugSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "调试面板".tr,
          style: const TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: GetBuilder<DebugSettingsLogic>(
        init: DebugSettingsLogic(),
        builder: (logic) {
          return ListView(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 16,
            ),
            children: [
              // Container(
              //   padding: const EdgeInsets.symmetric(vertical: 4),
              //   decoration: BoxDecoration(
              //     color: Get.theme.colorScheme.background,
              //     borderRadius: BorderRadius.circular(8),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Get.theme.shadowColor,
              //         blurRadius: 7.5,
              //       ),
              //     ],
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       ListTile(
              //         title: Text(
              //           '环境切换设置(${EnvConfig.env.title})',
              //           style: const TextStyle(fontSize: 14),
              //         ),
              //         leading: Icon(
              //           CupertinoIcons.arrow_right_arrow_left_square_fill,
              //           color: Get.theme.primaryColor,
              //         ),
              //         trailing: Icon(
              //           Icons.keyboard_arrow_right,
              //           color: Get.theme.primaryColor,
              //         ),
              //         onTap: () async {
              //           await Get.to(
              //             const EnvSettingPage(),
              //             binding: EnvSettingBinding(),
              //           );
              //           logic.update();
              //         },
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 14),
              // Container(
              //   padding: const EdgeInsets.symmetric(vertical: 4),
              //   decoration: BoxDecoration(
              //     color: Get.theme.colorScheme.background,
              //     borderRadius: BorderRadius.circular(8),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Get.theme.shadowColor,
              //         blurRadius: 7.5,
              //       ),
              //     ],
              //   ),
              //   child: ListTile(
              //     title: const Text(
              //       '代理设置',
              //       style: TextStyle(fontSize: 14),
              //     ),
              //     leading: Icon(
              //       Icons.pan_tool_rounded,
              //       color: Get.theme.primaryColor,
              //     ),
              //     trailing: Icon(
              //       Icons.keyboard_arrow_right,
              //       color: Get.theme.primaryColor,
              //     ),
              //     onTap: () {
              //       Get.to(
              //         const ProxySettingPage(),
              //         binding: ProxySettingBinding(),
              //       );
              //     },
              //   ),
              // ),
              // const SizedBox(height: 14),
              // Container(
              //   padding: const EdgeInsets.symmetric(vertical: 4),
              //   decoration: BoxDecoration(
              //     color: Get.theme.colorScheme.background,
              //     borderRadius: BorderRadius.circular(8),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Get.theme.shadowColor,
              //         blurRadius: 7.5,
              //       ),
              //     ],
              //   ),
              //   child: ListTile(
              //     title: const Text(
              //       '使用 HTTPS',
              //       style: TextStyle(fontSize: 14),
              //     ),
              //     leading: Icon(
              //       Icons.https,
              //       color: Get.theme.primaryColor,
              //     ),
              //     trailing: ValueListenableBuilder<bool>(
              //       valueListenable: logic.useHttps,
              //       builder: (context, useHttps, _) {
              //         return Switch(
              //           value: useHttps,
              //           onChanged: (value) async {
              //             await logic.setUseHttps(value);
              //           },
              //         );
              //       },
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 14),
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
                child: ListTile(
                  title: const Text(
                    '清空 SharedPreferences',
                    style: TextStyle(fontSize: 14),
                  ),
                  leading: Icon(
                    Icons.cleaning_services,
                    color: Get.theme.primaryColor,
                  ),
                  onTap: () {
                    logic.clearSharedPreferences();
                  },
                ),
              ),
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
                child: ListTile(
                  title: const Text(
                    '查看日志',
                    style: TextStyle(fontSize: 14),
                  ),
                  leading: Icon(
                    Icons.text_snippet,
                    color: Get.theme.primaryColor,
                  ),
                  onTap: () {
                    Get.to(const Logger());
                  },
                ),
              ),
              // const SizedBox(height: 14),
              // Container(
              //   padding: const EdgeInsets.symmetric(vertical: 4),
              //   decoration: BoxDecoration(
              //     color: Get.theme.colorScheme.background,
              //     borderRadius: BorderRadius.circular(8),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Get.theme.shadowColor,
              //         blurRadius: 7.5,
              //       ),
              //     ],
              //   ),
              //   child: ListTile(
              //     title: const Text(
              //       '开启UME调试工具',
              //       style: TextStyle(fontSize: 14),
              //     ),
              //     leading: Icon(
              //       CupertinoIcons.ant_fill,
              //       color: Get.theme.primaryColor,
              //     ),
              //     trailing: ValueListenableBuilder<bool>(
              //       valueListenable: EnvConfig.isEnableUME,
              //       builder: (context, useHttps, _) {
              //         return Switch(
              //           value: useHttps,
              //           onChanged: (value) async {
              //             EnvConfig.isEnableUME.value =
              //                 !EnvConfig.isEnableUME.value;
              //           },
              //         );
              //       },
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 14),
              // Container(
              //   padding: const EdgeInsets.symmetric(vertical: 4),
              //   decoration: BoxDecoration(
              //     color: Get.theme.colorScheme.background,
              //     borderRadius: BorderRadius.circular(8),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Get.theme.shadowColor,
              //         blurRadius: 7.5,
              //       ),
              //     ],
              //   ),
              //   child: ListTile(
              //     title: const Text(
              //       '开启哀悼置灰',
              //       style: TextStyle(fontSize: 14),
              //     ),
              //     leading: Icon(
              //       Icons.sentiment_very_dissatisfied,
              //       color: Get.theme.primaryColor,
              //     ),
              //     trailing: ValueListenableBuilder<bool>(
              //       valueListenable: logic.lamentGrey,
              //       builder: (context, useHttps, _) {
              //         return Switch(
              //           value: useHttps,
              //           onChanged: (value) async {
              //             await logic.setLamentGrey(value);
              //           },
              //         );
              //       },
              //     ),
              //   ),
              // ),
            ],
          );
        },
      ),
    );
  }
}
