import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/components/custom_appbar.dart';
import 'package:st/app/components/link_tile.dart';
import 'package:st/app/modules/jobs/jobs_enum.dart';
import 'package:st/app/modules/jobs/start_job_page/controllers/start_job_page_controller.dart';
import 'package:st/app/themes/custom_theme_colors.dart';
import 'package:st/utils/date_time/date_time_picker_util.dart';

class StartJobPageView extends GetView<StartJobPageController> {
  const StartJobPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.backgroundColor,
      appBar: CustomAppbar(
        title: controller.writeJobInfoModel.jobActionType == JobActionType.start
            ? '开始作业'
            : '作业补录',
      ),
      body: GetBuilder<StartJobPageController>(
        builder: (logic) {
          return Container(
            color: Get.theme.extension<CustomThemeColors>()?.backgroundColor,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 16,
                    ),
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
                                '选择钻孔',
                                style: Get.theme.textTheme.bodyText1
                                    ?.copyWith(fontSize: 17),
                              ),
                            ),
                            const Divider(height: 0.5),
                            LinkTile(
                              context,
                              Text(
                                '工作面'.tr,
                                style: Get.theme.textTheme.bodyText2,
                              ),
                              showTrailingIcon: true,
                              isAsterisk: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              height: 48,
                              trailing: Text(
                                controller
                                        .writeJobInfoModel.workFaceModel?.key ??
                                    '',
                                overflow: TextOverflow.ellipsis,
                                style: Get.theme.textTheme.subtitle1,
                              ),
                              onTap: () async {
                                await controller.showQueryWorkFace();
                              },
                            ),
                            const Divider(
                              height: 0.5,
                              indent: 16,
                              endIndent: 16,
                            ),
                            LinkTile(
                              context,
                              Text(
                                '钻场'.tr,
                                style: Get.theme.textTheme.bodyText2,
                              ),
                              showTrailingIcon: true,
                              isAsterisk: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              height: 48,
                              trailing: Text(
                                controller.writeJobInfoModel.querySiteModel
                                        ?.key ??
                                    '',
                                overflow: TextOverflow.ellipsis,
                                style: Get.theme.textTheme.subtitle1,
                              ),
                              onTap: () async {
                                await controller.showQuerySite();
                              },
                            ),
                            const Divider(
                              height: 0.5,
                              indent: 16,
                              endIndent: 16,
                            ),
                            LinkTile(
                              context,
                              Text(
                                '钻孔编号'.tr,
                                style: Get.theme.textTheme.bodyText2,
                              ),
                              showTrailingIcon: true,
                              isAsterisk: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              height: 48,
                              trailing: Text(
                                controller.writeJobInfoModel
                                        .querySiteNumberModel?.key ??
                                    '',
                                overflow: TextOverflow.ellipsis,
                                style: Get.theme.textTheme.subtitle1,
                              ),
                              onTap: () async {
                                await controller.showQuerySiteNumber();
                              },
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              height: 48,
                              trailing: Text(
                                controller.writeJobInfoModel.drillInfoModel
                                        ?.drillGap
                                        ?.toString() ??
                                    '',
                                overflow: TextOverflow.ellipsis,
                                style: Get.theme.textTheme.subtitle1,
                              ),
                              onTap: () async {},
                            ),
                            const Divider(
                              height: 0.5,
                              indent: 16,
                              endIndent: 16,
                            ),
                            LinkTile(
                              context,
                              Text(
                                '切眼道基准（m）'.tr,
                                style: Get.theme.textTheme.bodyText2,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              height: 48,
                              trailing: Text(
                                controller.writeJobInfoModel.drillInfoModel
                                        ?.baseline
                                        ?.toString() ??
                                    '',
                                overflow: TextOverflow.ellipsis,
                                style: Get.theme.textTheme.subtitle1,
                              ),
                              onTap: () async {},
                            ),
                            const Divider(
                              height: 0.5,
                              indent: 16,
                              endIndent: 16,
                            ),
                            LinkTile(
                              context,
                              Text(
                                '停采线（m）'.tr,
                                style: Get.theme.textTheme.bodyText2,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              height: 48,
                              trailing: Text(
                                controller.writeJobInfoModel.drillInfoModel
                                        ?.miningLine
                                        ?.toString() ??
                                    '',
                                overflow: TextOverflow.ellipsis,
                                style: Get.theme.textTheme.subtitle1,
                              ),
                              onTap: () async {},
                            ),
                            const Divider(
                              height: 0.5,
                              indent: 16,
                              endIndent: 16,
                            ),
                            LinkTile(
                              context,
                              Text(
                                '开孔高度（距离巷道地板m）'.tr,
                                style: Get.theme.textTheme.bodyText2,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              height: 48,
                              trailing: Text(
                                controller.writeJobInfoModel.drillInfoModel
                                        ?.holeHeight
                                        ?.toString() ??
                                    '',
                                overflow: TextOverflow.ellipsis,
                                style: Get.theme.textTheme.subtitle1,
                              ),
                              onTap: () async {},
                            ),
                            const Divider(
                              height: 0.5,
                              indent: 16,
                              endIndent: 16,
                            ),
                            LinkTile(
                              context,
                              Text(
                                '距离钻场设计线（m）'.tr,
                                style: Get.theme.textTheme.bodyText2,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              height: 48,
                              trailing: Text(
                                controller.writeJobInfoModel.drillInfoModel
                                        ?.designLine
                                        ?.toString() ??
                                    '',
                                overflow: TextOverflow.ellipsis,
                                style: Get.theme.textTheme.subtitle1,
                              ),
                              onTap: () async {},
                            ),
                            const Divider(
                              height: 0.5,
                              indent: 16,
                              endIndent: 16,
                            ),
                            LinkTile(
                              context,
                              Text(
                                '设计方位角（°）'.tr,
                                style: Get.theme.textTheme.bodyText2,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              height: 48,
                              trailing: Text(
                                controller.writeJobInfoModel.drillInfoModel
                                        ?.azimuth
                                        ?.toString() ??
                                    '',
                                overflow: TextOverflow.ellipsis,
                                style: Get.theme.textTheme.subtitle1,
                              ),
                              onTap: () async {},
                            ),
                            const Divider(
                              height: 0.5,
                              indent: 16,
                              endIndent: 16,
                            ),
                            LinkTile(
                              context,
                              Text(
                                '设计孔深（m）'.tr,
                                style: Get.theme.textTheme.bodyText2,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              height: 48,
                              trailing: Text(
                                controller.writeJobInfoModel.drillInfoModel
                                        ?.holeDepth
                                        ?.toString() ??
                                    '',
                                overflow: TextOverflow.ellipsis,
                                style: Get.theme.textTheme.subtitle1,
                              ),
                              onTap: () async {},
                            ),
                            const Divider(
                              height: 0.5,
                              indent: 16,
                              endIndent: 16,
                            ),
                            LinkTile(
                              context,
                              Text(
                                '倾角（°）'.tr,
                                style: Get.theme.textTheme.bodyText2,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              height: 48,
                              trailing: Text(
                                controller.writeJobInfoModel.drillInfoModel?.dip
                                        ?.toString() ??
                                    '',
                                overflow: TextOverflow.ellipsis,
                                style: Get.theme.textTheme.subtitle1,
                              ),
                              onTap: () async {},
                            ),
                            const Divider(
                              height: 0.5,
                              indent: 16,
                              endIndent: 16,
                            ),
                            LinkTile(
                              context,
                              Text(
                                '开孔深度（m）'.tr,
                                style: Get.theme.textTheme.bodyText2,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              height: 48,
                              trailing: Text(
                                controller.writeJobInfoModel.drillInfoModel
                                        ?.openHoleDepth
                                        ?.toString() ??
                                    '',
                                overflow: TextOverflow.ellipsis,
                                style: Get.theme.textTheme.subtitle1,
                              ),
                              onTap: () async {},
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
                              Text(
                                '作业时间'.tr,
                                style: Get.theme.textTheme.bodyText2,
                              ),
                              showTrailingIcon: true,
                              isAsterisk: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              height: 48,
                              trailing: Text(
                                controller.writeJobInfoModel.constructDateString
                                        ?.toString() ??
                                    '',
                                overflow: TextOverflow.ellipsis,
                                style: Get.theme.textTheme.subtitle1,
                              ),
                              onTap: () async {
                                DateTimePickerUtil.showDateTimePicker(
                                  context,
                                  dateFormat: dateTimeDayFormat,
                                  maxDateTime: DateTime.now(),
                                  onConfirm: (
                                    DateTime dateTime,
                                    List<int> selectedIndex,
                                  ) {
                                    controller.setDateTime(dateTime);
                                  },
                                );
                              },
                            ),
                            const Divider(
                              height: 0.5,
                              indent: 16,
                              endIndent: 16,
                            ),
                            LinkTile(
                              context,
                              Text(
                                '施工班次'.tr,
                                style: Get.theme.textTheme.bodyText2,
                              ),
                              showTrailingIcon: true,
                              isAsterisk: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              height: 48,
                              trailing: Text(
                                controller.writeJobInfoModel.shift?.message ??
                                    '',
                                overflow: TextOverflow.ellipsis,
                                style: Get.theme.textTheme.subtitle1,
                              ),
                              onTap: () async {
                                await controller
                                    .showWorkingTimeActionSheet(context);
                              },
                            ),
                            const Divider(
                              height: 0.5,
                              indent: 16,
                              endIndent: 16,
                            ),
                            LinkTile(
                              context,
                              Text(
                                '施工机长'.tr,
                                style: Get.theme.textTheme.bodyText2,
                              ),
                              showTrailingIcon: true,
                              isAsterisk: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              height: 48,
                              trailing: Text(
                                controller.writeJobInfoModel.captain
                                        ?.toString() ??
                                    '',
                                overflow: TextOverflow.ellipsis,
                                style: Get.theme.textTheme.subtitle1,
                              ),
                              onTap: () async {
                                await controller.showWorkerCaptain();
                              },
                            ),
                            const Divider(
                              height: 0.5,
                              indent: 16,
                              endIndent: 16,
                            ),
                            LinkTile(
                              context,
                              Text(
                                '班组人员'.tr,
                                style: Get.theme.textTheme.bodyText2,
                              ),
                              isAsterisk: true,
                              showTrailingIcon: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              height: 48,
                              trailing: Text(
                                controller.writeJobInfoModel.crewMembers
                                        ?.toString() ??
                                    '',
                                overflow: TextOverflow.ellipsis,
                                style: Get.theme.textTheme.subtitle1,
                              ),
                              onTap: () async {
                                await controller.showWorkerName();
                              },
                            ),
                            const Divider(
                              height: 0.5,
                              indent: 16,
                              endIndent: 16,
                            ),
                            LinkTile(
                              context,
                              Text(
                                '方位角（°）'.tr,
                                style: Get.theme.textTheme.bodyText2,
                              ),
                              showTrailingIcon: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              height: 48,
                              trailing: Text(
                                controller.writeJobInfoModel.jobAzimuth
                                        ?.toString() ??
                                    '',
                                overflow: TextOverflow.ellipsis,
                                style: Get.theme.textTheme.subtitle1,
                              ),
                              onTap: () async {
                                await controller.showAzimuth();
                              },
                            ),
                            const Divider(
                              height: 0.5,
                              indent: 16,
                              endIndent: 16,
                            ),
                            LinkTile(
                              context,
                              Text(
                                '倾角（°）'.tr,
                                style: Get.theme.textTheme.bodyText2,
                              ),
                              showTrailingIcon: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              height: 48,
                              trailing: Text(
                                controller.writeJobInfoModel.jobDip
                                        ?.toString() ??
                                    '',
                                overflow: TextOverflow.ellipsis,
                                style: Get.theme.textTheme.subtitle1,
                              ),
                              onTap: () async {
                                await controller.showDip();
                              },
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
                              showTrailingIcon: true,
                              isAsterisk: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              height: 48,
                              trailing: Text(
                                controller
                                        .writeJobInfoModel.monitorOn?.message ??
                                    '',
                                overflow: TextOverflow.ellipsis,
                                style: Get.theme.textTheme.subtitle1,
                              ),
                              onTap: () async {
                                await controller
                                    .showMonitoringIsEnabledActionSheet(
                                  context,
                                );
                              },
                            ),
                            const Divider(
                              height: 0.5,
                              indent: 16,
                              endIndent: 16,
                            ),
                            LinkTile(
                              context,
                              Text(
                                '监控位置确认'.tr,
                                style: Get.theme.textTheme.bodyText2,
                              ),
                              showTrailingIcon: true,
                              isAsterisk: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              height: 48,
                              trailing: Text(
                                controller.writeJobInfoModel.monitorPosition
                                        ?.message ??
                                    '',
                                overflow: TextOverflow.ellipsis,
                                style: Get.theme.textTheme.subtitle1,
                              ),
                              onTap: () async {
                                await controller
                                    .showMonitoringLocationActionSheet(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (controller.writeJobInfoModel.jobActionType ==
                    JobActionType.start)
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
                            "取消",
                          ),
                        ),
                        // ElevatedButton(
                        //   style: OutlinedButton.styleFrom(
                        //     minimumSize: const Size(104, 48),
                        //   ),
                        //   onPressed: () {
                        //     controller.save();
                        //   },
                        //   child: const Text(
                        //     "保存",
                        //   ),
                        // ),
                        ElevatedButton(
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(104, 48),
                          ),
                          onPressed: () {
                            controller.nextPage();
                          },
                          child: const Text(
                            "下一步",
                          ),
                        ),
                      ],
                    ),
                  ),
                if (controller.writeJobInfoModel.jobActionType ==
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
                        ElevatedButton(
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(104, 48),
                          ),
                          onPressed: () {
                            controller.nextPage();
                          },
                          child: const Text(
                            "下一步",
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
