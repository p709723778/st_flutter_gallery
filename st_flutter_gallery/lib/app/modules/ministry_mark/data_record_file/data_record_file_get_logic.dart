import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/models/data_record_file/data_record_file_get_req_model.dart';
import 'package:st/app/models/data_record_file/data_record_file_get_resp_model.dart';
import 'package:st/utils/bcd_data/bcd_data_util.dart';
import 'package:st/utils/byte/bytes_data_util.dart';

class DataRecordFileGetLogic extends GetxController {
  DateTime? startDateTime;
  DateTime? endDateTime;

  RecordFileType recordFileType = RecordFileType.logStatus;

  late StreamSubscription _streamSubscription;

  @override
  void onInit() {
    _streamSubscription = SocketMessageManager.instance
        .on<DataRecordFileGetRespModel>()
        .listen((event) {
      if (event.dataBytes.isNotEmpty) {
        showToast('采集指定的数据记录文件成功');
        update();
      } else {
        showToast('采集指定的数据记录文件失败');
      }
      EasyLoading.dismiss();
    });
    super.onInit();
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
    super.onClose();
  }

  void search() {
    if (startDateTime == null) {
      showToast('请选开始时间');
      return;
    }
    if (endDateTime == null) {
      showToast('请选结束时间');
      return;
    }

    final startDateTimeBytes =
        BcdDataUtil.getDeviceDateTimeBcdBytes(dateTime: startDateTime);

    final endDateTimeBytes =
        BcdDataUtil.getDeviceDateTimeBcdBytes(dateTime: endDateTime);

    final typeBytes = BytesDataUtil.intToU8Bytes(num: recordFileType.value);
    final dataBytes = [
      ...typeBytes,
      ...startDateTimeBytes,
      ...endDateTimeBytes,
    ];

    final reqModel = DataRecordFileGetReqModel(dataBytes: dataBytes);
    SocketMessageManager.instance.sendMessage(reqModel.commandFrame);
  }

  void dropdownTypeChanged(RecordFileType? value) {
    recordFileType = value!;
    update();
  }

  void setStartDate(DateTime date) {
    startDateTime = date;
    update();
  }

  void setEndDate(DateTime date) {
    endDateTime = date;
    update();
  }
}
