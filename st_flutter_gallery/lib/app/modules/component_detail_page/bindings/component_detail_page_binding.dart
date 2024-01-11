import 'package:get/get.dart';
import 'package:st/app/modules/component_detail_page/controllers/component_detail_page_controller.dart';

class ComponentDetailPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComponentDetailPageController>(
      () {
        return ComponentDetailPageController();
      },
    );
  }
}
