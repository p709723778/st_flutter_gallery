import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/components/custom_appbar.dart';
import 'package:st/app/modules/jobs/job_details/controllers/job_replenishment_controller.dart';
import 'package:st/app/modules/jobs/job_details/controllers/jobs_job_details_controller.dart';
import 'package:st/app/modules/jobs/job_details/views/job_tab/job_command_actions.dart';
import 'package:st/app/modules/jobs/job_details/views/job_tab/job_command_detail.dart';
import 'package:st/app/modules/jobs/job_details/views/job_tab/job_command_replenishment.dart';
import 'package:st/app/modules/jobs/job_details/views/job_tab/job_info_detail.dart';
import 'package:st/app/modules/jobs/jobs_enum.dart';
import 'package:st/app/themes/custom_theme_colors.dart';

class JobsJobDetailsView extends GetView<JobsJobDetailsController> {
  const JobsJobDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List tabs = <String>["作业基础信息", "作业指令发送"];

    return GetBuilder<JobsJobDetailsController>(
      builder: (logic) {
        if (controller.jobDetailPushParameters?.type ==
            JobActionType.replenishment) {
          tabs = <String>["作业基础信息", "指令信息补录"];
        }

        controller.jobDetailModel.id ??=
            controller.jobDetailPushParameters?.record?.id;
        return Scaffold(
          backgroundColor: Get.theme.backgroundColor,
          appBar: const CustomAppbar(
            title: '作业详情',
          ),
          body: DefaultTabController(
            initialIndex: (controller.jobDetailPushParameters?.type ==
                        JobActionType.start ||
                    controller.jobDetailPushParameters?.type ==
                        JobActionType.replenishment)
                ? 1
                : 0,
            length: tabs.length,
            child: Column(
              children: [
                SizedBox(
                  height: 48,
                  child: TabBar(
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
                    tabs: tabs.map((e) {
                      return Tab(text: e);
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Get.theme
                        .extension<CustomThemeColors>()
                        ?.backgroundColor,
                    child: TabBarView(
                      // key: ValueKey(controller.jobDetailModel.id),
                      children: [
                        const JobInfoDetail(),
                        if (controller.jobDetailPushParameters?.type ==
                            JobActionType.start)
                          JobCommandActions(
                            jobDetailModel: controller.jobDetailModel,
                          ),
                        if (controller.jobDetailPushParameters?.type ==
                            JobActionType.replenishment)
                          GetBuilder<JobReplenishmentController>(
                            init: controller.jobReplenishmentController,
                            builder: (logic) {
                              return const JobCommandReplenishment();
                            },
                          ),
                        if (controller.jobDetailPushParameters?.type ==
                            JobActionType.completed)
                          JobCommandDetail(
                            jobDetailModel: controller.jobDetailModel,
                            type: controller.jobDetailPushParameters?.type,
                            repairRecord: controller
                                .jobDetailPushParameters?.record?.repairRecord,
                          ),
                        if (controller.jobDetailPushParameters?.type ==
                            JobActionType.underway)
                          if ((controller.jobDetailPushParameters?.record
                                      ?.newest?.code ??
                                  0) ==
                              1)
                            JobCommandActions(
                              jobDetailModel: controller.jobDetailModel,
                            )
                          else
                            JobCommandDetail(
                              jobDetailModel: controller.jobDetailModel,
                              type: controller.jobDetailPushParameters?.type,
                              repairRecord: controller.jobDetailPushParameters
                                  ?.record?.repairRecord,
                            ),
                      ],
                    ),
                  ),
                ),
                if (controller.jobDetailPushParameters?.type ==
                    JobActionType.replenishment)
                  Container(
                    height: 74,
                    decoration: BoxDecoration(
                      color: Get.theme.backgroundColor,
                      border: Border(
                        top: BorderSide(
                          width: 0.5,
                          color: Get.theme.dividerColor,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(104, 48),
                          ),
                          onPressed: Get.back,
                          child: const Text(
                            "上一步",
                          ),
                        ),
                        GetBuilder<JobReplenishmentController>(
                          init: controller.jobReplenishmentController,
                          builder: (logic) {
                            return ElevatedButton(
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(104, 48),
                              ),
                              onPressed: () async {
                                final jobReplenishmentController =
                                    Get.find<JobReplenishmentController>();
                                await jobReplenishmentController.onConform();
                              },
                              child: const Text(
                                "提交",
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
      },
    );
  }
}
