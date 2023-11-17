import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/video_url/video_url_get/video_url_get_logic.dart';

class VideoUrlGetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      return VideoUrlGetLogic();
    });
  }
}
