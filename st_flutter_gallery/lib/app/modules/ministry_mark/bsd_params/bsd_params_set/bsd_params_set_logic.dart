import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/models/algorithm_mark_model/algorithm_mark_set_req_model.dart';
import 'package:st/app/models/bsd_params_set/bsd_params_set_req_model.dart';
import 'package:st/app/models/bsd_params_set/bsd_params_set_resp_model.dart';
import 'package:st/app/models/video_url/video_url_get_req_model.dart';
import 'package:st/app/models/video_url/video_url_get_resp_model.dart';
import 'package:st/extension/string_extension.dart';
import 'package:st/utils/resolution_ratio_xy/resolution_ratio_xy_util.dart';

class BsdParamsSetLogic extends GetxController {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();
  final TextEditingController controller5 = TextEditingController();
  late StreamSubscription _streamSubscription;

  // FijkPlayer player = FijkPlayer();
  final ScrollController scrollController = ScrollController();

  final List<VideoUrlType> featureList = [];

  /// 当前选择下拉框的索引
  int dropdownIndex = VideoUrlType.bsd.value;

  late final mkPlayer = Player();
  // Create a [VideoController] to handle video output from [Player].
  late final videoController = VideoController(mkPlayer);

  List<Offset> rectangleA = [];
  List<Offset> rectangleB = [];
  List<Offset> rectangleC = [];

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
        .on<BSDParamsSetRespModel>()
        .listen((event) {
      EasyLoading.dismiss();
      if (event.result == 0) {
        rectangleA.clear();
        rectangleB.clear();
        rectangleC.clear();
        final ratioType =
            VideoResolutionRatioType.fromString(event.coordinateType);
        final screenWidth = Get.width;
        final screenHeight =
            ResolutionRatioUtil.convertHeight(viewWidth: screenWidth.toInt());

        event.getRectangleA().forEach((element) {
          final offset = ResolutionRatioUtil.convertXY(
            type: ratioType,
            offset: element,
            size: Size(screenWidth, screenHeight.toDouble()),
          );
          rectangleA.add(offset);
        });

        event.getRectangleB().forEach((element) {
          final offset = ResolutionRatioUtil.convertXY(
            type: ratioType,
            offset: element,
            size: Size(screenWidth, screenHeight.toDouble()),
          );
          rectangleB.add(offset);
        });

        event.getRectangleC().forEach((element) {
          final offset = ResolutionRatioUtil.convertXY(
            type: ratioType,
            offset: element,
            size: Size(screenWidth, screenHeight.toDouble()),
          );
          rectangleC.add(offset);
        });
        showToast('BSD标定成功');
      } else {
        showToast('BSD标定失败');
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
    // player
    //   ..release()
    //   ..stop()
    //   ..dispose();
    // player = FijkPlayer();

    // if ((dropdownIndex % 2) == 0) {
    //   mkPlayer.open(
    //     Media(
    //       'https://user-images.githubusercontent.com/28951144/229373695-22f88f13-d18f-4288-9bf1-c3e078d83722.mp4',
    //     ),
    //   );
    //
    //   // player.setDataSource(
    //   //   'rtsp://example.com/live/stream',
    //   //   autoPlay: true,
    //   //   showCover: true,
    //   // );
    // } else {
    //   mkPlayer.open(
    //     Media(
    //       'http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8',
    //     ),
    //   );
    //   // player.setDataSource(
    //   //   'http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8',
    //   //   autoPlay: true,
    //   //   showCover: true,
    //   // );
    // }
    update();
  }

  //打开BSD辅助线
  void openBsdLine() {
    AlgorithmMarkSetReqModel.sendCommand(AlgorithmMarkType.openBSD);
    // SocketMessageManager.instance.sendMessage(
    //   AlgorithmMarkSetReqModel(dataBytes: [AlgorithmMarkType.openBSD.value])
    //       .commandFrame,
    // );
  }

  //清除辅助线
  void clearBsdLine() {
    AlgorithmMarkSetReqModel.sendCommand(AlgorithmMarkType.clearLine);

    rectangleA.clear();
    rectangleB.clear();
    rectangleC.clear();

    update();
    // SocketMessageManager.instance.sendMessage(
    //   AlgorithmMarkSetReqModel(dataBytes: [AlgorithmMarkType.clearLine.value])
    //       .commandFrame,
    // );
  }

  /// 设置视频源
  void setVideoDataSource(VideoUrlGetRespModel model) {
    mkPlayer.open(
      Media(
        model.url,
      ),
    );

    // url = 'http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8';
    // player.setDataSource(model.url, autoPlay: true, showCover: true);
  }

  /// 标定
  void done() {
    final integerRegex = RegExp(r'^[+-]?\d+$');

    if (controller1.text.noValue || !integerRegex.hasMatch(controller1.text)) {
      showToast('请输入摄像头安装高度');
      return;
    }

    if (controller2.text.noValue || !integerRegex.hasMatch(controller2.text)) {
      showToast('请输入一级报警距离');
      return;
    }

    if (controller3.text.noValue || !integerRegex.hasMatch(controller3.text)) {
      showToast('请输入二级报警距离');
      return;
    }

    if (controller4.text.noValue || !integerRegex.hasMatch(controller4.text)) {
      showToast('请输入三级报警距离');
      return;
    }

    if (controller5.text.noValue || !integerRegex.hasMatch(controller5.text)) {
      showToast('请输入前方报警距离');
      return;
    }

    final installHeight = int.parse(controller1.text);
    final alarm1 = int.parse(controller2.text);
    final alarm2 = int.parse(controller3.text);
    final alarm3 = int.parse(controller4.text);
    final beforeAlarm = int.parse(controller5.text);

    /// 摄像头安装高度（mm）
    final installHeightByteData = ByteData(2)..setUint16(0, installHeight);

    /// 一级报警距离（mm）
    final alarm1ByteData = ByteData(2)..setUint16(0, alarm1);

    /// 二级报警距离（mm）
    final alarm2ByteData = ByteData(2)..setUint16(0, alarm2);

    /// 三级报警距离（mm）
    final alarm3ByteData = ByteData(2)..setUint16(0, alarm3);

    /// 前方报警距离（mm）
    final beforeAlarmByteData = ByteData(2)..setUint16(0, beforeAlarm);

    final data = [
      ...installHeightByteData.buffer.asUint8List(),
      ...alarm1ByteData.buffer.asUint8List(),
      ...alarm2ByteData.buffer.asUint8List(),
      ...alarm3ByteData.buffer.asUint8List(),
      ...beforeAlarmByteData.buffer.asUint8List(),
    ];

    final reqModel = BSDParamsSetReqModel(dataBytes: data);
    SocketMessageManager.instance.sendMessage(reqModel.commandFrame);
  }
}
