import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/components/link_tile.dart';
import 'package:st/app/modules/jobs/job_details/controllers/job_command_actions_controller.dart';
import 'package:st/app/modules/jobs/job_details/model/job_detail_model.dart';
import 'package:st/app/modules/jobs/list_item/job_command_item.dart';
import 'package:st/app/themes/custom_theme_colors.dart';
import 'package:timelines/timelines.dart';

class JobCommandActions extends StatefulWidget {
  const JobCommandActions({Key? key, this.jobDetailModel}) : super(key: key);

  final JobDetailModel? jobDetailModel;

  @override
  State<JobCommandActions> createState() => _JobCommandActionsState();
}

class _JobCommandActionsState extends State<JobCommandActions> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobCommandActionsController>(
      init: JobCommandActionsController(jobDetailModel: widget.jobDetailModel),
      assignId: true,
      builder: (logic) {
        return ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
              decoration: BoxDecoration(
                color: Get.theme.backgroundColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Get.theme.shadowColor,
                    blurRadius: 7.5,
                  ),
                ],
              ),
              child: LinkTile(
                context,
                Text('指令类型'.tr, style: Get.theme.textTheme.bodyText2),
                showTrailingIcon: true,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 48,
                borderRadius: 8,
                trailing: Text(
                  logic.currentJobCommandModel.message ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: Get.theme.textTheme.subtitle1,
                ),
                onTap: () async {
                  await logic.showCommandTypeSheet(context);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Get.theme.backgroundColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Get.theme.shadowColor,
                    blurRadius: 7.5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  if (logic.actionBtnState == 1)
                    Container(
                      width: 146,
                      height: 146,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          colorFilter:
                              ColorFilter.mode(Colors.grey, BlendMode.modulate),
                          image:
                              AssetImage('assets/images/main/jobs_start.png'),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          logic.startJob();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          splashFactory: NoSplash.splashFactory,
                          elevation: MaterialStateProperty.all(0),
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: const Text(
                          "开始作业",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  if (logic.actionBtnState == 2)
                    Container(
                      width: 146,
                      height: 146,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          colorFilter:
                              ColorFilter.mode(Colors.grey, BlendMode.modulate),
                          image: AssetImage('assets/images/main/jobs_end.png'),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          logic.endJob();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          splashFactory: NoSplash.splashFactory,
                          elevation: MaterialStateProperty.all(0),
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: const Text(
                          "结束作业",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  if (logic.actionBtnState == 3)
                    Container(
                      width: 146,
                      height: 146,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          colorFilter:
                              ColorFilter.mode(Colors.grey, BlendMode.srcATop),
                          image: AssetImage('assets/images/main/jobs_end.png'),
                        ),
                      ),
                      child: TextButton(
                        onPressed: null,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          splashFactory: NoSplash.splashFactory,
                          elevation: MaterialStateProperty.all(0),
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: const Text(
                          "结束作业",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  if (logic.list.isEmpty) const SizedBox(height: 32),
                  if (logic.list.isNotEmpty)
                    Timeline.tileBuilder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      // semanticChildCount: 5,
                      theme: TimelineThemeData(
                        nodePosition: 0,
                        color: Get.theme
                            .extension<CustomThemeColors>()
                            ?.timeLineColor,
                        indicatorTheme: IndicatorThemeData(
                          size: 6,
                          color: Get.theme
                              .extension<CustomThemeColors>()
                              ?.timeLineColor,
                          position: 0.05,
                        ),
                        connectorTheme: ConnectorThemeData(
                          color: Get.theme
                              .extension<CustomThemeColors>()
                              ?.timeLineColor,
                          thickness: 1,
                          space: 20,
                          indent: 0,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 20,
                      ),
                      builder: TimelineTileBuilder.connected(
                        contentsBuilder: (context, index) {
                          final record = logic.list[index];
                          return JobCommandItem(records: record);
                        },
                        connectorBuilder: (_, index, __) {
                          if (index == 0) {
                            return DashedLineConnector(
                              dash: 1,
                              color: Get.theme
                                  .extension<CustomThemeColors>()
                                  ?.timeLineColor,
                            );
                          } else {
                            return DashedLineConnector(
                              dash: 1,
                              color: Get.theme
                                  .extension<CustomThemeColors>()
                                  ?.timeLineColor,
                            );
                          }
                        },
                        indicatorBuilder: (_, index) {
                          return DotIndicator(
                            color: Get.theme
                                .extension<CustomThemeColors>()
                                ?.timeLineColor,
                          );
                        },
                        itemCount: logic.list.length,
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
