import 'package:get/get.dart';
import 'package:st/app/modules/query_work_face/controllers/query_work_face_controller.dart';

class QueryWorkFaceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QueryWorkFaceController>(
      QueryWorkFaceController.new,
    );
  }
}
