import 'package:get/get.dart';
import 'package:st/app/modules/query_site_number/controllers/query_site_number_controller.dart';

class QuerySiteNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuerySiteNumberController>(
      QuerySiteNumberController.new,
    );
  }
}
