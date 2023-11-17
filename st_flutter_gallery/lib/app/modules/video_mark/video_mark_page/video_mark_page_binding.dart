import 'package:get/get.dart';
import 'package:st/app/modules/video_mark/video_mark_page/video_mark_page_logic.dart';

class VideoMarkPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      return VideoMarkPageLogic();
    });
  }
}
