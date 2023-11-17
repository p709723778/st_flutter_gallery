import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:just_throttle_it/just_throttle_it.dart';
import 'package:st/app/manager/bluetooth_socket_manager.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/utils/snackbar/snack_bar_util.dart';

class BluetoothScanPageController extends GetxController {
  static const int BluetoothOffView_ID = 1;
  static const int BluetoothScanListView_ID = 2;

  List<BluetoothDevice> connectedDevices = [];
  List<ScanResult> scanResults = [];
  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  late StreamSubscription<bool> _isScanningSubscription;

  BluetoothAdapterState adapterState = BluetoothAdapterState.unknown;

  late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;

  /// 是否过滤未命名的
  bool isFilterNoName = true;

  /// 是否过滤不可连接的
  bool isFilterNotConnectable = false;

  @override
  void onInit() {
    super.onInit();
    _adapterStateStateSubscription =
        FlutterBluePlus.adapterState.listen((state) {
      adapterState = state;
      update([BluetoothOffView_ID]);
    });

    FlutterBluePlus.systemDevices.then((devices) {
      connectedDevices = devices;
      update([BluetoothScanListView_ID]);
    });

    _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
      Throttle.duration(
        const Duration(seconds: 1),
        _processScanResults,
        [results],
      );
    });

    _isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
      update([BluetoothScanListView_ID]);
    });

    onScanPressed();
  }

  /// 处理扫描结果
  /// 为了防抖单独封装的方法
  void _processScanResults(List<ScanResult> results) {
    scanResults = results.where(
      (element) {
        if (!isFilterNotConnectable) return true;
        return element.advertisementData.connectable;
      },
    ).where(
      (element) {
        if (!isFilterNoName) return true;
        return element.advertisementData.localName.isNotEmpty ||
            element.device.platformName.isNotEmpty;
      },
    ).toList();
    update([BluetoothScanListView_ID]);
  }

  @override
  void onClose() {
    _adapterStateStateSubscription.cancel();

    _scanResultsSubscription.cancel();
    _isScanningSubscription.cancel();
    super.onClose();
  }

  Future onScanPressed() async {
    try {
      if (FlutterBluePlus.isScanningNow) return;
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
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

  Future onStopPressed() async {
    try {
      await FlutterBluePlus.stopScan();
    } catch (e) {
      SnackBarUtil.show(
        ABC.b,
        prettyException("Stop Scan Error:", e),
        success: false,
      );
    }
  }

  void onConnectPressed(BluetoothDevice device) {
    if (SocketMessageManager.instance.linkType == LinkType.ble) {
      BluetoothSocketManager.instance.disconnect();
    } else {
      BluetoothSocketManager.instance.connect(device);
    }

    // Get.toNamed(Routes.BLUETOOTH_DEVICE_PAGE_VIEW, arguments: device);
  }

  Future onRefresh() {
    if (FlutterBluePlus.isScanningNow == false) {
      FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    }
    update([BluetoothScanListView_ID]);
    return Future.delayed(const Duration(milliseconds: 500));
  }
}
