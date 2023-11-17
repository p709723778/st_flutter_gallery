import 'package:get/get.dart';
import 'package:st/app/modules/link_mode/bluetooth/bluetooth_scan_classic_server_page/bluetooth_scan_classic_server_page_logic.dart';

class BluetoothScanClassicServerPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BluetoothScanClassicServerPageLogic());
  }
}
