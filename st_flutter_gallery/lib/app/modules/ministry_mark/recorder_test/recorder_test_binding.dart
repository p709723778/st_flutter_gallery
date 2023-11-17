import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/recorder_test/recorder_test_logic.dart';

class RecorderTestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(RecorderTestLogic.new);
  }
}
