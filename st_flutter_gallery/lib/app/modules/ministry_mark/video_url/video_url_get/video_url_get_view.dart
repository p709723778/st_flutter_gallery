import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/constants/number_key.dart';
import 'package:st/app/models/video_url/video_url_get_req_model.dart';
import 'package:st/app/modules/ministry_mark/video_url/video_url_get/video_url_get_logic.dart';

class VideoUrlGetPage extends StatelessWidget {
  const VideoUrlGetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<VideoUrlGetLogic>();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetBuilder<VideoUrlGetLogic>(
        init: logic,
        builder: (logic) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                '视频url地址查询',
                style: TextStyle(fontSize: 16),
              ),
              centerTitle: true,
            ),
            body: ListView(
              controller: logic.scrollController,
              children: [
                AspectRatio(
                  aspectRatio: aspectRatio_H,
                  child: FijkView(
                    player: logic.player,
                    fs: false,
                  ),
                ),
                GridView.count(
                  controller: logic.scrollController,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                  children: logic.featureList.map((e) {
                    return item(e, logic);
                  }).toList(),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget item(VideoUrlType item, VideoUrlGetLogic logic) {
    return GestureDetector(
      onTap: () {
        logic.onTapItem(item);
      },
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Text(
          item.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
