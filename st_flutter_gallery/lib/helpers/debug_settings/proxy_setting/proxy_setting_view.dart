import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/helpers/debug_settings/proxy_setting/proxy_setting_logic.dart';

class ProxySettingPage extends StatefulWidget {
  const ProxySettingPage({super.key});

  @override
  State<ProxySettingPage> createState() => _ProxySettingPageState();
}

class _ProxySettingPageState extends State<ProxySettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Http 代理设置".tr,
          style: const TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: GetBuilder<ProxySettingLogic>(
        init: ProxySettingLogic(),
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
                        '代理地址设置',
                        style: Get.theme.textTheme.bodyLarge
                            ?.copyWith(fontSize: 14),
                      ),
                      trailing: ValueListenableBuilder<bool>(
                        valueListenable: logic.useProxy,
                        builder: (context, useHttps, _) {
                          return Switch(
                            value: useHttps,
                            onChanged: (value) async {
                              await logic.setUseProxy(value);
                            },
                          );
                        },
                      ),
                    ),
                    if (logic.useProxy.value) ...[
                      const Divider(height: 0.5),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '例如1: 127.0.0.1:8080',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFBAC5DB),
                              ),
                            ),
                            TextField(
                              controller: logic.textEditingController,
                              focusNode: logic.focusNode,
                              decoration: InputDecoration(
                                hintText: '请输入代理地址',
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
                              onPressed: logic.saveProxyAddress,
                              child: const Text(
                                "确定",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
