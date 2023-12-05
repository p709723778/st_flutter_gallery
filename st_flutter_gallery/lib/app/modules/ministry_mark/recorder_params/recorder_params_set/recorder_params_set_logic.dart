import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/models/recorder_params/recorder_params_get_req_model.dart';
import 'package:st/app/models/recorder_params/recorder_params_get_resp_model.dart';
import 'package:st/app/models/recorder_params/recorder_params_set_req_model.dart';
import 'package:st/app/models/recorder_params/recorder_params_set_resp_model.dart';
import 'package:st/extension/string_extension.dart';
import 'package:st/helpers/logger/logger_helper.dart';
import 'package:st/utils/bcd_data/bcd_data_util.dart';
import 'package:st/utils/byte/byte_string_util.dart';
import 'package:st/utils/byte/bytes_data_util.dart';
import 'package:st/utils/encrypt/sm4_ebc.dart';
import 'package:st/utils/list/list_util.dart';

class RecorderParamsSetLogic extends GetxController {
  bool isSetCarNumber = false;
  bool isSetCarCategory = false;
  bool isSetVin = false;
  bool isSetSerialNumber = false;
  bool isSetImpulseCoefficient = false;
  bool isSetFirstInstallDate = false;
  bool isSetSaltValue = false;

  final TextEditingController controllerCarNumber = TextEditingController();
  final TextEditingController controllerCarCategory = TextEditingController();
  final TextEditingController controllerVin = TextEditingController();
  final TextEditingController controllerSerialNumber = TextEditingController();
  final TextEditingController controllerImpulseCoefficient =
      TextEditingController();
  final TextEditingController controllerSaltValue = TextEditingController();

  late StreamSubscription _streamSubscriptionSend;
  late StreamSubscription _streamSubscriptionReceive;

  /// 采集查询到的实体
  RecorderParamsGetRespModel? recorderParamsGetRespModel;

  /// 首次安装时间
  DateTime? firstInstallDateTime;

  late final List<int>? encryptOutArray;

  @override
  void onInit() {
    _streamSubscriptionReceive = SocketMessageManager.instance
        .on<RecorderParamsGetRespModel>()
        .listen((event) {
      if (event.fixedString.hasValue) {
        recorderParamsGetRespModel = event;
        logger.info(recorderParamsGetRespModel!.fixedString);

        controllerCarNumber.text = recorderParamsGetRespModel!.carNumber;
        controllerCarCategory.text = recorderParamsGetRespModel!.carCategory;
        controllerVin.text = recorderParamsGetRespModel!.vin;
        controllerSerialNumber.text = recorderParamsGetRespModel!.serialNumber;
        controllerImpulseCoefficient.text =
            recorderParamsGetRespModel!.impulseCoefficient.toString();

        final format = DateFormat("yy年MM月dd日HH时mm分ss秒");
        firstInstallDateTime =
            format.parse(recorderParamsGetRespModel!.firstInstallDate);
        _initSaltValue();
        showToast('采集记录仪信息成功');
        update();
      } else {
        showToast('采集记录仪信息失败');
      }
      EasyLoading.dismiss();
    });

    _streamSubscriptionSend = SocketMessageManager.instance
        .on<RecorderParamsSetRespModel>()
        .listen((event) {
      EasyLoading.dismiss();
      if (event.paramSetFlag > 0) {
        showToast('记录仪参数设置成功');
      } else {
        showToast('记录仪参数设置失败');
      }
      update();
    });
    search();

    super.onInit();
  }

  @override
  void onClose() {
    _streamSubscriptionSend.cancel();
    _streamSubscriptionReceive.cancel();
    controllerCarNumber.dispose();
    controllerCarCategory.dispose();
    controllerVin.dispose();
    controllerSerialNumber.dispose();
    controllerImpulseCoefficient.dispose();
    super.onClose();
  }

  void _initSaltValue() {
    /// 组装后的字节
    final saltRNBytes = [
      ...BytesDataUtil.convertFixedLenBytes(
        recorderParamsGetRespModel!
            .recorderUniqueNumberModel.manufacturerNameBytes,
        length: 2,
      ),
      ...BytesDataUtil.convertFixedLenBytes(
        recorderParamsGetRespModel!
            .recorderUniqueNumberModel.productNumberBytes,
        length: 3,
      ),
      ...BytesDataUtil.convertFixedLenBytes(
        recorderParamsGetRespModel!.recorderUniqueNumberModel.lineNumberBytes,
        length: 4,
      ),
      ...BytesDataUtil.convertFixedLenBytes(
        [],
        length: 7,
      ),
    ];

    final saltRNHexString = saltRNBytes
        .map(
          (int byte) => byte.toRadixString(16).padLeft(2, '0'),
        )
        .join();

    encryptOutArray = Sm4EBC.encryptOutArray(saltRNHexString);
    final encryptOutArrayHexString = encryptOutArray
        ?.map(
          (int byte) => byte.toRadixString(16).padLeft(2, '0'),
        )
        .join()
        .toUpperCase();

    controllerSaltValue.text = encryptOutArrayHexString ?? '';
  }

