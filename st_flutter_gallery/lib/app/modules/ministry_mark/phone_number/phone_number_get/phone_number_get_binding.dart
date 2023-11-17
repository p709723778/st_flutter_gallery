import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/phone_number/phone_number_get/phone_number_get_logic.dart';

class PhoneNumberGetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhoneNumberGetLogic());
  }
}
