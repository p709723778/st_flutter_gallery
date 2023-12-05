import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:st/app/modules/ministry_mark/recorder_params/recorder_params_set/recorder_params_set_logic.dart';
import 'package:st/utils/date_time/date_time_picker_util.dart';

class RecorderParamsSetPage extends StatelessWidget {
  const RecorderParamsSetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<RecorderParamsSetLogic>();

    return GetBuilder<RecorderParamsSetLogic>(
      init: logic,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                '记录仪参数设置',
                style: TextStyle(fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: logic.done,
                  child: const Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                ),
              ],
              centerTitle: true,
            ),
            body: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                ListTile(
                  title: Text(
                    logic.recorderInfo,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                TextField(
                  controller: logic.controllerCarNumber,
                  decoration: InputDecoration(
                    labelText: '机动车号牌号码',
                    hintText: "请输入机动车号牌号码",
                    hintStyle: const TextStyle(fontSize: 12),
                    labelStyle: const TextStyle(fontSize: 12),
                    suffixIcon: Checkbox(
                      value: logic.isSetCarNumber,
                      onChanged: (bool? value) {
                        logic
                          ..isSetCarNumber = value!
                          ..update();
                      },
                    ),
                    border: const OutlineInputBorder(
                      ///设置边框四个角的弧度
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: logic.controllerCarCategory,
                  decoration: InputDecoration(
                    labelText: '机动车号牌分类',
                    hintText: "请输入机动车号牌分类",
                    hintStyle: const TextStyle(fontSize: 12),
                    labelStyle: const TextStyle(fontSize: 12),
                    suffixIcon: Checkbox(
                      value: logic.isSetCarCategory,
                      onChanged: (bool? value) {
                        logic
                          ..isSetCarCategory = value!
                          ..update();
                      },
                    ),
                    border: const OutlineInputBorder(
                      ///设置边框四个角的弧度
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: logic.controllerVin,
                  decoration: InputDecoration(
                    labelText: 'VIN',
                    hintText: "请输入VIN",
                    hintStyle: const TextStyle(fontSize: 12),
                    labelStyle: const TextStyle(fontSize: 12),
                    suffixIcon: Checkbox(
                      value: logic.isSetVin,
                      onChanged: (bool? value) {
                        logic
                          ..isSetVin = value!
                          ..update();
                      },
                    ),
                    border: const OutlineInputBorder(
                      ///设置边框四个角的弧度
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: logic.controllerSerialNumber,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: '标识序列号',
                    hintText: "请输入标识序列号",
                    hintStyle: const TextStyle(fontSize: 12),
                    labelStyle: const TextStyle(fontSize: 12),
                    suffixIcon: Checkbox(
                      value: logic.isSetSerialNumber,
                      onChanged: (bool? value) {
                        logic
                          ..isSetSerialNumber = value!
                          ..update();
                      },
                    ),
                    border: const OutlineInputBorder(
                      ///设置边框四个角的弧度
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: logic.controllerImpulseCoefficient,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: '脉冲系数',
                    hintText: "请输入脉冲系数",
                    hintStyle: const TextStyle(fontSize: 12),
                    labelStyle: const TextStyle(fontSize: 12),
                    suffixIcon: Checkbox(
                      value: logic.isSetImpulseCoefficient,
                      onChanged: (bool? value) {
                        logic
                          ..isSetImpulseCoefficient = value!
                          ..update();
                      },
                    ),
                    border: const OutlineInputBorder(
                      ///设置边框四个角的弧度
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: ListTile(
                    title: Text(
                      '初次安装时间'.tr,
                      style: const TextStyle(fontSize: 14),
                    ),
                    contentPadding: const EdgeInsets.only(left: 10, right: 0),
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          logic.firstInstallDateTime == null
                              ? ''
                              : DateFormat(dateTimeFormat).format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                    logic.firstInstallDateTime!
                                        .millisecondsSinceEpoch,
                                  ),
                                ),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const Icon(Icons.keyboard_arrow_right),
                        Checkbox(
                          value: logic.isSetFirstInstallDate,
                          onChanged: (bool? value) {
                            logic
                              ..isSetFirstInstallDate = value!
                              ..update();
                          },
                        ),
                      ],
                    ),
                    onTap: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      DateTimePickerUtil.showDateTimePicker(
                        context,
                        onConfirm: (
                          DateTime dateTime,
                          List<int> selectedIndex,
                        ) {
                          logic.setInstallDate(dateTime);
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: logic.controllerSaltValue,
                  readOnly: true,
                  onTap: logic.copySaltValue,
                  decoration: InputDecoration(
                    labelText: '数据摘要salt值',
                    hintText: "数据摘要salt值",
                    hintStyle: const TextStyle(fontSize: 12),
                    labelStyle: const TextStyle(fontSize: 12),
                    suffixIcon: Checkbox(
                      value: logic.isSetSaltValue,
                      onChanged: (bool? value) {
                        logic
                          ..isSetSaltValue = value!
                          ..update();
                      },
                    ),
                    border: const OutlineInputBorder(
                      ///设置边框四个角的弧度
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
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
