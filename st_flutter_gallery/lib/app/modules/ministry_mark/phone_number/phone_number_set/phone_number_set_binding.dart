import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/phone_number/phone_number_set/phone_number_set_logic.dart';

class PhoneNumberSetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      return PhoneNumberSetLogic();
    });
  }
}
