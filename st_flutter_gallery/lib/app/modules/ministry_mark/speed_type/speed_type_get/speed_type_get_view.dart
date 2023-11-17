import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/speed_type/speed_type_get/speed_type_get_logic.dart';
import 'package:video_player/video_player.dart';

class SpeedTypeGetPage extends StatelessWidget {
  const SpeedTypeGetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<SpeedTypeGetLogic>();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetBuilder<SpeedTypeGetLogic>(
        init: logic,
        builder: (logic) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                '基本参数设置',
                style: TextStyle(fontSize: 16),
              ),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (logic.videoPlayerController!.value.isPlaying) {
                  logic.videoPlayerController!.pause();
                } else {
                  logic.videoPlayerController!.play();
                }
                logic.update();
              },
              child: Icon(
                logic.videoPlayerController!.value.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow,
              ),
            ),
            body: ListView(
              children: ListTile.divideTiles(
                color: Colors.grey, // 分割线的颜色
                tiles: [
                  FutureBuilder(
                    future: logic.initializeVideoPlayerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return AspectRatio(
                          aspectRatio:
                              logic.videoPlayerController!.value.aspectRatio,
                          child: VideoPlayer(logic.videoPlayerController!),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ).toList(),
            ),
          );
        },
      ),
    );
  }
}
