import 'package:get/get.dart';
import 'package:st/app/modules/page_route_aware/controllers/page_route_aware_controller.dart';

class PageRouteAwareBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PageRouteAwareController>(
      PageRouteAwareController.new,
    );
  }
}