  void done() {
    var setFlagValue = 0x00;
    final carNumber = controllerCarNumber.text;
    final carCategory = controllerCarCategory.text;
    final vin = controllerVin.text;
    final serialNumber = controllerSerialNumber.text;
    final saltValue = controllerSaltValue.text;
    int? impulseCoefficient;
    if (controllerImpulseCoefficient.text.isNotEmpty) {
      impulseCoefficient = int.parse(controllerImpulseCoefficient.text);
    }

    if (carNumber.isEmpty &&
        carCategory.isEmpty &&
        vin.isEmpty &&
        serialNumber.isEmpty &&
        impulseCoefficient == null &&
        firstInstallDateTime == null &&
        saltValue.isEmpty) {
      showToast('请至少输入一项');
      return;
    }
    if (!isSetCarNumber &&
        !isSetCarCategory &&
        !isSetVin &&
        !isSetSerialNumber &&
        !isSetImpulseCoefficient &&
        !isSetFirstInstallDate &&
        !isSetSaltValue) {
      showToast('至少选择一项进行设置');
      return;
    }

    if (serialNumber.length > 12) {
      showToast('标识序列号长度不能超过12');
      return;
    }

    if (isSetCarNumber) {
      setFlagValue |= flag8;
    }
    if (isSetCarCategory) {
      setFlagValue |= flag7;
    }
    if (isSetVin) {
      setFlagValue |= flag6;
    }

    if (isSetImpulseCoefficient) {
      setFlagValue |= flag5;
    }

    if (isSetSerialNumber) {
      setFlagValue |= flag4;
    }

    if (isSetFirstInstallDate) {
      setFlagValue |= flag3;
    }

    if (isSetSaltValue) {
      setFlagValue |= flag2;
    }

    final flagValue = ByteData(1)..setUint8(0, setFlagValue);
    final flagValueBytes = flagValue.buffer.asUint8List();

    final recorderUniqueNumberBytes = recorderParamsGetRespModel
            ?.recorderUniqueNumberModel.recorderUniqueNumberBytes ??
        <int>[];

    final carNumberBytes =
        ByteStringUtil.convertFixedLenBytes(carNumber, length: 14);
    final carCategoryBytes = ByteStringUtil.convertFixedLenBytes(carCategory);
    final vinBytes = ListUtil.fixedLenList(vin.codeUnits, length: 17);

    final serialNumberBytes = BcdDataUtil.convertStringToBCD2(
      serialNumber,
      dataLength: 6,
      sumLength: 12,
    );
    final impulseCoefficientValue = ByteData(2)
      ..setUint16(0, (impulseCoefficient ?? 0));
    final impulseCoefficientBytes =
        impulseCoefficientValue.buffer.asUint8List();

    final installDateBytes =
        BcdDataUtil.getDeviceDateTimeBcdBytes(dateTime: firstInstallDateTime);

    if (encryptOutArray?.isEmpty ?? true) {
      encryptOutArray = List.filled(16, 0);
    }

    final dataBytes = [
      ...flagValueBytes,
      ...recorderUniqueNumberBytes,
      ...carNumberBytes,
      ...carCategoryBytes,
      ...vinBytes,
      ...serialNumberBytes,
      ...impulseCoefficientBytes,
      ...installDateBytes,
      ...encryptOutArray!,
    ];

    final reqModel = RecorderParamsSetReqModel(dataBytes: dataBytes);
    SocketMessageManager.instance.sendMessage(reqModel.commandFrame);
  }

  void search() {
    RecorderParamsGetReqModel.sendMessage();
  }

  String get recorderInfo {
    var text = '';

    text += '记录仪时间: ${recorderParamsGetRespModel?.recorderDate ?? ''}\n';
    text +=
        '生产认证代码: ${recorderParamsGetRespModel?.recorderUniqueNumberModel.authCode ?? ''}\n';
    text +=
        '认证产品型号: ${recorderParamsGetRespModel?.recorderUniqueNumberModel.authModelNumber ?? ''}\n';
    text +=
        '生产日期: ${recorderParamsGetRespModel?.recorderUniqueNumberModel.year ?? ''}年${recorderParamsGetRespModel?.recorderUniqueNumberModel.month ?? ''}月${recorderParamsGetRespModel?.recorderUniqueNumberModel.day ?? ''}日\n';
    text +=
        '生产流水号: ${recorderParamsGetRespModel?.recorderUniqueNumberModel.lineNumber ?? ''}\n';
    text +=
        '制造商名称简称: ${recorderParamsGetRespModel?.recorderUniqueNumberModel.manufacturerName ?? ''}\n';
    text +=
        '产品型号简称: ${recorderParamsGetRespModel?.recorderUniqueNumberModel.productNumber ?? ''}\n';

    return text;
  }

  void setInstallDate(DateTime date) {
    firstInstallDateTime = date;
    update();
  }

  void copySaltValue() {
    if (controllerSaltValue.text.noValue) return;
    Clipboard.setData(ClipboardData(text: controllerSaltValue.text ?? ''));
    showToast('复制内容成功');
  }
}
