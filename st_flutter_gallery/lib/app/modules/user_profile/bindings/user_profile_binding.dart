import 'package:get/get.dart';
import 'package:st/app/modules/user_profile/controllers/user_profile_controller.dart';

class UserProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProfileController>(
      UserProfileController.new,
    );
  }
}
