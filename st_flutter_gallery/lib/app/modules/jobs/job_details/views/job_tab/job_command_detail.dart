import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/jobs/job_details/controllers/job_command_detail_controller.dart';
import 'package:st/app/modules/jobs/job_details/model/job_detail_model.dart';
import 'package:st/app/modules/jobs/jobs_enum.dart';
import 'package:st/app/modules/jobs/list_item/job_command_item.dart';
import 'package:st/app/themes/custom_theme_colors.dart';
import 'package:timelines/timelines.dart';

class JobCommandDetail extends StatefulWidget {
  const JobCommandDetail({
    Key? key,
    this.jobDetailModel,
    required this.type,
    this.repairRecord,
  }) : super(key: key);

  final JobDetailModel? jobDetailModel;
  final JobActionType? type;
  final bool? repairRecord;

  @override
  State<JobCommandDetail> createState() => _JobCommandDetailState();
}

class _JobCommandDetailState extends State<JobCommandDetail> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobCommandDetailController>(
      init: JobCommandDetailController(jobDetailModel: widget.jobDetailModel),
      builder: (logic) {
        return ListView(
          children: [
            if (logic.list.isNotEmpty)
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
                child: Timeline.tileBuilder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  // semanticChildCount: 5,
                  theme: TimelineThemeData(
                    nodePosition: 0,
                    color:
                        Get.theme.extension<CustomThemeColors>()?.timeLineColor,
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
                    vertical: 20,
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
              ),
            if ((widget.type == JobActionType.completed ||
                    widget.type == JobActionType.underway) &&
                (widget.repairRecord ?? false))
              GetBuilder<JobCommandDetailController>(
                id: JobCommandDetailController.RepairPeopleID,
                builder: (logic) {
                  if ((logic.jobRepairPeople?.people?.isEmpty ?? true) &&
                      (logic.jobRepairPeople?.getTimeString ?? '').isEmpty) {
                    return const SizedBox();
                  }
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '补录人：',
                              style: Get.theme.textTheme.bodyText2,
                            ),
                            Flexible(
                              child: Text(
                                logic.jobRepairPeople?.people?.toString() ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: Get.theme.textTheme.bodyText2,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '补录时间：',
                              style: Get.theme.textTheme.bodyText2,
                            ),
                            Flexible(
                              child: Text(
                                logic.jobRepairPeople?.getTimeString ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: Get.theme.textTheme.bodyText2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  );
                },
              ),
          ],
        );
      },
    );
  }
}
