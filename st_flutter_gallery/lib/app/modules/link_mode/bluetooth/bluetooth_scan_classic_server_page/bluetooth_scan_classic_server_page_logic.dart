import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/manager/bluetooth_socket_classic_server_manager.dart';

class BluetoothScanClassicServerPageLogic extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> scan() async {
    if (BluetoothSocketClassicServerManager.instance.isScanning) {
      showToast('蓝牙服务器模式已经为开启状态,待设备加入');
      return;
    }
    BluetoothSocketClassicServerManager.instance.isScanning = true;
    await BluetoothSocketClassicServerManager.instance.connectServer();
    update();
  }

  void disconnect() {
    BluetoothSocketClassicServerManager.instance.disconnect();
    BluetoothSocketClassicServerManager.instance.isConnect = false;
    BluetoothSocketClassicServerManager.instance.isScanning = false;
    update();
  }

  bool get isConnected =>
      BluetoothSocketClassicServerManager.instance.isConnect;

  bool get isScanning =>
      BluetoothSocketClassicServerManager.instance.isScanning;

  String get connectDeviceName {
    return BluetoothSocketClassicServerManager.instance.bluetoothDevice?.name ??
        '';
  }
}
