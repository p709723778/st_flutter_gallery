import 'package:get/get.dart';
import 'package:st/app/modules/jobs/replenishment_job/controllers/replenishment_job_controller.dart';

class ReplenishmentJobBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReplenishmentJobController>(
      ReplenishmentJobController.new,
    );
  }
}
