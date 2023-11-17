import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:st/app/manager/bluetooth_socket_manager.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/extension/bluetooth_device_extension.dart';
import 'package:st/utils/snackbar/snack_bar_util.dart';

class BluetoothDevicePageLogic extends GetxController {
  late BluetoothDevice device;

  int? rssi;
  int? mtuSize;
  BluetoothConnectionState connectionState =
      BluetoothConnectionState.disconnected;
  List<BluetoothService> services = [];
  bool isDiscoveringServices = false;
  bool isConnectingOrDisconnecting = false;

  late StreamSubscription<BluetoothConnectionState>
      _connectionStateSubscription;
  late StreamSubscription<bool> _isConnectingOrDisconnectingSubscription;
  late StreamSubscription<int> _mtuSubscription;

  @override
  void onInit() {
    device = Get.arguments;

    _connectionStateSubscription = device.connectionState.listen((state) async {
      connectionState = state;
      if (state == BluetoothConnectionState.connected) {
        services = []; // must rediscover services
      }
      if (state == BluetoothConnectionState.connected && rssi == null) {
        rssi = await device.readRssi();
      }
      update();
    });

    _mtuSubscription = device.mtu.listen((value) {
      mtuSize = value;
      update();
    });

    _isConnectingOrDisconnectingSubscription =
        device.isConnectingOrDisconnecting.listen((value) {
      isConnectingOrDisconnecting = value;
      update();
    });

    super.onInit();
  }

  @override
  void onClose() {
    _connectionStateSubscription.cancel();
    _mtuSubscription.cancel();
    _isConnectingOrDisconnectingSubscription.cancel();
    super.onClose();
  }

  List<int> _getRandomBytes() {
    final math = Random();
    return [
      math.nextInt(255),
      math.nextInt(255),
      math.nextInt(255),
      math.nextInt(255),
    ];
  }

  bool get isConnected {
    return connectionState == BluetoothConnectionState.connected;
  }

  String get connectionStateString {
    if (connectionState == BluetoothConnectionState.disconnected) {
      return '断开连接';
    } else if (connectionState == BluetoothConnectionState.connected) {
      return '已连接';
      // ignore: deprecated_member_use
    } else if (connectionState == BluetoothConnectionState.connecting) {
      return '连接中...';
      // ignore: deprecated_member_use
    } else if (connectionState == BluetoothConnectionState.disconnecting) {
      return '断开连接中...';
    }
    return '未知';
  }

  Future onConnectPressed() async {
    try {
      if (SocketMessageManager.instance.linkType == LinkType.ble) {
        BluetoothSocketManager.instance.disconnect();
      } else {
        await BluetoothSocketManager.instance.connect(device);
      }

      SnackBarUtil.show(ABC.c, "Connect: Success", success: true);
    } catch (e) {
      SnackBarUtil.show(
        ABC.c,
        prettyException("Connect Error:", e),
        success: false,
      );
    }
  }

  Future onDisconnectPressed() async {
    try {
      await device.disconnectAndUpdateStream();
      SnackBarUtil.show(ABC.c, "Disconnect: Success", success: true);
    } catch (e) {
      SnackBarUtil.show(
        ABC.c,
        prettyException("Disconnect Error:", e),
        success: false,
      );
    }
  }

  Future onDiscoverServicesPressed() async {
    isDiscoveringServices = true;
    update();

    try {
      services = await device.discoverServices();
      SnackBarUtil.show(ABC.c, "Discover Services: Success", success: true);
    } catch (e) {
      SnackBarUtil.show(
        ABC.c,
        prettyException("Discover Services Error:", e),
        success: false,
      );
    }
    isDiscoveringServices = false;

    update();
  }

  Future onRequestMtuPressed() async {
    try {
      await device.requestMtu(223);
      SnackBarUtil.show(ABC.c, "Request Mtu: Success", success: true);
    } catch (e) {
      SnackBarUtil.show(
        ABC.c,
        prettyException("Change Mtu Error:", e),
        success: false,
      );
    }
  }

  Future onReadPressed(BluetoothCharacteristic c) async {
    try {
      final data = await c.read();
      final s = String.fromCharCodes(Uint8List.fromList(data));
      SnackBarUtil.show(ABC.c, "Read:$data Success: $s ", success: true);
    } catch (e) {
      SnackBarUtil.show(
        ABC.c,
        prettyException("Read Error:", e),
        success: false,
      );
    }
  }

  Future onWritePressed(BluetoothCharacteristic c) async {
    try {
      await c.write(
        _getRandomBytes(),
        withoutResponse: c.properties.writeWithoutResponse,
      );
      SnackBarUtil.show(ABC.c, "Write: Success", success: true);
      if (c.properties.read) {
        await c.read();
      }
    } catch (e) {
      SnackBarUtil.show(
        ABC.c,
        prettyException("Write Error:", e),
        success: false,
      );
    }
  }

  Future onSubscribePressed(BluetoothCharacteristic c) async {
    try {
      final op = c.isNotifying == false ? "Subscribe" : "Unubscribe";
      await c.setNotifyValue(c.isNotifying == false);
      SnackBarUtil.show(ABC.c, "$op : Success", success: true);
      if (c.properties.read) {
        await c.read();
      }
    } catch (e) {
      SnackBarUtil.show(
        ABC.c,
        prettyException("Subscribe Error:", e),
        success: false,
      );
    }
  }

  Future onReadDescriptorPressed(BluetoothDescriptor d) async {
    try {
      await d.read();
      SnackBarUtil.show(ABC.c, "Descriptor Read : Success", success: true);
    } catch (e) {
      SnackBarUtil.show(
        ABC.c,
        prettyException("Descriptor Read Error:", e),
        success: false,
      );
    }
  }

  Future onWriteDescriptorPressed(BluetoothDescriptor d) async {
    try {
      await d.write(_getRandomBytes());
      SnackBarUtil.show(ABC.c, "Descriptor Write : Success", success: true);
    } catch (e) {
      SnackBarUtil.show(
        ABC.c,
        prettyException("Descriptor Write Error:", e),
        success: false,
      );
    }
  }
}
