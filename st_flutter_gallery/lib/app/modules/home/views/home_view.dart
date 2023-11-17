import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/home/controllers/home_controller.dart';
import 'package:st/app/modules/home/views/grid_view_item.dart';
import 'package:st/app/modules/home/views/group_item.dart';
import 'package:st/app/routes/app_pages.dart';
import 'package:st/config/env_config.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Widget body = AnimatedTheme(
      duration: const Duration(milliseconds: 300),
      data: Theme.of(context),
      child: GetBuilder<HomeController>(
        assignId: true,
        init: HomeController(context: context),
        builder: (logic) {
          return Scaffold(
            appBar: AppBar(
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: Text(
                '主页'.tr,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            body: ListView(
              children: [
                Container(
                  // height: 150,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(70),
                      bottomRight: Radius.circular(70),
                    ),
                    gradient: LinearGradient(
                      end: Alignment.topLeft,
                      begin: Alignment.bottomRight,
                      colors: [
                        Colors.cyan,
                        Colors.deepPurpleAccent,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '基础入门               \nFlutter 和 Dart',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22,
                                    ),
                          ),
                          Image.asset(
                            'assets/images/main/hand.png',
                            width: 87 / 1.5,
                            height: 164 / 1.5,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/main/jiayou.png',
                            width: 422 / 10,
                            height: 1241 / 14,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 22),
                            child: Text(
                              '快速了解什么是Flutter和Dart,\n如何快速入门移动应用开发...',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 80,
                        width: 120,
                        decoration: const BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.dashboard,
                              color: Colors.white,
                              size: 35,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dart',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Colors.white),
                                ),
                                Text(
                                  '基础知识',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        width: 120,
                        decoration: const BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.tab_unselected_outlined,
                              color: Colors.white,
                              size: 35,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Flutter',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Colors.white),
                                ),
                                Text(
                                  'widget示例',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const GroupItem(
                  text: '常用组件',
                  padding: EdgeInsets.symmetric(horizontal: 12),
                ),
                SizedBox(
                  height: 140,
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: logic.gridViewDataSource.length,
                    padding: const EdgeInsets.all(12),
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, //横轴三个子widget
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      return GridViewItem(
                        commonWidgetModel: logic.gridViewDataSource[index],
                        itemCallBack: (model) {
                          Get.toNamed(Routes.COMPONENT_DETAIL_PAGE);
                        },
                      );
                    },
                  ),
                ),
                const GroupItem(
                  text: '札记',
                  padding: EdgeInsets.symmetric(horizontal: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
    if (EnvConfig.isLamentGrey) {
      body = ColorFiltered(
        colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.color),
        child: body,
      );
    }

    return body;
  }
}
