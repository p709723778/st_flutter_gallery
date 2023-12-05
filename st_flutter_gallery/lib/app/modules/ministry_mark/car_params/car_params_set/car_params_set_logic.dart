import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/manager/area_city/area_city_manager.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/models/car_params/area_city_model.dart';
import 'package:st/app/models/car_params/car_params_get_req_model.dart';
import 'package:st/app/models/car_params/car_params_get_resp_model.dart';
import 'package:st/app/models/car_params/car_params_set_req_model.dart';
import 'package:st/app/models/car_params/car_params_set_resp_model.dart';
import 'package:st/utils/byte/byte_string_util.dart';

enum CarNumberColor {
  none(0, '未上牌'),
  blue(1, '蓝色'),
  yellow(2, '黄色'),
  black(3, '黑色'),
  white(4, '白色'),
  green(5, '绿色'),
  other(9, '其他');

  const CarNumberColor(this.value, this.title);

  final int value;

  final String title;

  static CarNumberColor fromString(int value) {
    return values.firstWhere(
      (v) => v.value == value,
      orElse: () => CarNumberColor.none,
    );
  }
}

class CarParamsSetLogic extends GetxController {
  /// 省列表
  final List<AreaCityModel> provinceList = [];

  /// 市列表
  final List<Districts> cityList = [];

  /// 当前选中的省份
  AreaCityModel? selectedAreaCityModel;

  /// 当前选择的城市
  Districts? selectedDistricts;

  CarNumberColor selectedCarNumberColor = CarNumberColor.none;

  late StreamSubscription _streamSubscription;

  final TextEditingController controllerManufacturerId =
      TextEditingController();
  final TextEditingController controllerTerminalMode = TextEditingController();
  final TextEditingController controllerTerminalId = TextEditingController();
  final TextEditingController controllerCarNumber = TextEditingController();

  @override
  Future<void> onInit() async {
    final list = await AreaCityManager.instance.getAreaCityData();
    provinceList
      ..clear()
      ..addAll(list.map((e) => AreaCityModel.fromJson(e)));

    selectedAreaCityModel = provinceList.first;
    cityList
      ..clear()
      ..addAll(selectedAreaCityModel?.districts ?? []);

    selectedDistricts = selectedAreaCityModel?.districts.first;

    _streamSubscription = SocketMessageManager.instance
        .on<CarParamsGetRespModel>()
        .listen((event) {
      if (event.dataBytes.isNotEmpty) {
        _loadData(event);
        showToast('车辆参数信息查询成功');
        update();
      } else {
        showToast('车辆参数信息查询失败');
      }
      EasyLoading.dismiss();
    });

    _streamSubscription = SocketMessageManager.instance
        .on<CarParamsSetRespModel>()
        .listen((event) {
      EasyLoading.dismiss();
      if (event.result == 0) {
        showToast('车辆参数信息设置成功');
      } else {
        showToast('车辆参数信息设置失败');
      }
    });
    update();
    search();
    super.onInit();
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
    controllerManufacturerId.dispose();
    controllerTerminalMode.dispose();
    controllerTerminalId.dispose();
    controllerCarNumber.dispose();

    super.onClose();
  }

  /// 查询成功后, 加载数据
  void _loadData(CarParamsGetRespModel model) {
    final province = provinceList.firstWhereOrNull((element) {
      if (int.parse(element.adcode.substring(0, 2)) == model.provinceId) {
        return true;
      }
      return false;
    });

    final city = province?.districts.firstWhereOrNull((element) {
      if (int.parse(element.adcode.substring(2, 6)) == model.cityId) {
        return true;
      }
      return false;
    });

    if (province != null) {
      selectedAreaCityModel = province;

      if (city != null) {
        cityList
          ..clear()
          ..addAll(province.districts);
        selectedDistricts = city;
      }
    }

    controllerManufacturerId.text = model.manufacturerId;
    controllerTerminalMode.text = model.terminalMode;
    controllerTerminalId.text = model.terminalId;
    controllerManufacturerId.text = model.manufacturerId;
    controllerCarNumber.text = model.carNumber;
    selectedCarNumberColor = CarNumberColor.fromString(model.carNumberColor);
  }

  void done() {
    if (selectedAreaCityModel == null || selectedDistricts == null) {
      showToast('请选择省市');
      return;
    }

    if (controllerManufacturerId.text.isEmpty) {
      showToast('请输入制造商ID(行政区划代码和制造商 ID 组成)');
      return;
    }

    if (controllerTerminalMode.text.isEmpty) {
      showToast('请输入终端型号');
      return;
    }

    if (controllerTerminalId.text.isEmpty) {
      showToast('请输入终端ID');
      return;
    }

    if (controllerCarNumber.text.isEmpty) {
      showToast('请输入车牌(如果未上牌则填车架号)');
      return;
    }

    final provinceId =
        int.parse(selectedAreaCityModel?.adcode.substring(0, 2) ?? '0');
    final cityId = int.parse(selectedDistricts?.adcode.substring(2, 6) ?? '0');
    final carNumberColor = selectedCarNumberColor.value;

    final manufacturerId = controllerManufacturerId.text;
    final terminalMode = controllerTerminalMode.text;
    final terminalId = controllerTerminalId.text;
    final carNumber = controllerCarNumber.text;

    final provinceIdBytes = ByteData(2)..setUint16(0, provinceId);
    final cityIdBytes = ByteData(2)..setUint16(0, cityId);

    final manufacturerIdBytes =
        ByteStringUtil.convertFixedLenBytes(manufacturerId, length: 11);
    final terminalModeBytes =
        ByteStringUtil.convertFixedLenBytes(terminalMode, length: 30);
    final terminalIdBytes =
        ByteStringUtil.convertFixedLenBytes(terminalId, length: 30);
    final carNumberColorBytes = ByteData(1)..setUint8(0, carNumberColor);
    final carNumberBytes =
        ByteStringUtil.convertFixedLenBytes(carNumber, length: 40);

    final dataBytes = [
      ...provinceIdBytes.buffer.asUint8List(),
      ...cityIdBytes.buffer.asUint8List(),
      ...manufacturerIdBytes,
      ...terminalModeBytes,
      ...terminalIdBytes,
      ...carNumberColorBytes.buffer.asUint8List(),
      ...carNumberBytes,
    ];

    final reqModel = CarParamsSetReqModel(dataBytes: dataBytes);
    SocketMessageManager.instance.sendMessage(reqModel.commandFrame);
  }

  Future<List> loadAndDecodeJson(String assetsPath) async {
    final jsonData = await rootBundle.loadString(assetsPath);
    return jsonDecode(jsonData);
  }

  void search() {
    SocketMessageManager.instance
        .sendMessage(CarParamsGetReqModel().commandFrame);
  }

  void dropdownProvinceChanged(AreaCityModel? value) {
    selectedAreaCityModel = value;
    cityList
      ..clear()
      ..addAll(selectedAreaCityModel?.districts ?? []);
    selectedDistricts = selectedAreaCityModel?.districts.first;
    update();
  }

  void dropdownCityChanged(Districts? value) {
    selectedDistricts = value;
    update();
  }

  void dropdownColorChanged(CarNumberColor? value) {
    selectedCarNumberColor = value!;
    update();
  }
}
