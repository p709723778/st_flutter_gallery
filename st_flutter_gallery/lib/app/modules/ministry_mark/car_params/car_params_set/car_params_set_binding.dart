import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/car_params/car_params_set/car_params_set_logic.dart';

class CarParamsSetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      return CarParamsSetLogic();
    });
  }
}
