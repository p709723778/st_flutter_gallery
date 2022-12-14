import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/components/link_tile.dart';
import 'package:st/app/constants/text_max_length.dart';
import 'package:st/app/modules/jobs/job_details/controllers/job_replenishment_controller.dart';
import 'package:st/app/modules/views/zk_check_box.dart';
import 'package:st/app/themes/custom_theme_colors.dart';
import 'package:st/utils/date_time/date_time_picker_util.dart';

class JobCommandReplenishment extends StatefulWidget {
  const JobCommandReplenishment({Key? key}) : super(key: key);

  @override
  State<JobCommandReplenishment> createState() =>
      _JobCommandReplenishmentState();
}

class _JobCommandReplenishmentState extends State<JobCommandReplenishment>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      color: Get.theme.extension<CustomThemeColors>()?.backgroundColor,
      child: Column(
        children: [
          Expanded(
            child: GetBuilder<JobReplenishmentController>(
              builder: (logic) {
                final sinceEpoch = logic.jobDetailModel?.constructDate ?? 0;
                final minDateTime = sinceEpoch <= 0
                    ? DateTime.now()
                    : DateTime.fromMillisecondsSinceEpoch(
                        sinceEpoch,
                        isUtc: true,
                      );

                final maxDateTime = DateTime.fromMillisecondsSinceEpoch(
                  sinceEpoch + (24 * 60 * 60 * 1000) - 1000,
                  isUtc: true,
                );

                return ListView(
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
                      child: ObxValue<RxBool>(
                        (v) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                dense: true,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                title: Text(
                                  '打钻',
                                  style:
                                      Get.theme.textTheme.bodyText1?.copyWith(
                                    fontSize: 17,
                                  ),
                                ),
                                trailing: ZKCheckBox(
                                  value: v.value,
                                  onChanged: (isSelect) {
                                    logic.isDaZuanSelect.value = isSelect;
                                  },
                                ),
                                onTap: () {
                                  logic.isDaZuanSelect.value =
                                      !logic.isDaZuanSelect.value;
                                },
                              ),
                              if (v.value) ...[
                                const Divider(height: 0.5),
                                LinkTile(
                                  context,
                                  Text(
                                    '班长'.tr,
                                    style: Get.theme.textTheme.bodyText2,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  height: 48,
                                  trailing: Text(
                                    logic.jobDetailModel?.captain ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.theme.textTheme.subtitle1,
                                  ),
                                  // onTap: () async {
                                  //   await logic.showDaZuanCaptain();
                                  // },
                                ),
                                const Divider(
                                  height: 0.5,
                                  indent: 16,
                                  endIndent: 16,
                                ),
                                LinkTile(
                                  context,
                                  Text(
                                    '开始时间'.tr,
                                    style: Get.theme.textTheme.bodyText2,
                                  ),
                                  showTrailingIcon: true,
                                  isAsterisk: v.value,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  height: 48,
                                  trailing: Text(
                                    logic.jobReplenishmentModelDaZuan
                                        .startDateTimeString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.theme.textTheme.subtitle1,
                                  ),
                                  onTap: () async {
                                    DateTimePickerUtil.showDateTimePicker(
                                      context,
                                      minDateTime: minDateTime,
                                      maxDateTime: maxDateTime,
                                      onConfirm: (
                                        DateTime dateTime,
                                        List<int> selectedIndex,
                                      ) {
                                        logic.jobReplenishmentModelDaZuan
                                            .startDateTime = dateTime;
                                        logic.update();
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
                                    '结束时间'.tr,
                                    style: Get.theme.textTheme.bodyText2,
                                  ),
                                  showTrailingIcon: true,
                                  isAsterisk: v.value,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  height: 48,
                                  trailing: Text(
                                    logic.jobReplenishmentModelDaZuan
                                        .endDateTimeString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.theme.textTheme.subtitle1,
                                  ),
                                  onTap: () async {
                                    DateTimePickerUtil.showDateTimePicker(
                                      context,
                                      minDateTime: minDateTime,
                                      maxDateTime: maxDateTime,
                                      onConfirm: (
                                        DateTime dateTime,
                                        List<int> selectedIndex,
                                      ) {
                                        logic.jobReplenishmentModelDaZuan
                                            .endDateTime = dateTime;
                                        logic.update();
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
                                    '钻杆长度（m）：'.tr,
                                    style: Get.theme.textTheme.bodyText2,
                                  ),
                                  showTrailingIcon: true,
                                  isAsterisk: v.value,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  height: 48,
                                  trailing: Text(
                                    logic.jobReplenishmentModelDaZuan
                                            .drillPipeLength
                                            ?.toStringAsFixed(2) ??
                                        '',
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.theme.textTheme.subtitle1,
                                  ),
                                  onTap: () async {
                                    await logic.showDrillPipeLength();
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
                                    '当班进尺（m）：'.tr,
                                    style: Get.theme.textTheme.bodyText2,
                                  ),
                                  showTrailingIcon: true,
                                  isAsterisk: v.value,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  height: 48,
                                  trailing: Text(
                                    logic.jobReplenishmentModelDaZuan
                                            .dutyFootage
                                            ?.toStringAsFixed(2) ??
                                        '',
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.theme.textTheme.subtitle1,
                                  ),
                                  onTap: () async {
                                    await logic.showDutyFootage();
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
                                    '钻孔直径（mm）：'.tr,
                                    style: Get.theme.textTheme.bodyText2,
                                  ),
                                  showTrailingIcon: true,
                                  isAsterisk: v.value,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  height: 48,
                                  trailing: Text(
                                    logic.jobReplenishmentModelDaZuan
                                            .boreholeDiameter
                                            ?.toStringAsFixed(2) ??
                                        '',
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.theme.textTheme.subtitle1,
                                  ),
                                  onTap: () async {
                                    await logic.showDutyFootage1();
                                  },
                                ),
                                const Divider(
                                  height: 0.5,
                                  indent: 16,
                                  endIndent: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 16),
                                      Text(
                                        '备注：'.tr,
                                        style: Get.theme.textTheme.bodyText2,
                                      ),
                                      const SizedBox(height: 16),
                                      TextField(
                                        controller:
                                            logic.textEditingControllerDaZuan,
                                        maxLines: 3,
                                        maxLength: remarkContentMaxLength,
                                        style: Get.theme.textTheme.bodyText2,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          hintText: '请输入备注',
                                          fillColor: Get.theme
                                              .extension<CustomThemeColors>()
                                              ?.backgroundColor,
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Get.theme.dividerColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Get.theme.dividerColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Get.theme.dividerColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          // disabledBorder: OutlineInputBorder(
                                          //   borderSide:
                                          //       BorderSide(color: Get.theme.dividerColor),
                                          //   borderRadius: BorderRadius.circular(4),
                                          // ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          );
                        },
                        logic.isDaZuanSelect,
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
                      child: ObxValue<RxBool>(
                        (v) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                dense: true,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                title: Text(
                                  '退杆',
                                  style:
                                      Get.theme.textTheme.bodyText1?.copyWith(
                                    fontSize: 17,
                                  ),
                                ),
                                trailing: ZKCheckBox(
                                  value: v.value,
                                  onChanged: (isSelect) {
                                    logic.isTuiGanSelect.value = isSelect;
                                  },
                                ),
                                onTap: () {
                                  logic.isTuiGanSelect.value =
                                      !logic.isTuiGanSelect.value;
                                },
                              ),
                              if (v.value) ...[
                                const Divider(height: 0.5),
                                LinkTile(
                                  context,
                                  Text(
                                    '班长'.tr,
                                    style: Get.theme.textTheme.bodyText2,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  height: 48,
                                  trailing: Text(
                                    logic.jobDetailModel?.captain ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.theme.textTheme.subtitle1,
                                  ),
                                  // onTap: () async {
                                  //   await logic.showTuiGanCaptain();
                                  // },
                                ),
                                const Divider(
                                  height: 0.5,
                                  indent: 16,
                                  endIndent: 16,
                                ),
                                LinkTile(
                                  context,
                                  Text(
                                    '开始时间'.tr,
                                    style: Get.theme.textTheme.bodyText2,
                                  ),
                                  showTrailingIcon: true,
                                  isAsterisk: v.value,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  height: 48,
                                  trailing: Text(
                                    logic.jobReplenishmentModelTuiGan
                                        .startDateTimeString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.theme.textTheme.subtitle1,
                                  ),
                                  onTap: () async {
                                    DateTimePickerUtil.showDateTimePicker(
                                      context,
                                      minDateTime: minDateTime,
                                      maxDateTime: maxDateTime,
                                      onConfirm: (
                                        DateTime dateTime,
                                        List<int> selectedIndex,
                                      ) {
                                        logic.jobReplenishmentModelTuiGan
                                            .startDateTime = dateTime;
                                        logic.update();
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
                                    '结束时间'.tr,
                                    style: Get.theme.textTheme.bodyText2,
                                  ),
                                  showTrailingIcon: true,
                                  isAsterisk: v.value,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  height: 48,
                                  trailing: Text(
                                    logic.jobReplenishmentModelTuiGan
                                        .endDateTimeString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.theme.textTheme.subtitle1,
                                  ),
                                  onTap: () async {
                                    DateTimePickerUtil.showDateTimePicker(
                                      context,
                                      minDateTime: minDateTime,
                                      maxDateTime: maxDateTime,
                                      onConfirm: (
                                        DateTime dateTime,
                                        List<int> selectedIndex,
                                      ) {
                                        logic.jobReplenishmentModelTuiGan
                                            .endDateTime = dateTime;
                                        logic.update();
                                      },
                                    );
                                  },
                                ),
                                const Divider(
                                  height: 0.5,
                                  indent: 16,
                                  endIndent: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 16),
                                      Text(
                                        '备注：'.tr,
                                        style: Get.theme.textTheme.bodyText2,
                                      ),
                                      const SizedBox(height: 16),
                                      TextField(
                                        controller:
                                            logic.textEditingControllerTuiGan,
                                        maxLines: 3,
                                        maxLength: remarkContentMaxLength,
                                        style: Get.theme.textTheme.bodyText2,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          hintText: '请输入备注',
                                          fillColor: Get.theme
                                              .extension<CustomThemeColors>()
                                              ?.backgroundColor,
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Get.theme.dividerColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Get.theme.dividerColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Get.theme.dividerColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          // disabledBorder: OutlineInputBorder(
                                          //   borderSide:
                                          //       BorderSide(color: Get.theme.dividerColor),
                                          //   borderRadius: BorderRadius.circular(4),
                                          // ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          );
                        },
                        logic.isTuiGanSelect,
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
                      child: ObxValue<RxBool>(
                        (v) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                dense: true,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                title: Text(
                                  '扩孔',
                                  style:
                                      Get.theme.textTheme.bodyText1?.copyWith(
                                    fontSize: 17,
                                  ),
                                ),
                                trailing: ZKCheckBox(
                                  value: v.value,
                                  onChanged: (isSelect) {
                                    logic.isKuoKongSelect.value = isSelect;
                                  },
                                ),
                                onTap: () {
                                  logic.isKuoKongSelect.value =
                                      !logic.isKuoKongSelect.value;
                                },
                              ),
                              if (v.value) ...[
                                const Divider(height: 0.5),
                                LinkTile(
                                  context,
                                  Text(
                                    '班长'.tr,
                                    style: Get.theme.textTheme.bodyText2,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  height: 48,
                                  trailing: Text(
                                    logic.jobDetailModel?.captain ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.theme.textTheme.subtitle1,
                                  ),
                                  // onTap: () async {
                                  //   await logic.showKuoKongCaptain();
                                  // },
                                ),
                                const Divider(
                                  height: 0.5,
                                  indent: 16,
                                  endIndent: 16,
                                ),
                                LinkTile(
                                  context,
                                  Text(
                                    '开始时间'.tr,
                                    style: Get.theme.textTheme.bodyText2,
                                  ),
                                  showTrailingIcon: true,
                                  isAsterisk: v.value,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  height: 48,
                                  trailing: Text(
                                    logic.jobReplenishmentModelKuoKong
                                        .startDateTimeString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.theme.textTheme.subtitle1,
                                  ),
                                  onTap: () async {
                                    DateTimePickerUtil.showDateTimePicker(
                                      context,
                                      minDateTime: minDateTime,
                                      maxDateTime: maxDateTime,
                                      onConfirm: (
                                        DateTime dateTime,
                                        List<int> selectedIndex,
                                      ) {
                                        logic.jobReplenishmentModelKuoKong
                                            .startDateTime = dateTime;
                                        logic.update();
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
                                    '结束时间'.tr,
                                    style: Get.theme.textTheme.bodyText2,
                                  ),
                                  showTrailingIcon: true,
                                  isAsterisk: v.value,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  height: 48,
                                  trailing: Text(
                                    logic.jobReplenishmentModelKuoKong
                                        .endDateTimeString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.theme.textTheme.subtitle1,
                                  ),
                                  onTap: () async {
                                    DateTimePickerUtil.showDateTimePicker(
                                      context,
                                      minDateTime: minDateTime,
                                      maxDateTime: maxDateTime,
                                      onConfirm: (
                                        DateTime dateTime,
                                        List<int> selectedIndex,
                                      ) {
                                        logic.jobReplenishmentModelKuoKong
                                            .endDateTime = dateTime;
                                        logic.update();
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
                                    '扩孔直径（mm）：'.tr,
                                    style: Get.theme.textTheme.bodyText2,
                                  ),
                                  showTrailingIcon: true,
                                  isAsterisk: v.value,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  height: 48,
                                  trailing: Text(
                                    logic.jobReplenishmentModelKuoKong
                                            .reamingDiameter
                                            ?.toStringAsFixed(2) ??
                                        '',
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.theme.textTheme.subtitle1,
                                  ),
                                  onTap: () async {
                                    await logic.showDutyFootage2();
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
                                    '扩孔深度（m）：'.tr,
                                    style: Get.theme.textTheme.bodyText2,
                                  ),
                                  showTrailingIcon: true,
                                  isAsterisk: v.value,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  height: 48,
                                  trailing: Text(
                                    logic.jobReplenishmentModelKuoKong
                                            .reamingDepth
                                            ?.toStringAsFixed(2) ??
                                        '',
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.theme.textTheme.subtitle1,
                                  ),
                                  onTap: () async {
                                    await logic.showDutyFootage3();
                                  },
                                ),
                                const Divider(
                                  height: 0.5,
                                  indent: 16,
                                  endIndent: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 16),
                                      Text(
                                        '备注：'.tr,
                                        style: Get.theme.textTheme.bodyText2,
                                      ),
                                      const SizedBox(height: 16),
                                      TextField(
                                        controller:
                                            logic.textEditingControllerKuoKong,
                                        maxLines: 3,
                                        maxLength: remarkContentMaxLength,
                                        style: Get.theme.textTheme.bodyText2,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          hintText: '请输入备注',
                                          fillColor: Get.theme
                                              .extension<CustomThemeColors>()
                                              ?.backgroundColor,
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Get.theme.dividerColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Get.theme.dividerColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Get.theme.dividerColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          // disabledBorder: OutlineInputBorder(
                                          //   borderSide:
                                          //       BorderSide(color: Get.theme.dividerColor),
                                          //   borderRadius: BorderRadius.circular(4),
                                          // ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          );
                        },
                        logic.isKuoKongSelect,
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
                      child: ObxValue<RxBool>(
                        (v) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                dense: true,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                title: Text(
                                  '封孔',
                                  style:
                                      Get.theme.textTheme.bodyText1?.copyWith(
                                    fontSize: 17,
                                  ),
                                ),
                                trailing: ZKCheckBox(
                                  value: v.value,
                                  onChanged: (isSelect) {
                                    logic.isFengKongSelect.value = isSelect;
                                  },
                                ),
                                onTap: () {
                                  logic.isFengKongSelect.value =
                                      !logic.isFengKongSelect.value;
                                },
                              ),
                              if (v.value) ...[
                                const Divider(height: 0.5),
                                LinkTile(
                                  context,
                                  Text(
                                    '班长'.tr,
                                    style: Get.theme.textTheme.bodyText2,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  height: 48,
                                  trailing: Text(
                                    logic.jobDetailModel?.captain ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.theme.textTheme.subtitle1,
                                  ),
                                  // onTap: () async {
                                  //   await logic.showFengKongCaptain();
                                  // },
                                ),
                                const Divider(
                                  height: 0.5,
                                  indent: 16,
                                  endIndent: 16,
                                ),
                                LinkTile(
                                  context,
                                  Text(
                                    '开始时间'.tr,
                                    style: Get.theme.textTheme.bodyText2,
                                  ),
                                  showTrailingIcon: true,
                                  isAsterisk: v.value,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  height: 48,
                                  trailing: Text(
                                    logic.jobReplenishmentModelFengKong
                                        .startDateTimeString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.theme.textTheme.subtitle1,
                                  ),
                                  onTap: () async {
                                    DateTimePickerUtil.showDateTimePicker(
                                      context,
                                      minDateTime: minDateTime,
                                      maxDateTime: maxDateTime,
                                      onConfirm: (
                                        DateTime dateTime,
                                        List<int> selectedIndex,
                                      ) {
                                        logic.jobReplenishmentModelFengKong
                                            .startDateTime = dateTime;
                                        logic.update();
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
                                    '结束时间'.tr,
                                    style: Get.theme.textTheme.bodyText2,
                                  ),
                                  showTrailingIcon: true,
                                  isAsterisk: v.value,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  height: 48,
                                  trailing: Text(
                                    logic.jobReplenishmentModelFengKong
                                        .endDateTimeString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.theme.textTheme.subtitle1,
                                  ),
                                  onTap: () async {
                                    DateTimePickerUtil.showDateTimePicker(
                                      context,
                                      minDateTime: minDateTime,
                                      maxDateTime: maxDateTime,
                                      onConfirm: (
                                        DateTime dateTime,
                                        List<int> selectedIndex,
                                      ) {
                                        logic.jobReplenishmentModelFengKong
                                            .endDateTime = dateTime;
                                        logic.update();
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
                                    '封孔长度（m）：'.tr,
                                    style: Get.theme.textTheme.bodyText2,
                                  ),
                                  showTrailingIcon: true,
                                  isAsterisk: v.value,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  height: 48,
                                  trailing: Text(
                                    logic.jobReplenishmentModelFengKong
                                            .sealingLength
                                            ?.toStringAsFixed(2) ??
                                        '',
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.theme.textTheme.subtitle1,
                                  ),
                                  onTap: () async {
                                    await logic.showDutyFootage4();
                                  },
                                ),
                                const Divider(
                                  height: 0.5,
                                  indent: 16,
                                  endIndent: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 16),
                                      Text(
                                        '备注：'.tr,
                                        style: Get.theme.textTheme.bodyText2,
                                      ),
                                      const SizedBox(height: 16),
                                      TextField(
                                        controller:
                                            logic.textEditingControllerFengKong,
                                        maxLines: 3,
                                        maxLength: remarkContentMaxLength,
                                        style: Get.theme.textTheme.bodyText2,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          hintText: '请输入备注',
                                          fillColor: Get.theme
                                              .extension<CustomThemeColors>()
                                              ?.backgroundColor,
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Get.theme.dividerColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Get.theme.dividerColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Get.theme.dividerColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          // disabledBorder: OutlineInputBorder(
                                          //   borderSide:
                                          //       BorderSide(color: Get.theme.dividerColor),
                                          //   borderRadius: BorderRadius.circular(4),
                                          // ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          );
                        },
                        logic.isFengKongSelect,
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
                      child: ObxValue<RxBool>(
                        (v) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                dense: true,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                title: Text(
                                  '注浆',
                                  style:
                                      Get.theme.textTheme.bodyText1?.copyWith(
                                    fontSize: 17,
                                  ),
                                ),
                                trailing: ZKCheckBox(
                                  value: v.value,
                                  onChanged: (isSelect) {
                                    logic.isZhuJiangSelect.value = isSelect;
                                  },
                                ),
                                onTap: () {
                                  logic.isZhuJiangSelect.value =
                                      !logic.isZhuJiangSelect.value;
                                },
                              ),
                              if (v.value) ...[
                                const Divider(height: 0.5),
                                LinkTile(
                                  context,
                                  Text(
                                    '班长'.tr,
                                    style: Get.theme.textTheme.bodyText2,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  height: 48,
                                  trailing: Text(
                                    logic.jobDetailModel?.captain ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.theme.textTheme.subtitle1,
                                  ),
                                  // onTap: () async {
                                  //   await logic.showZhuJiangCaptain();
                                  // },
                                ),
                                const Divider(
                                  height: 0.5,
                                  indent: 16,
                                  endIndent: 16,
                                ),
                                LinkTile(
                                  context,
                                  Text(
                                    '开始时间'.tr,
                                    style: Get.theme.textTheme.bodyText2,
                                  ),
                                  showTrailingIcon: true,
                                  isAsterisk: v.value,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  height: 48,
                                  trailing: Text(
                                    logic.jobReplenishmentModelZhuJiang
                                        .startDateTimeString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.theme.textTheme.subtitle1,
                                  ),
                                  onTap: () async {
                                    DateTimePickerUtil.showDateTimePicker(
                                      context,
                                      minDateTime: minDateTime,
                                      maxDateTime: maxDateTime,
                                      onConfirm: (
                                        DateTime dateTime,
                                        List<int> selectedIndex,
                                      ) {
                                        logic.jobReplenishmentModelZhuJiang
                                            .startDateTime = dateTime;
                                        logic.update();
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
                                    '结束时间'.tr,
                                    style: Get.theme.textTheme.bodyText2,
                                  ),
                                  showTrailingIcon: true,
                                  isAsterisk: v.value,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  height: 48,
                                  trailing: Text(
                                    logic.jobReplenishmentModelZhuJiang
                                        .endDateTimeString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.theme.textTheme.subtitle1,
                                  ),
                                  onTap: () async {
                                    DateTimePickerUtil.showDateTimePicker(
                                      context,
                                      minDateTime: minDateTime,
                                      maxDateTime: maxDateTime,
                                      onConfirm: (
                                        DateTime dateTime,
                                        List<int> selectedIndex,
                                      ) {
                                        logic.jobReplenishmentModelZhuJiang
                                            .endDateTime = dateTime;
                                        logic.update();
                                      },
                                    );
                                  },
                                ),
                                const Divider(
                                  height: 0.5,
                                  indent: 16,
                                  endIndent: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 16),
                                      Text(
                                        '备注：'.tr,
                                        style: Get.theme.textTheme.bodyText2,
                                      ),
                                      const SizedBox(height: 16),
                                      TextField(
                                        controller:
                                            logic.textEditingControllerZhuJiang,
                                        maxLines: 3,
                                        maxLength: remarkContentMaxLength,
                                        style: Get.theme.textTheme.bodyText2,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          hintText: '请输入备注',
                                          fillColor: Get.theme
                                              .extension<CustomThemeColors>()
                                              ?.backgroundColor,
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Get.theme.dividerColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Get.theme.dividerColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Get.theme.dividerColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          // disabledBorder: OutlineInputBorder(
                                          //   borderSide:
                                          //       BorderSide(color: Get.theme.dividerColor),
                                          //   borderRadius: BorderRadius.circular(4),
                                          // ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          );
                        },
                        logic.isZhuJiangSelect,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
