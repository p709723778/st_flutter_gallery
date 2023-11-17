import 'package:get/get.dart';
import 'package:st/app/modules/link_mode/bluetooth/bluetooth_scan_classic_page/bluetooth_scan_classic_page/bluetooth_scan_classic_page_logic.dart';

class BluetoothScanClassicPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BluetoothScanClassicPageLogic());
  }
}
