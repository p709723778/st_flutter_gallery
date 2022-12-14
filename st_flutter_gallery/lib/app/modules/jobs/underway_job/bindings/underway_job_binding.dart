import 'package:get/get.dart';
import 'package:st/app/modules/jobs/underway_job/controllers/underway_job_controller.dart';

class UnderwayJobBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UnderwayJobController>(
      UnderwayJobController.new,
    );
  }
}
