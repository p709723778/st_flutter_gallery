import 'package:get/get.dart';
import 'package:st/app/modules/ministry_mark/data_summary_test/data_summary_test_logic.dart';

class DataSummaryTestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DataSummaryTestLogic());
  }
}
