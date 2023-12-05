import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/models/adas_params_set/adas_params_set_req_model.dart';
import 'package:st/app/models/adas_params_set/adas_params_set_resp_model.dart';
import 'package:st/app/models/algorithm_mark_model/algorithm_mark_set_req_model.dart';
import 'package:st/app/models/video_url/video_url_get_req_model.dart';
import 'package:st/app/models/video_url/video_url_get_resp_model.dart';
import 'package:st/extension/string_extension.dart';

class AdasParamsSetLogic extends GetxController {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();
  final TextEditingController controller5 = TextEditingController();
  final TextEditingController controller6 = TextEditingController();
  final TextEditingController controller7 = TextEditingController();
  final TextEditingController controller8 = TextEditingController();

  late StreamSubscription _streamSubscription;

  final ScrollController scrollController = ScrollController();

  final List<VideoUrlType> featureList = [];

  /// 当前选择下拉框的索引
  int dropdownIndex = VideoUrlType.adas.value;

  late final mkPlayer = Player();
  // Create a [VideoController] to handle video output from [Player].
  late final videoController = VideoController(mkPlayer);

  @override
  Future<void> onInit() async {
    featureList.addAll(VideoUrlType.values);

    if (mkPlayer.platform is NativePlayer) {
      // https://mpv.io/manual/master/#encoding
      final nativePlayer = mkPlayer.platform! as NativePlayer;
      // 低延迟配置
      await nativePlayer.setProperty('profile', 'low-latency');
      await nativePlayer.setProperty('show-profile', 'low-latency');
    }

    _streamSubscription = SocketMessageManager.instance
        .on<AdasParamsSetRespModel>()
        .listen((event) {
      EasyLoading.dismiss();
      if (event.result == 0) {
        showToast('ADAS标定成功');
      } else {
        showToast('ADAS标定失败');
      }
      update();
    });

    _streamSubscription = SocketMessageManager.instance
        .on<VideoUrlGetRespModel>()
        .listen((event) {
      if (event.url.hasValue) {
        setVideoDataSource(event);
        EasyLoading.dismiss();
        showToast('视频地址获取成功');
        update();
      }
    });

    getVideoUrl();
    super.onInit();
  }

  @override
  void onClose() {
    mkPlayer.dispose();
    _streamSubscription.cancel();
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();
    controller6.dispose();
    controller7.dispose();
    controller8.dispose();
    scrollController.dispose();
    super.onClose();
  }

  /// 获取视频url
  void getVideoUrl() {
    if (SocketMessageManager.instance.linkType != LinkType.tcp) return;
    SocketMessageManager.instance.sendMessage(
      VideoUrlGetReqModel(dataBytes: [dropdownIndex]).commandFrame,
      isToast: false,
    );
  }

  /// 下拉框选择
  void dropdownChanged(Object? index) {
    final i = index! as int;
    dropdownIndex = i;
    getVideoUrl();

    update();
  }

  //打开ADAS辅助线
  void openAdasLine() {
    AlgorithmMarkSetReqModel.sendCommand(AlgorithmMarkType.openADAS);
  }

  //清除辅助线
  void clearBsdLine() {
    AlgorithmMarkSetReqModel.sendCommand(AlgorithmMarkType.clearLine);
  }

  /// 设置视频源
  void setVideoDataSource(VideoUrlGetRespModel model) {
    mkPlayer.open(
      Media(
        model.url,
      ),
    );
  }

  void done() {
    final integerRegex = RegExp(r'^[+-]?\d+$');

    final decimalRegExp = RegExp(r'^[-+]?[0-9]*\.?[0-9]+$');

    if (controller1.text.noValue || !integerRegex.hasMatch(controller1.text)) {
      showToast('请输入车宽');
      return;
    }

    if (controller2.text.noValue || !integerRegex.hasMatch(controller2.text)) {
      showToast('请输入相机与车辆中间的距离');
      return;
    }

    if (controller3.text.noValue || !integerRegex.hasMatch(controller3.text)) {
      showToast('请输入相机到前保险杠距离');
      return;
    }

    if (controller4.text.noValue || !integerRegex.hasMatch(controller4.text)) {
      showToast('请输入镜头和车胎之间的距离');
      return;
    }

    if (controller5.text.noValue || !integerRegex.hasMatch(controller5.text)) {
      showToast('请输入相机距离地面高度');
      return;
    }

    if (controller6.text.hasValue) {
      if (!decimalRegExp.hasMatch(controller6.text) &&
          !integerRegex.hasMatch(controller6.text)) {
        showToast('请输入正确的相机焦距');
        return;
      }
    }

    if (controller7.text.hasValue) {
      if (!decimalRegExp.hasMatch(controller7.text) &&
          !integerRegex.hasMatch(controller7.text)) {
        showToast('请输入正确的sensor尺寸');
        return;
      }
    }

    if (controller8.text.noValue || !integerRegex.hasMatch(controller8.text)) {
      showToast('请输入车长');
      return;
    }
    final carWidth = int.parse(controller1.text);
    final cameraAndVehicle = int.parse(controller2.text);
    final cameraBeforeArrives = int.parse(controller3.text);
    final lensAndFrontTire = int.parse(controller4.text);
    final cameraGroundHeight = int.parse(controller5.text);
    final cameraFocal =
        double.parse(controller6.text.hasValue ? controller6.text : '0');
    final sensor =
        double.parse(controller7.text.hasValue ? controller7.text : '0');
    final carChief = int.parse(controller8.text);

    /// 车宽（mm）
    final carWidthByteData = ByteData(2)..setUint16(0, carWidth);

    /// 相机与车辆中心之间的距离(从驾驶室往外看，左正右负)（mm）
    final cameraAndVehicleByteData = ByteData(2)
      ..setUint16(0, cameraAndVehicle);

    /// 相机到前保险杠距离（mm）
    final alarm2ByteData = ByteData(2)..setUint16(0, cameraBeforeArrives);

    /// 镜头和前轮胎之间距离（mm）
    final lensAndFrontTireByteData = ByteData(2)..setInt16(0, lensAndFrontTire);

    /// 相机距离地面高度（mm）
    final cameraGroundHeightByteData = ByteData(2)
      ..setUint16(0, cameraGroundHeight);

    /// 相机焦距
    final cameraFocalByteData = ByteData(4)..setFloat32(0, cameraFocal);

    /// sensor尺寸
    final sensorByteData = ByteData(4)..setFloat32(0, sensor);

    /// 车长
    final carChiefByteData = ByteData(2)..setUint16(0, carChief);
    final data = [
      ...carWidthByteData.buffer.asUint8List(),
      ...cameraAndVehicleByteData.buffer.asUint8List(),
      ...alarm2ByteData.buffer.asUint8List(),
      ...lensAndFrontTireByteData.buffer.asUint8List(),
      ...cameraGroundHeightByteData.buffer.asUint8List(),
      ...cameraFocalByteData.buffer.asUint8List(),
      ...sensorByteData.buffer.asUint8List(),
      ...carChiefByteData.buffer.asUint8List(),
    ];

    SocketMessageManager.instance
        .sendMessage(AdasParamsSetReqModel(dataBytes: data).commandFrame);
  }
}
