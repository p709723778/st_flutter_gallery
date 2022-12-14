import 'package:get/get.dart';
import 'package:st/app/modules/jobs/start_job_page/controllers/start_job_page_controller.dart';

class StartJobPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StartJobPageController>(
      StartJobPageController.new,
    );
  }
}
