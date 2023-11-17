import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/constants/sp_keys.dart';
import 'package:st/services/sp_service/sp_service.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyWidget extends StatefulWidget {
  const PrivacyPolicyWidget({
    super.key,
    this.policyCallback,
    this.confirmCallback,
    this.cancelCallback,
  });

  //协议回调
  final Function(String)? policyCallback;

  //完成流程回调
  final VoidCallback? confirmCallback;

  //拒绝按钮的回调
  final VoidCallback? cancelCallback;

  static void showPrivacyPolicy() {
    final isAgree = SpService.getBool(SpKeys.isAgreePrivacyPolicy) ?? false;
    if (isAgree) return;
    Future.delayed(const Duration(seconds: 1), () {
      Get.dialog(const PrivacyPolicyWidget());
    });
  }

  @override
  State<PrivacyPolicyWidget> createState() => _PrivacyPolicyWidgetState();
}

class _PrivacyPolicyWidgetState extends State<PrivacyPolicyWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            width: 280,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 24, bottom: 24),
                  child: const Text(
                    "个人信息保护指引",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                    text: TextSpan(
                      text: '欢迎使用运维星应用！我们将通过',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        height: 1.25,
                      ),
                      children: [
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              launchUrl(Uri.parse('https://www.baidu.com/'));
                            },
                            child: const Text(
                              '《注册服务协议》',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 13,
                                height: 1.25,
                              ),
                            ),
                          ),
                        ),
                        const TextSpan(
                          text: '和',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              launchUrl(Uri.parse('https://www.baidu.com/'));
                            },
                            child: const Text(
                              '《隐私政策》',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 13,
                                height: 1.25,
                              ),
                            ),
                          ),
                        ),
                        const TextSpan(
                          text:
                              '\n帮助您了解我们收集、使用、存储和共享个人信息的情况，了解您的相关权利。\n\n为了保证您更好的体验，可能需要获取通知权限、蓝牙权限、存储权限、设备信息。当开启权限后方可使用相关功能。\n\n请仔细阅读，如您同意，请点击下方同意按钮以接受我们的服务。',
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 24,
                    bottom: 24,
                  ),
                  child: SizedBox(
                    height: 40,
                    width: 220,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      onPressed: _toConfirm,
                      child: const Text(
                        '同意',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _toConfirm() async {
    await SpService.setBool(SpKeys.isAgreePrivacyPolicy, true);

    widget.confirmCallback?.call();
    Get.back();

    // final pref = await SharedPreferences.getInstance();
    // bool isCheckOk = await pref.setBool(SP_PRIVACY_POLICY_CHECK, true);
    // if (isCheckOk) {
    //   if (widget.confirmCallback != null) {
    //     widget.confirmCallback!();
    //   }
    //   FlutterMethodChannel().initThirdSDK();
    //   Navigator.of(context).pop();
    // }
  }
}
