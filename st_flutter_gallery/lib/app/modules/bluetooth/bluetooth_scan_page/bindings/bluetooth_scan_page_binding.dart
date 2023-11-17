import 'package:get/get.dart';
import 'package:st/app/modules/bluetooth/bluetooth_scan_page/controllers/bluetooth_scan_page_controller.dart';

class BluetoothScanPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BluetoothScanPageController>(
      () {
        return BluetoothScanPageController();
      },
    );
  }
}
