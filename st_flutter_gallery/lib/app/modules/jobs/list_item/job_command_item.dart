import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:st/app/modules/jobs/job_details/model/job_command_detail_records.dart';
import 'package:st/app/themes/custom_theme_colors.dart';
import 'package:st/utils/date_time/date_time_picker_util.dart';

class JobCommandItem extends StatefulWidget {
  const JobCommandItem({Key? key, this.records}) : super(key: key);

  final JobCommandDetailRecords? records;

  @override
  State<JobCommandItem> createState() => _JobCommandItemState();
}

class _JobCommandItemState extends State<JobCommandItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.records?.jobInstruct?.message != null)
              Text(
                widget.records?.jobInstruct?.message ?? '',
                style: TextStyle(
                  color:
                      Get.theme.extension<CustomThemeColors>()?.timeLineColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(width: 4),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '班长：',
                    style: Get.theme.textTheme.bodyText2,
                  ),
                  Flexible(
                    child: Text(
                      widget.records?.captain ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: Get.theme.textTheme.bodyText2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(height: 0.5),
        if (widget.records?.startTime != null) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '开始时间：',
                style: Get.theme.textTheme.bodyText2,
              ),
              Flexible(
                child: Text(
                  DateFormat(dateTimeReplenishmentFormat).format(
                    DateTime.fromMillisecondsSinceEpoch(
                      widget.records!.startTime!,
                    ),
                  ),
                  overflow: TextOverflow.ellipsis,
                  style: Get.theme.textTheme.bodyText2,
                ),
              ),
            ],
          ),
        ],
        if (widget.records?.endTime != null) ...[
          const SizedBox(height: 8),
          if (widget.records?.endTime != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '结束时间：',
                  style: Get.theme.textTheme.bodyText2,
                ),
                Flexible(
                  child: Text(
                    DateFormat(dateTimeReplenishmentFormat).format(
                      DateTime.fromMillisecondsSinceEpoch(
                        widget.records!.endTime!,
                      ),
                    ),
                    overflow: TextOverflow.ellipsis,
                    style: Get.theme.textTheme.bodyText2,
                  ),
                ),
              ],
            ),
        ],
        if (widget.records?.drillPipeLength != null) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '钻杆长度（m）：',
                style: Get.theme.textTheme.bodyText2,
              ),
              Flexible(
                child: Text(
                  widget.records?.drillPipeLength?.toString() ?? '',
                  style: Get.theme.textTheme.bodyText2,
                ),
              ),
            ],
          ),
        ],
        if (widget.records?.dutyFootage != null) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '当班进尺（m）：',
                style: Get.theme.textTheme.bodyText2,
              ),
              Flexible(
                child: Text(
                  widget.records?.dutyFootage?.toString() ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: Get.theme.textTheme.bodyText2,
                ),
              ),
            ],
          ),
        ],
        if (widget.records?.boreholeDiameter != null) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '钻孔直径（mm）：',
                style: Get.theme.textTheme.bodyText2,
              ),
              Flexible(
                child: Text(
                  widget.records?.boreholeDiameter?.toString() ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: Get.theme.textTheme.bodyText2,
                ),
              ),
            ],
          ),
        ],
        if (widget.records?.reamingDiameter != null) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '扩孔直径（mm）：',
                style: Get.theme.textTheme.bodyText2,
              ),
              Flexible(
                child: Text(
                  widget.records?.reamingDiameter?.toString() ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: Get.theme.textTheme.bodyText2,
                ),
              ),
            ],
          ),
        ],
        if (widget.records?.reamingDepth != null) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '扩孔深度（m）：',
                style: Get.theme.textTheme.bodyText2,
              ),
              Flexible(
                child: Text(
                  widget.records?.reamingDepth?.toString() ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: Get.theme.textTheme.bodyText2,
                ),
              ),
            ],
          ),
        ],
        if (widget.records?.sealingLength != null) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '封孔长度（m）：',
                style: Get.theme.textTheme.bodyText2,
              ),
              Flexible(
                child: Text(
                  widget.records?.sealingLength?.toString() ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: Get.theme.textTheme.bodyText2,
                ),
              ),
            ],
          ),
        ],
        if (widget.records?.startTime != null) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '备注：',
                style: Get.theme.textTheme.bodyText2,
              ),
              Flexible(
                child: Text(
                  widget.records?.remarks ?? '',
                  // overflow: TextOverflow.ellipsis,
                  style: Get.theme.textTheme.bodyText2,
                ),
              ),
            ],
          ),
        ],
        const SizedBox(height: 16),
      ],
    );
  }
}
