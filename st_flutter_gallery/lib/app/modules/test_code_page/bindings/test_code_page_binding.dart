import 'package:get/get.dart';
import 'package:st/app/modules/test_code_page/controllers/test_code_page_controller.dart';

class TestCodePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TestCodePageController>(
      () {
        return TestCodePageController();
      },
    );
  }
}
