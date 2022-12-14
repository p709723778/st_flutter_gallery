import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:st/app/components/link_tile.dart';
import 'package:st/app/modules/jobs/job_details/controllers/jobs_job_details_controller.dart';

class JobInfoDetail extends StatefulWidget {
  const JobInfoDetail({Key? key}) : super(key: key);

  @override
  State<JobInfoDetail> createState() => _JobInfoDetailState();
}

class _JobInfoDetailState extends State<JobInfoDetail> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobsJobDetailsController>(
      builder: (controller) {
        return Column(
          children: [
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          dense: true,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          title: Text(
                            '工作面信息',
                            style: Get.theme.textTheme.bodyText1
                                ?.copyWith(fontSize: 17),
                          ),
                        ),
                        const Divider(height: 0.5),
                        LinkTile(
                          context,
                          Text('工作面'.tr, style: Get.theme.textTheme.bodyText2),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 48,
                          trailing: Text(
                            controller.jobDetailModel.workFace ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: Get.theme.textTheme.subtitle1,
                          ),
                        ),
                        const Divider(height: 0.5, indent: 16, endIndent: 16),
                        LinkTile(
                          context,
                          Text('钻场'.tr, style: Get.theme.textTheme.bodyText2),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 48,
                          trailing: Text(
                            controller.jobDetailModel.drillSite ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: Get.theme.textTheme.subtitle1,
                          ),
                        ),
                        const Divider(height: 0.5, indent: 16, endIndent: 16),
                        LinkTile(
                          context,
                          Text('钻孔编号'.tr, style: Get.theme.textTheme.bodyText2),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 48,
                          trailing: Text(
                            controller.jobDetailModel.drillNumber ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: Get.theme.textTheme.subtitle1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          dense: true,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          title: Text(
                            '钻孔信息',
                            style: Get.theme.textTheme.bodyText1
                                ?.copyWith(fontSize: 17),
                          ),
                        ),
                        const Divider(height: 0.5),
                        LinkTile(
                          context,
                          Text(
                            '钻场间距（m）'.tr,
                            style: Get.theme.textTheme.bodyText2,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 48,
                          trailing: Text(
                            controller.jobDetailModel.drillGap?.toString() ??
                                '',
                            overflow: TextOverflow.ellipsis,
                            style: Get.theme.textTheme.subtitle1,
                          ),
                        ),
                        const Divider(height: 0.5, indent: 16, endIndent: 16),
                        LinkTile(
                          context,
                          Text(
                            '切眼道基准（m）'.tr,
                            style: Get.theme.textTheme.bodyText2,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 48,
                          trailing: Text(
                            controller.jobDetailModel.baseline?.toString() ??
                                '',
                            overflow: TextOverflow.ellipsis,
                            style: Get.theme.textTheme.subtitle1,
                          ),
                        ),
                        const Divider(height: 0.5, indent: 16, endIndent: 16),
                        LinkTile(
                          context,
                          Text(
                            '停采线（m）'.tr,
                            style: Get.theme.textTheme.bodyText2,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 48,
                          trailing: Text(
                            controller.jobDetailModel.miningLine?.toString() ??
                                '',
                            overflow: TextOverflow.ellipsis,
                            style: Get.theme.textTheme.subtitle1,
                          ),
                        ),
                        const Divider(height: 0.5, indent: 16, endIndent: 16),
                        LinkTile(
                          context,
                          Text(
                            '开孔高度（距离巷道地板m）'.tr,
                            style: Get.theme.textTheme.bodyText2,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 48,
                          trailing: Text(
                            controller.jobDetailModel.holeHeight?.toString() ??
                                '',
                            overflow: TextOverflow.ellipsis,
                            style: Get.theme.textTheme.subtitle1,
                          ),
                        ),
                        const Divider(height: 0.5, indent: 16, endIndent: 16),
                        LinkTile(
                          context,
                          Text(
                            '距离钻场设计线（m）'.tr,
                            style: Get.theme.textTheme.bodyText2,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 48,
                          trailing: Text(
                            controller.jobDetailModel.designLine?.toString() ??
                                '',
                            overflow: TextOverflow.ellipsis,
                            style: Get.theme.textTheme.subtitle1,
                          ),
                        ),
                        const Divider(height: 0.5, indent: 16, endIndent: 16),
                        LinkTile(
                          context,
                          Text(
                            '设计方位角（°）'.tr,
                            style: Get.theme.textTheme.bodyText2,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 48,
                          trailing: Text(
                            controller.jobDetailModel.azimuth?.toString() ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: Get.theme.textTheme.subtitle1,
                          ),
                        ),
                        const Divider(height: 0.5, indent: 16, endIndent: 16),
                        LinkTile(
                          context,
                          Text(
                            '设计孔深（m）'.tr,
                            style: Get.theme.textTheme.bodyText2,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 48,
                          trailing: Text(
                            controller.jobDetailModel.holeDepth?.toString() ??
                                '',
                            overflow: TextOverflow.ellipsis,
                            style: Get.theme.textTheme.subtitle1,
                          ),
                        ),
                        const Divider(height: 0.5, indent: 16, endIndent: 16),
                        LinkTile(
                          context,
                          Text(
                            '倾角（°）'.tr,
                            style: Get.theme.textTheme.bodyText2,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 48,
                          trailing: Text(
                            controller.jobDetailModel.dip?.toString() ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: Get.theme.textTheme.subtitle1,
                          ),
                        ),
                        const Divider(height: 0.5, indent: 16, endIndent: 16),
                        LinkTile(
                          context,
                          Text(
                            '开孔深度（m）'.tr,
                            style: Get.theme.textTheme.bodyText2,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 48,
                          trailing: Text(
                            controller.jobDetailModel.openHoleDepth
                                    ?.toString() ??
                                '',
                            overflow: TextOverflow.ellipsis,
                            style: Get.theme.textTheme.subtitle1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          dense: true,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          title: Text(
                            '作业信息',
                            style: Get.theme.textTheme.bodyText1
                                ?.copyWith(fontSize: 17),
                          ),
                        ),
                        const Divider(height: 0.5),
                        LinkTile(
                          context,
                          Text('作业时间'.tr, style: Get.theme.textTheme.bodyText2),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 48,
                          trailing: Text(
                            DateFormat("yyyy-MM-dd").format(
                              DateTime.fromMillisecondsSinceEpoch(
                                controller.jobDetailModel.constructDate ?? 0,
                              ),
                            ),
                            overflow: TextOverflow.ellipsis,
                            style: Get.theme.textTheme.subtitle1,
                          ),
                        ),
                        const Divider(height: 0.5, indent: 16, endIndent: 16),
                        LinkTile(
                          context,
                          Text('施工班次'.tr, style: Get.theme.textTheme.bodyText2),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 48,
                          trailing: Text(
                            controller.jobDetailModel.shift?.message ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: Get.theme.textTheme.subtitle1,
                          ),
                        ),
                        const Divider(height: 0.5, indent: 16, endIndent: 16),
                        LinkTile(
                          context,
                          Text('施工机长'.tr, style: Get.theme.textTheme.bodyText2),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 48,
                          trailing: Text(
                            controller.jobDetailModel.captain ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: Get.theme.textTheme.subtitle1,
                          ),
                        ),
                        const Divider(height: 0.5, indent: 16, endIndent: 16),
                        LinkTile(
                          context,
                          Text('班组人员'.tr, style: Get.theme.textTheme.bodyText2),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 48,
                          trailing: Text(
                            controller.jobDetailModel.crewMembers ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: Get.theme.textTheme.subtitle1,
                          ),
                        ),
                        const Divider(height: 0.5, indent: 16, endIndent: 16),
                        LinkTile(
                          context,
                          Text(
                            '方位角（°）'.tr,
                            style: Get.theme.textTheme.bodyText2,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 48,
                          trailing: Text(
                            controller.jobDetailModel.jobAzimuth?.toString() ??
                                '',
                            overflow: TextOverflow.ellipsis,
                            style: Get.theme.textTheme.subtitle1,
                          ),
                        ),
                        const Divider(height: 0.5, indent: 16, endIndent: 16),
                        LinkTile(
                          context,
                          Text(
                            '倾角（°）'.tr,
                            style: Get.theme.textTheme.bodyText2,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 48,
                          trailing: Text(
                            controller.jobDetailModel.jobDip?.toString() ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: Get.theme.textTheme.subtitle1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          dense: true,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          title: Text(
                            '视频监控状态确认',
                            style: Get.theme.textTheme.bodyText1
                                ?.copyWith(fontSize: 17),
                          ),
                        ),
                        const Divider(height: 0.5),
                        LinkTile(
                          context,
                          Text(
                            '监控是否开启'.tr,
                            style: Get.theme.textTheme.bodyText2,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 48,
                          trailing: Text(
                            controller.jobDetailModel.monitorOn?.message ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: Get.theme.textTheme.subtitle1,
                          ),
                        ),
                        const Divider(height: 0.5, indent: 16, endIndent: 16),
                        LinkTile(
                          context,
                          Text(
                            '监控位置确认'.tr,
                            style: Get.theme.textTheme.bodyText2,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 48,
                          trailing: Text(
                            controller
                                    .jobDetailModel.monitorPosition?.message ??
                                '',
                            overflow: TextOverflow.ellipsis,
                            style: Get.theme.textTheme.subtitle1,
                          ),
                        ),
                      ],
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
