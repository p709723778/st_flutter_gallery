import 'package:get/get.dart';
import 'package:st/app/modules/bluetooth/bluetooth_device_page/bluetooth_device_page_logic.dart';

class BluetoothDevicePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      return BluetoothDevicePageLogic();
    });
  }
}
