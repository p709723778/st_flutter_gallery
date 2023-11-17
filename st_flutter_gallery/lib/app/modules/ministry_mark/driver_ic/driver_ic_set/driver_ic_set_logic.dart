import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/models/driver_ic/driver_ic_data_model.dart';
import 'package:st/app/models/driver_ic/driver_ic_get_req_model.dart';
import 'package:st/app/models/driver_ic/driver_ic_get_resp_model.dart';
import 'package:st/app/models/driver_ic/driver_ic_set_req_model.dart';
import 'package:st/app/models/driver_ic/driver_ic_set_resp_model.dart';

class DriverIcSetLogic extends GetxController {
  final TextEditingController controllerIcNo = TextEditingController();
  final TextEditingController controllerCertificateCode =
      TextEditingController();
  final TextEditingController controllerDriverName = TextEditingController();
  final TextEditingController controllerDriverNo = TextEditingController();
  final TextEditingController controllerOrganizationName =
      TextEditingController();
  final TextEditingController controllerIdCardNo = TextEditingController();

  late StreamSubscription _streamSubscription;

  /// 证件有效期
  DateTime? cerValidDate;

  @override
  void onInit() {
    _streamSubscription = SocketMessageManager.instance
        .on<DriverIcGetRespModel>()
        .listen((event) {
      EasyLoading.dismiss();

      if (event.driverIcDataModel?.dataBytes.isNotEmpty ?? false) {
        showToast('驾驶人IC卡查询成功');
        controllerIcNo.text = event.driverIcDataModel?.icNo ?? '';
        controllerCertificateCode.text =
            event.driverIcDataModel?.certificateCode ?? '';
        controllerDriverName.text = event.driverIcDataModel?.driverName ?? '';
        controllerDriverNo.text = event.driverIcDataModel?.driverNo ?? '';
        controllerOrganizationName.text =
            event.driverIcDataModel?.organizationName ?? '';
        controllerIdCardNo.text = event.driverIcDataModel?.idCardNo ?? '';
        cerValidDate = event.driverIcDataModel?.cerValidDate;
        update();
      } else {
        showToast('驾驶人IC卡查询失败');
      }
    });

    _streamSubscription = SocketMessageManager.instance
        .on<DriverIcSetRespModel>()
        .listen((event) {
      EasyLoading.dismiss();
      if (event.result == 0) {
        showToast('驾驶人IC卡设置成功');
      } else {
        showToast('驾驶人IC卡设置失败');
      }
      update();
    });

    search();

    super.onInit();
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
    super.onClose();
  }

  void search() {
    final model = DriverIcGetReqModel(dataBytes: []);
    SocketMessageManager.instance.sendMessage(model.commandFrame);
  }

  void done() {
    final driverNo = controllerDriverNo.text;
    final driverName = controllerDriverName.text;

    if (driverName.isEmpty) {
      showToast('请输入驾驶人姓名');
      return;
    }

    if (driverNo.isEmpty) {
      showToast('请输入机动车驾驶证号码');
      return;
    }

    final driverIcDataModel = DriverIcDataModel.fromJson(
      icNo: controllerIcNo.text,
      certificateCode: controllerCertificateCode.text,
      driverNo: driverNo,
      driverName: driverName,
      organizationName: controllerOrganizationName.text,
      cerValidDate: cerValidDate,
      idCardNo: controllerIdCardNo.text,
    );

    final model = DriverIcSetReqModel(
      dataBytes: driverIcDataModel.dataBytes,
    );
    SocketMessageManager.instance.sendMessage(model.commandFrame);
  }

  void setCerValidDate(DateTime date) {
    cerValidDate = date;
    update();
  }
}
