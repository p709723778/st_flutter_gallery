import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:st/app/models/data_record_file/data_record_file_get_req_model.dart';
import 'package:st/app/modules/ministry_mark/data_record_file/data_record_file_get_logic.dart';
import 'package:st/utils/date_time/date_time_picker_util.dart';

class DataRecordFileGetPage extends StatelessWidget {
  const DataRecordFileGetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<DataRecordFileGetLogic>();

    return GetBuilder<DataRecordFileGetLogic>(
      init: logic,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                '采集指定的数据记录文件',
                style: TextStyle(fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: logic.search,
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
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: ListTile(
                    title: Text(
                      '记录分类'.tr,
                      style: const TextStyle(fontSize: 14),
                    ),
                    trailing: DropdownButtonHideUnderline(
                      child: DropdownButton2<RecordFileType>(
                        isExpanded: true,
                        hint: const Text(
                          '请选择记录分类',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        iconStyleData: const IconStyleData(
                          iconDisabledColor: Colors.purple,
                          iconEnabledColor: Colors.purple,
                        ),
                        items: RecordFileType.values
                            .map(
                              (RecordFileType e) =>
                                  DropdownMenuItem<RecordFileType>(
                                value: e,
                                child: Text(
                                  e.title,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.purple,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        value: logic.recordFileType,
                        onChanged: logic.dropdownTypeChanged,
                        buttonStyleData: const ButtonStyleData(
                          height: 50,
                          width: 130,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: ListTile(
                    title: Text(
                      '开始时间'.tr,
                      style: const TextStyle(fontSize: 14),
                    ),
                    contentPadding: const EdgeInsets.only(left: 10, right: 0),
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          logic.startDateTime == null
                              ? ''
                              : DateFormat(dateTimeFormat).format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                    logic.startDateTime!.millisecondsSinceEpoch,
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
                        context,
                        onConfirm: (
                          DateTime dateTime,
                          List<int> selectedIndex,
                        ) {
                          logic.setStartDate(dateTime);
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: ListTile(
                    title: Text(
                      '结束时间'.tr,
                      style: const TextStyle(fontSize: 14),
                    ),
                    contentPadding: const EdgeInsets.only(left: 10, right: 0),
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          logic.endDateTime == null
                              ? ''
                              : DateFormat(dateTimeFormat).format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                    logic.endDateTime!.millisecondsSinceEpoch,
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
                        context,
                        onConfirm: (
                          DateTime dateTime,
                          List<int> selectedIndex,
                        ) {
                          logic.setEndDate(dateTime);
                        },
                      );
                    },
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
