import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/data_record_file/data_record_file_get_logic.dart';

class DataRecordFileGetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DataRecordFileGetLogic());
  }
}
