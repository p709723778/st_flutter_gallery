import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/login/user_login_logic.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({super.key});

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: GetBuilder<UserLoginLogic>(
          init: UserLoginLogic(),
          builder: (logic) {
            return ListView(
              children: [
                const SizedBox(height: 40),
                Image.asset(
                  'assets/images/launch_bg/splash.png',
                  width: 200,
                  height: 161,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          focusNode: logic.userNameFocusNode,
                          style: const TextStyle(fontSize: 14),
                          controller: logic.userNameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.perm_identity_outlined),
                            hintText: "请输入用户名",
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.zero,
                          ),
                          onTap: () {
                            logic.fixFocusNode(logic.userNameFocusNode);
                          },
                        ),
                        const Divider(
                          height: 2,
                        ),
                        GetBuilder<UserLoginLogic>(
                          id: UserLoginLogic.LOGIN_OBSCURE_TEXT_ID,
                          builder: (logic) {
                            return TextField(
                              obscureText: logic.obscureText,
                              focusNode: logic.passWordFocusNode,
                              style: const TextStyle(fontSize: 14),
                              controller: logic.passWordController,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  padding: const EdgeInsets.only(
                                    left: 9,
                                    right: 9,
                                  ),
                                  onPressed: () {
                                    logic.obscureText = !logic.obscureText;
                                  },
                                  icon: Image.asset(
                                    logic.obscureText
                                        ? 'assets/images/main/eye_hide.png'
                                        : 'assets/images/main/eye_show.png',
                                    width: 14,
                                    height: 14,
                                  ),
                                ),
                                hintText: "请输入密码",
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.zero,
                              ),
                              onTap: () {
                                logic.fixFocusNode(logic.passWordFocusNode);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 44,
                  margin: const EdgeInsets.all(16),
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      side: MaterialStateProperty.all(
                        const BorderSide(
                          //设置 界面效果
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onPressed: logic.login,
                    child: const Text(
                      '登          录',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
