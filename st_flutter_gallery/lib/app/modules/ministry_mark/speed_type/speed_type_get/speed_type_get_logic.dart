import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class SpeedTypeGetLogic extends GetxController {
  VideoPlayerController? videoPlayerController;
  late Future<void> initializeVideoPlayerFuture;

  @override
  void onInit() {
    final uri = Uri.parse(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );
    videoPlayerController = VideoPlayerController.networkUrl(
      uri,
    );
    initializeVideoPlayerFuture = videoPlayerController!.initialize();
    videoPlayerController!.setLooping(true);

    super.onInit();
  }

  @override
  void onClose() {
    videoPlayerController?.dispose();
    super.onClose();
  }
}
