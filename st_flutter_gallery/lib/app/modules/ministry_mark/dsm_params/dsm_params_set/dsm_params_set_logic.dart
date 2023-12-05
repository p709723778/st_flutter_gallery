import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/models/dsm_params_set/dsm_params_set_req_model.dart';
import 'package:st/app/models/dsm_params_set/dsm_params_set_resp_model.dart';
import 'package:st/app/models/video_url/video_url_get_req_model.dart';
import 'package:st/app/models/video_url/video_url_get_resp_model.dart';
import 'package:st/extension/string_extension.dart';

class DsmParamsSetLogic extends GetxController {
  late StreamSubscription _streamSubscription;

  final List<VideoUrlType> featureList = [];

  /// 当前选择下拉框的索引
  int dropdownIndex = VideoUrlType.dsm.value;

  late final mkPlayer = Player();

  late final videoController = VideoController(mkPlayer);

  DsmParamsSetRespModel? model;

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
        .on<DsmParamsSetRespModel>()
        .listen((event) {
      EasyLoading.dismiss();
      if (event.result == 0) {
        model = event;
        showToast('DSM标定成功');
        update();
      } else {
        showToast('DSM标定失败');
      }
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
    _streamSubscription.cancel();
    mkPlayer.dispose();
    super.onClose();
  }

  void done() {
    final reqModel = DsmParamsSetReqModel(
      dataBytes: [
        0x00,
        0x00,
      ],
    );
    SocketMessageManager.instance.sendMessage(reqModel.commandFrame);
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

  /// 设置视频源
  void setVideoDataSource(VideoUrlGetRespModel model) {
    mkPlayer.open(
      Media(
        model.url,
      ),
    );
  }

  /// 自检信息
  String get dsmParamsInfo {
    var text = '';

    if (model != null) {
      text += '偏转角(左正右负单位度): ${model!.angleDeflection}\n\n';
      text += '俯仰角(上正下负单位度): ${model!.anglePitch}\n\n';
      text += '检测区域左上 X 坐标: ${model!.checkX}\n\n';
      text += '检测区域左上 Y 坐标: ${model!.checkY}\n\n';
    } else {
      text += '偏转角(左正右负单位度): \n\n';
      text += '俯仰角(上正下负单位度): \n\n';
      text += '检测区域左上 X 坐标: \n\n';
      text += '检测区域左上 Y 坐标: \n\n';
    }
    return text;
  }
}
