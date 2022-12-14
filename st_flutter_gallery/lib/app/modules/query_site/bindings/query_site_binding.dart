import 'package:get/get.dart';
import 'package:st/app/modules/query_site/controllers/query_site_controller.dart';

class QuerySiteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuerySiteController>(
      QuerySiteController.new,
    );
  }
}
