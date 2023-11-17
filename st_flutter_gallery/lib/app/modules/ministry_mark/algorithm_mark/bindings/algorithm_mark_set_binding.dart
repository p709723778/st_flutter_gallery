import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/algorithm_mark/controllers/algorithm_mark_set_logic.dart';

class AlgorithmMarkSetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      return AlgorithmMarkSetLogic();
    });
  }
}
