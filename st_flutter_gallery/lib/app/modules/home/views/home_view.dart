import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_life_state/flutter_life_state.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/home/controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends BaseLifeState with AutomaticKeepAliveClientMixin {
  HomeController get controller => Get.find<HomeController>();

  @override
  void onResumed() {
    controller.getJobNumbers();
    super.onResumed();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnimatedTheme(
      duration: const Duration(milliseconds: 300),
      data: Theme.of(context),
      child: GetBuilder<HomeController>(
        assignId: true,
        init: HomeController(context: context),
        builder: (logic) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: GetBuilder<HomeController>(
              builder: (logic) {
                return Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: 375 / 227,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                stops: [0.0, 1.0],
                                colors: [
                                  Color(0xFFC7CCDF),
                                  Color(0xFFE6E8F0),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 30,
                          top: 54,
                          child: Text(
                            '矿用智能打钻管理助手',
                            style: Get.theme.textTheme.bodyText1
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Positioned(
                          left: 11,
                          top: 100,
                          right: 7,
                          bottom: 2,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                left: 6,
                                right: 6,
                                child: Image.asset(
                                  'assets/images/main/home_group_job_numbers.png',
                                  fit: BoxFit.fitWidth,
                                  height: 124,
                                ),
                              ),
                              Positioned.fill(
                                child: GetBuilder<HomeController>(
                                  id: HomeController.numbersID,
                                  builder: (logic) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              logic.jobNumberModel.overCount!
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              '已完成钻孔',
                                              style:
                                                  Get.theme.textTheme.caption,
                                            ),
                                          ],
                                        ),
                                        const VerticalDivider(
                                          indent: 45,
                                          endIndent: 45,
                                          color: Color(0xFF474984),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              logic.jobNumberModel.conducting!
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              '作业中钻孔',
                                              style:
                                                  Get.theme.textTheme.caption,
                                            ),
                                          ],
                                        ),
                                        const VerticalDivider(
                                          indent: 45,
                                          endIndent: 45,
                                          color: Color(0xFF474984),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              logic.jobNumberModel.repairCount!
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              '补录作业数',
                                              style:
                                                  Get.theme.textTheme.caption,
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  top: 8,
                                  bottom: 13,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 218,
                                      padding: const EdgeInsets.only(
                                        left: 14,
                                        right: 14,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Get.theme.backgroundColor,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Get.theme.shadowColor,
                                            blurRadius: 8,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 20,
                                            ),
                                            child: Text(
                                              '业务操作',
                                              style: Get
                                                  .theme.textTheme.bodyText2
                                                  ?.copyWith(fontSize: 17),
                                            ),
                                          ),
                                          const SizedBox(height: 21),
                                          Divider(
                                            height: 1,
                                            color: Get.theme.dividerColor,
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  actionButton(
                                                    title: '开始作业',
                                                    imagePath:
                                                        'assets/images/main/start_job_action.png',
                                                    onTap: () => controller
                                                        .startJobAction(),
                                                  ),
                                                  actionButton(
                                                    title: '作业补录',
                                                    imagePath:
                                                        'assets/images/main/replenishment_job_action.png',
                                                    onTap: () => controller
                                                        .replenishmentJobAction(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  top: 8,
                                  bottom: 13,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 223,
                                      padding: const EdgeInsets.only(
                                        left: 14,
                                        right: 14,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Get.theme.backgroundColor,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Get.theme.shadowColor,
                                            blurRadius: 8,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 20,
                                            ),
                                            child: Text(
                                              '我的作业',
                                              style: Get
                                                  .theme.textTheme.bodyText2
                                                  ?.copyWith(fontSize: 17),
                                            ),
                                          ),
                                          const SizedBox(height: 21),
                                          Divider(
                                            height: 1,
                                            color: Get.theme.dividerColor,
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  actionButton(
                                                    title: '已完成作业',
                                                    imagePath:
                                                        'assets/images/main/completed_job_action.png',
                                                    onTap: () => controller
                                                        .completedJobAction(),
                                                  ),
                                                  actionButton(
                                                    title: '进行中作业',
                                                    imagePath:
                                                        'assets/images/main/underway_job_action.png',
                                                    onTap: () => controller
                                                        .underwayJobAction(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget actionButton({
    required String title,
    required String imagePath,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            iconSize: 54,
            padding: EdgeInsets.zero,
            onPressed: null,
            icon: Image.asset(
              imagePath,
              width: 54,
              height: 54,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(fontSize: 15, color: Color(0xFF696C78)),
          ),
        ],
      ),
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
        Text(
          subTitle,
          style: Get.theme.textTheme.bodyText2,
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
