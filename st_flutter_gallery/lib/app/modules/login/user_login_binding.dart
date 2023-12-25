import 'package:get/get.dart';
import 'package:st/app/modules/login/user_login_logic.dart';

class UserLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserLoginLogic());
  }
}
