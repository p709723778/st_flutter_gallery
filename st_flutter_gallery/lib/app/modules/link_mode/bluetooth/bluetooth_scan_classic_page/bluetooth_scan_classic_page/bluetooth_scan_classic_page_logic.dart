import 'dart:async';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:st/utils/snackbar/snack_bar_util.dart';

class BluetoothScanClassicPageLogic extends GetxController {
  static const int BluetoothOffView_ID = 1;
  static const int BluetoothScanListView_ID = 2;

  late final bool start = true;

  StreamSubscription<BluetoothDiscoveryResult>? _streamSubscription;
  List<BluetoothDiscoveryResult> results =
      List<BluetoothDiscoveryResult>.empty(growable: true);
  bool isDiscovering = false;

  BluetoothState bluetoothState = BluetoothState.UNKNOWN;

  /// 是否过滤未命名的
  bool isFilterNoName = true;

  /// 是否过滤不可连接的
  bool isFilterNotConnectable = false;

  List<BluetoothDiscoveryResult> bondedDevices =
      List<BluetoothDiscoveryResult>.empty(growable: true);

  List<BluetoothDiscoveryResult> notBondDevices =
      List<BluetoothDiscoveryResult>.empty(growable: true);

  @override
  void onInit() {
    FlutterBluetoothSerial.instance.state.then((state) {
      bluetoothState = state;
      update([BluetoothOffView_ID]);
    });

    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      bluetoothState = state;
      update([BluetoothOffView_ID]);
    });

    isDiscovering = start;
    if (isDiscovering) {
      _startDiscovery();
    }

    super.onInit();
  }

  Future<void> _startDiscovery() async {
    await FlutterBluetoothSerial.instance.requestEnable();
    _streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      // final existingIndex = results.indexWhere(
      //   (element) => element.device.address == r.device.address,
      // );

      final existingBondedIndex = bondedDevices.indexWhere(
        (element) => element.device.address == r.device.address,
      );

      final existingNotBondDevicesIndex = notBondDevices.indexWhere(
        (element) => element.device.address == r.device.address,
      );

      if (r.device.name?.isEmpty ?? true && isFilterNoName) {
      } else {
        if (r.device.isBonded) {
          if (existingBondedIndex >= 0) {
            bondedDevices[existingBondedIndex] = r;
          } else {
            bondedDevices.add(r);
          }
        } else {
          if (existingNotBondDevicesIndex >= 0) {
            notBondDevices[existingNotBondDevicesIndex] = r;
          } else {
            notBondDevices.add(r);
          }
        }
      }

      update([BluetoothScanListView_ID]);
    });

    _streamSubscription!.onDone(() {
      isDiscovering = false;
      update([BluetoothScanListView_ID]);
    });
  }

  void updateListView() {
    update([BluetoothScanListView_ID]);
  }

  void _restartDiscovery() {
    results.clear();
    bondedDevices.clear();
    notBondDevices.clear();
    isDiscovering = true;
    update();
    _startDiscovery();
  }

  Future<void> requestEnable() async {
    await FlutterBluetoothSerial.instance.requestEnable();
  }

  Future<void> requestDisable() async {
    await FlutterBluetoothSerial.instance.requestDisable();
  }

  Future onScanPressed() async {
    try {
      if (isDiscovering) return;
      _restartDiscovery();
    } catch (e) {
      SnackBarUtil.show(
        ABC.b,
        prettyException("Start Scan Error:", e),
        success: false,
      );
    }
    update(
      [BluetoothScanListView_ID],
    ); // force refresh of connectedSystemDevices
  }

  void onRefresh() {
    onScanPressed();
  }

  @override
  void onClose() {
    _streamSubscription?.cancel();
    super.onClose();
  }
}
