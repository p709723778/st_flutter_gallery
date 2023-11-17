import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/ministry_mark_page/controllers/ministry_mark_page_controller.dart';

class MinistryMarkPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MinistryMarkPageController>(
      () {
        return MinistryMarkPageController();
      },
    );
  }
}
