import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/components/custom_appbar.dart';
import 'package:st/app/modules/jobs/completed_job/controllers/completed_job_controller.dart';
import 'package:st/app/modules/jobs/job_details/model/job_detail_push_parameters.dart';
import 'package:st/app/modules/jobs/jobs_enum.dart';
import 'package:st/app/modules/jobs/list_item/job_item.dart';
import 'package:st/app/routes/app_pages.dart';
import 'package:st/app/themes/custom_theme_colors.dart';

class CompletedJobView extends GetView<CompletedJobController> {
  const CompletedJobView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.backgroundColor,
      appBar: const CustomAppbar(
        title: '已完成作业',
      ),
      body: DefaultTabController(
        length: controller.tabs.length,
        child: Column(
          children: [
            SizedBox(
              height: 48,
              child: GetBuilder<CompletedJobController>(
                id: CompletedJobController.tabBarID,
                builder: (logic) {
                  return TabBar(
                    labelStyle: Get.theme.textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    unselectedLabelStyle:
                        Get.theme.textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    unselectedLabelColor: Get.theme.textTheme.bodyText2?.color,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor:
                        Get.theme.extension<CustomThemeColors>()?.dangerColor,
                    tabs: controller.tabs.map((e) {
                      return Tab(text: e);
                    }).toList(),
                  );
                },
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  GetBuilder<CompletedJobController>(
                    id: CompletedJobController.listIAutoD,
                    builder: (logic) {
                      return Container(
                        color: Get.theme
                            .extension<CustomThemeColors>()
                            ?.backgroundColor,
                        child: EasyRefresh(
                          clipBehavior: Clip.none,
                          controller: controller.easyRefreshControllerAuto,
                          header: ClassicHeader(
                            dragText: '拉动刷新'.tr,
                            armedText: '释放刷新'.tr,
                            readyText: '正在刷新...'.tr,
                            processingText: '正在刷新...'.tr,
                            processedText: '刷新完成'.tr,
                            noMoreText: '没有更多数据'.tr,
                            failedText: '刷新失败'.tr,
                            messageText: '最后一次更新在 %T'.tr,
                          ),
                          footer: ClassicFooter(
                            dragText: '拉动加载'.tr,
                            armedText: '释放加载'.tr,
                            readyText: '正在加载...'.tr,
                            processingText: '正在加载...'.tr,
                            processedText: '加载完成'.tr,
                            noMoreText: '没有更多数据'.tr,
                            failedText: '加载失败'.tr,
                            messageText: '最后一次更新在 %T'.tr,
                          ),
                          onRefresh: () async {
                            await controller.onRefreshAuto();
                          },
                          onLoad: () async {
                            await Future.delayed(const Duration(seconds: 2));

                            await controller.onLoadAuto();
                          },
                          child: ListView(
                            padding: const EdgeInsets.all(16),
                            children: controller.listAuto
                                .map(
                                  (e) => JobItem(
                                    type: JobActionType.completed,
                                    record: e,
                                    callBack: () {
                                      Get.toNamed(
                                        Routes.JOBS_JOB_DETAILS,
                                        arguments: JobDetailPushParameters(
                                          type: JobActionType.completed,
                                          record: e,
                                        ),
                                      );
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  GetBuilder<CompletedJobController>(
                    id: CompletedJobController.listID,
                    builder: (logic) {
                      return Container(
                        color: Get.theme
                            .extension<CustomThemeColors>()
                            ?.backgroundColor,
                        child: EasyRefresh(
                          clipBehavior: Clip.none,
                          controller: controller.easyRefreshController,
                          header: ClassicHeader(
                            dragText: '拉动刷新'.tr,
                            armedText: '释放刷新'.tr,
                            readyText: '正在刷新...'.tr,
                            processingText: '正在刷新...'.tr,
                            processedText: '刷新完成'.tr,
                            noMoreText: '没有更多数据'.tr,
                            failedText: '刷新失败'.tr,
                            messageText: '最后一次更新在 %T'.tr,
                          ),
                          footer: ClassicFooter(
                            dragText: '拉动加载'.tr,
                            armedText: '释放加载'.tr,
                            readyText: '正在加载...'.tr,
                            processingText: '正在加载...'.tr,
                            processedText: '加载完成'.tr,
                            noMoreText: '没有更多数据'.tr,
                            failedText: '加载失败'.tr,
                            messageText: '最后一次更新在 %T'.tr,
                          ),
                          onRefresh: () async {
                            await controller.onRefresh();
                          },
                          onLoad: () async {
                            await Future.delayed(
                              const Duration(seconds: 2),
                            );

                            await controller.onLoad();
                          },
                          child: ListView(
                            padding: const EdgeInsets.all(16),
                            children: controller.list
                                .map(
                                  (e) => JobItem(
                                    record: e,
                                    type: JobActionType.completed,
                                    callBack: () {
                                      Get.toNamed(
                                        Routes.JOBS_JOB_DETAILS,
                                        arguments: JobDetailPushParameters(
                                          type: JobActionType.completed,
                                          record: e,
                                        ),
                                      );
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
