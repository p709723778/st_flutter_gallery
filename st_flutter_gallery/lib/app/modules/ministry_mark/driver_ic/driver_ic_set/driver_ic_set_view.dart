import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:st/app/modules/ministry_mark/driver_ic/driver_ic_set/driver_ic_set_logic.dart';
import 'package:st/utils/date_time/date_time_picker_util.dart';

class DriverIcSetPage extends StatelessWidget {
  const DriverIcSetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<DriverIcSetLogic>();

    return GetBuilder<DriverIcSetLogic>(
      init: logic,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                '驾驶人IC卡写卡设置',
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
              padding: const EdgeInsets.all(20),
              children: [
                TextField(
                  controller: logic.controllerIcNo,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'IC卡号',
                    hintText: "请输入IC卡号",
                    border: OutlineInputBorder(
                      ///设置边框四个角的弧度
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: logic.controllerCertificateCode,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: '从业资格证编码',
                    hintText: "请输入从业资格证编码",
                    border: OutlineInputBorder(
                      ///设置边框四个角的弧度
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: logic.controllerDriverName,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: '驾驶人姓名',
                    hintText: "请输入驾驶人姓名",
                    border: OutlineInputBorder(
                      ///设置边框四个角的弧度
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: logic.controllerDriverNo,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: '机动车驾驶证号码',
                    hintText: "请输入机动车驾驶证号码",
                    border: OutlineInputBorder(
                      ///设置边框四个角的弧度
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: logic.controllerOrganizationName,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: '发证机构名称',
                    hintText: "请输入发证机构名称",
                    border: OutlineInputBorder(
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
                      '证件有效期'.tr,
                      style: const TextStyle(fontSize: 14),
                    ),
                    contentPadding: const EdgeInsets.only(left: 10),
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          logic.cerValidDate == null
                              ? ''
                              : DateFormat(dateTimeFormatCer).format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                    logic.cerValidDate!.millisecondsSinceEpoch,
                                  ),
                                ),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const Icon(Icons.keyboard_arrow_right),
                      ],
                    ),
                    onTap: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      DateTimePickerUtil.showDateTimePicker(
                        dateFormat: dateTimeFormatCer,
                        context,
                        onConfirm: (
                          DateTime dateTime,
                          List<int> selectedIndex,
                        ) {
                          logic.setCerValidDate(dateTime);
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: logic.controllerIdCardNo,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: '身份证号码',
                    hintText: "请输入身份证号码",
                    border: OutlineInputBorder(
                      ///设置边框四个角的弧度
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
