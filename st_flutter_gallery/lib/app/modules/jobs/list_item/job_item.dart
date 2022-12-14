import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:st/app/modules/jobs/jobs_enum.dart';
import 'package:st/app/modules/jobs/underway_job/model/records.dart';
import 'package:st/utils/date_time/date_time_picker_util.dart';

class JobItem extends StatefulWidget {
  const JobItem({Key? key, this.callBack, this.record, this.type})
      : super(key: key);

  final void Function()? callBack;
  final Records? record;
  final JobActionType? type;

  @override
  State<JobItem> createState() => _JobItemState();
}

class _JobItemState extends State<JobItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.callBack?.call();
      },
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                '工作面：',
                                style: Get.theme.textTheme.bodyText2,
                              ),
                              Expanded(
                                child: Text(
                                  widget.record?.workFace ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      Get.theme.textTheme.bodyText2?.copyWith(
                                    color: const Color(0xFF696C78),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                '钻孔编号：',
                                style: Get.theme.textTheme.bodyText2,
                              ),
                              Expanded(
                                child: Text(
                                  widget.record?.drillNumber ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      Get.theme.textTheme.bodyText2?.copyWith(
                                    color: const Color(0xFF696C78),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                '钻场：',
                                style: Get.theme.textTheme.bodyText2,
                              ),
                              Expanded(
                                child: Text(
                                  widget.record?.drillSite ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      Get.theme.textTheme.bodyText2?.copyWith(
                                    color: const Color(0xFF696C78),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                '设计孔深（m）：',
                                style: Get.theme.textTheme.bodyText2,
                              ),
                              Expanded(
                                child: Text(
                                  widget.record?.holeDepth?.toString() ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      Get.theme.textTheme.bodyText2?.copyWith(
                                    color: const Color(0xFF696C78),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '班次：',
                          style: Get.theme.textTheme.bodyText2,
                        ),
                        Expanded(
                          child: Text(
                            widget.record?.shift?.message ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: Get.theme.textTheme.bodyText2
                                ?.copyWith(color: const Color(0xFF696C78)),
                          ),
                        ),
                      ],
                    ),
                    if (widget.record?.startTime != null) ...[
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '施工开始时间：',
                            style: Get.theme.textTheme.bodyText2,
                          ),
                          Expanded(
                            child: Text(
                              DateFormat(dateTimeReplenishmentFormat).format(
                                DateTime.fromMillisecondsSinceEpoch(
                                  widget.record!.startTime!,
                                ),
                              ),
                              overflow: TextOverflow.ellipsis,
                              style: Get.theme.textTheme.bodyText2
                                  ?.copyWith(color: const Color(0xFF696C78)),
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (widget.record?.endTime != null) ...[
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '施工结束时间：',
                            style: Get.theme.textTheme.bodyText2,
                          ),
                          Expanded(
                            child: Text(
                              DateFormat(dateTimeReplenishmentFormat).format(
                                DateTime.fromMillisecondsSinceEpoch(
                                  widget.record!.endTime!,
                                ),
                              ),
                              overflow: TextOverflow.ellipsis,
                              style: Get.theme.textTheme.bodyText2
                                  ?.copyWith(color: const Color(0xFF696C78)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              Visibility(
                visible: widget.type == JobActionType.completed ||
                    widget.type == JobActionType.underway,
                child: Positioned(
                  right: 0,
                  top: 0,
                  child: Stack(
                    children: [
                      if ((widget.record?.repairRecord ?? false) &&
                          widget.type == JobActionType.completed) ...[
                        Image.asset(
                          'assets/images/main/item_banner2.png',
                          width: 34,
                          height: 25,
                          fit: BoxFit.fill,
                        ),
                        const Positioned(
                          right: 2,
                          top: 3,
                          child: Text(
                            '补录',
                            style: TextStyle(fontSize: 8, color: Colors.white),
                          ),
                        ),
                      ] else if ((widget.record?.newest?.code != null) &&
                          widget.type == JobActionType.underway) ...[
                        Image.asset(
                          (widget.record?.newest?.code ?? 0) == 1
                              ? 'assets/images/main/item_banner2.png'
                              : 'assets/images/main/item_banner1.png',
                          width: 34 * 1.2,
                          height: 25 * 1.2,
                          fit: BoxFit.fill,
                        ),
                        const Positioned(
                          right: 2,
                          top: 3,
                          child: Text(
                            '进行中',
                            style: TextStyle(fontSize: 8, color: Colors.white),
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15)
        ],
      ),
    );
  }
}
