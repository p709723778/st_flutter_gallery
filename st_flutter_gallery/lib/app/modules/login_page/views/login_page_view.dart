import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/components/custom_appbar.dart';
import 'package:st/app/modules/login_page/controllers/login_page_controller.dart';

class LoginPageView extends GetView<LoginPageController> {
  const LoginPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.backgroundColor,
      primary: false, //该属性非常关键
      appBar: const EmptyAppBar(),
      resizeToAvoidBottomInset: false,
      body: Listener(
        onPointerDown: (e) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: 26,
              child: Image.asset(
                'assets/images/main/page_bottom_icon.png',
                width: 195,
                height: 51,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset('assets/images/main/login_header_bg.png'),
                    Positioned(
                      top: 106,
                      child: Image.asset(
                        'assets/images/main/app_logo.png',
                        width: 48,
                        height: 62,
                      ),
                    ),
                    Positioned(
                      top: 176,
                      child: Image.asset(
                        'assets/images/main/app_name_logo.png',
                        width: 189,
                        height: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              left: 16,
              right: 16,
              top: 285,
              child: loginBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget loginBody() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Get.theme.backgroundColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Get.theme.shadowColor,
                blurRadius: 8,
                spreadRadius: 7.5,
              ),
            ],
          ),
          // width: screenWidth,
          height: 120,
          child: Padding(
            padding: const EdgeInsets.only(left: 22, right: 22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Center(
                    child: TextField(
                      // autofocus: true,
                      controller: controller.accountTextEditingController,
                      focusNode: controller.accountFocusNode,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        //提示信息
                        hintText: "账号",
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 14,
                          minHeight: 15,
                        ),
                        //图标
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 28, right: 9),
                          child: Image.asset(
                            'assets/images/main/login_account.png',
                            width: 14,
                            height: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 0.5,
                ),
                Expanded(
                  child: Center(
                    child: GetBuilder<LoginPageController>(
                      assignId: true,
                      id: controller.obscureTextId,
                      builder: (logic) {
                        return TextField(
                          controller: controller.passWordTextEditingController,
                          focusNode: controller.passWordFocusNode,
                          obscureText: controller.obscureText,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            //提示信息
                            hintText: "密码",
                            prefixIconConstraints: const BoxConstraints(
                              minWidth: 13,
                              minHeight: 15,
                            ),
                            //图标
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.only(left: 28, right: 9),
                              child: Image.asset(
                                'assets/images/main/login_password.png',
                                width: 13,
                                height: 15,
                              ),
                            ),
                            suffixIconConstraints: const BoxConstraints(
                              minWidth: 14,
                              minHeight: 14,
                            ),
                            suffixIcon: IconButton(
                              padding: const EdgeInsets.only(left: 9, right: 9),
                              onPressed: () {
                                controller.obscureText =
                                    !controller.obscureText;
                              },
                              icon: Image.asset(
                                'assets/images/main/login_show_password.png',
                                width: 14,
                                height: 14,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              controller.userLogin();
            },
            child: const Text(
              "登录",
            ),
          ),
        ),
      ],
    );
  }
}
