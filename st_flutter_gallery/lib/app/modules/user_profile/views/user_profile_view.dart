import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/user_profile/controllers/user_profile_controller.dart';
import 'package:st/app/themes/custom_theme_colors.dart';

class UserProfileView extends GetView<UserProfileController> {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<UserProfileController>(
        init: UserProfileController(),
        assignId: true,
        builder: (logic) {
          return Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                bottom: 25,
                child: Image.asset(
                  'assets/images/main/page_bottom_icon.png',
                  width: 195,
                  height: 51,
                ),
              ),
              Positioned(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        Image.asset('assets/images/main/profile_header_bg.png'),
                        Positioned(
                          left: 28,
                          top: 55,
                          child: Text(
                            '个人中心',
                            style: Get.theme.textTheme.bodyText1
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Positioned(
                          top: 109,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(64 / 2),
                              border: Border.all(color: Get.theme.primaryColor),
                            ),
                            width: 64,
                            height: 64,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(64 / 2),
                              child: CachedNetworkImage(
                                imageUrl: logic.currentUserInfo.avatar,
                                placeholder: (context, url) =>
                                    const Icon(Icons.person),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.person),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 188,
                          child: Text(
                            logic.currentUserInfo.code,
                            style: Get.theme.textTheme.bodyText1?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 254,
                left: 16,
                right: 16,
                child: loginBody(),
              ),
            ],
          );
        },
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
          height: 180,
          child: Padding(
            padding: const EdgeInsets.only(left: 22, right: 22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Center(
                    child: item('姓名', controller.currentUserInfo.name),
                  ),
                ),
                const Divider(
                  height: 0.5,
                ),
                Expanded(
                  child: Center(
                    child: item('所属部门', controller.currentUserInfo.deptName),
                  ),
                ),
                const Divider(
                  height: 0.5,
                ),
                Expanded(
                  child: Center(
                    child: item('职务', controller.currentUserInfo.gradeName),
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
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Get.theme.extension<CustomThemeColors>()?.dangerColor,
              ),
            ),
            onPressed: () {
              controller.logout();
            },
            child: const Text(
              "退出",
            ),
          ),
        ),
      ],
    );
  }

  Widget item(String title, String subTitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Get.theme.textTheme.bodyText2,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            subTitle,
            textAlign: TextAlign.right,
            style: Get.theme.textTheme.bodyText2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
