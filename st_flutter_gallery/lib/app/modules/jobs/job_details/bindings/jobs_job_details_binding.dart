import 'package:get/get.dart';
import 'package:st/app/modules/jobs/job_details/controllers/jobs_job_details_controller.dart';

class JobsJobDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JobsJobDetailsController>(
      JobsJobDetailsController.new,
    );
  }
}
