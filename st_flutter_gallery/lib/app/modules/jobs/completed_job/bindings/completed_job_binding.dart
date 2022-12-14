import 'package:get/get.dart';
import 'package:st/app/modules/jobs/completed_job/controllers/completed_job_controller.dart';

class CompletedJobBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompletedJobController>(
      CompletedJobController.new,
    );
  }
}
