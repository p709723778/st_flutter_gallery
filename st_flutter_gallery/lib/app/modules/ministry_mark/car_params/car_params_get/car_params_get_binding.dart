import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/car_params/car_params_get/car_params_get_logic.dart';

class CarParamsGetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      return CarParamsGetLogic();
    });
  }
}
