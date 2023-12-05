import 'dart:async';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/models/video_url/video_url_get_req_model.dart';
import 'package:st/app/models/video_url/video_url_get_resp_model.dart';
import 'package:st/extension/string_extension.dart';

class VideoUrlGetLogic extends GetxController {
  String? url;
  final FijkPlayer player = FijkPlayer();

  final List<VideoUrlType> featureList = [];

  final ScrollController scrollController = ScrollController();
  late StreamSubscription _streamSubscription;

  @override
  void onInit() {
    _streamSubscription = SocketMessageManager.instance
        .on<VideoUrlGetRespModel>()
        .listen((event) {
      if (event.url.hasValue) {
        EasyLoading.dismiss();
        showToast('查询成功');
        update();
      }
    });
    featureList.addAll(
      VideoUrlType.values,
    );

    setVideoDataSource(null);

    update();
    super.onInit();
  }

  void setVideoDataSource(VideoUrlGetRespModel? model) {
    // url = 'http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8';
    url = 'rtsp://192.168.80.1:555/live';
    player.setDataSource(url!, autoPlay: true, showCover: true);
  }

  void setVideoDataSource1(String url) {
    // url = 'http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8';
    // url = 'rtsp://192.168.80.1:555/live';
    player.setDataSource(url, autoPlay: true, showCover: true);
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
    scrollController.dispose();
    player.dispose();
    super.onClose();
  }

  /// 发送命令
  Future<void> onTapItem(VideoUrlType type) async {
    await player.reset();

    if (type == VideoUrlType.adas) {
      url = 'rtsp://192.168.80.1:554/live';
      await player.setDataSource(url!, autoPlay: false, showCover: false);
    } else if (type == VideoUrlType.bsd) {
      url = 'rtsp://192.168.80.1:556/live';
      await player.setDataSource(url!, autoPlay: false, showCover: false);
    }
    if (type == VideoUrlType.dsm) {
      url = 'rtsp://192.168.80.1:555/live';
      await player.setDataSource(url!, autoPlay: false, showCover: false);
    }
    await player.start();
    // player.pause();
    // final reqModel = VideoUrlGetReqModel(dataBytes: [type.value]);
    // SocketMessageManager.instance.sendMessage(reqModel.commandFrame);
  }
}
