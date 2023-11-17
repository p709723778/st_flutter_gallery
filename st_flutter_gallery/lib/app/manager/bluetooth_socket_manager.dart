import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/modules/link_mode/link_mode_select/link_mode_select_logic.dart';
import 'package:st/extension/bluetooth_device_extension.dart';
import 'package:st/helpers/logger/logger_helper.dart';
import 'package:st/utils/snackbar/snack_bar_util.dart';

class BluetoothSocketManager {
  BluetoothSocketManager._internal();
  BluetoothDevice? bluetoothDevice;

  StreamSubscription<BluetoothConnectionState>? _connectionStateSubscription;

  static final BluetoothSocketManager instance =
      BluetoothSocketManager._internal();

  /// 开始连接
  Future<void> connect(BluetoothDevice device) async {
    bluetoothDevice = device;
    if (SocketMessageManager.instance.linkType == LinkType.ble) {
      return;
    }
    await SocketMessageManager.instance.disconnect();

    _startListen();

    await bluetoothDevice?.connectAndUpdateStream().then((value) async {
      logger.info('打开连接 isSocketConnected');
      if (Get.isRegistered<LinkModeSelectLogic>()) {
        Get.find<LinkModeSelectLogic>().update();
      }
    }).catchError((e) {
      SnackBarUtil.show(
        ABC.c,
        prettyException("Connect Error:", e),
        success: false,
      );
    });
  }

  /// 断开连接
  void disconnect() {
    if (bluetoothDevice?.isConnected ?? false) {
      bluetoothDevice?.disconnectAndUpdateStream().then((value) {
        logger.info('断开连接');
      }).catchError((e) {
        logger.info('断开连接错误$e');
        SnackBarUtil.show(
          ABC.c,
          prettyException("Connect Error:", e),
          success: false,
        );
      });
      _cancelListen();
    }
  }

  void _startListen() {
    /// 蓝牙连接状态监听
    _connectionStateSubscription =
        bluetoothDevice?.connectionState.listen((state) async {
      if (state == BluetoothConnectionState.connected) {
        SocketMessageManager.instance.linkType = LinkType.ble;
      } else {
        SocketMessageManager.instance.linkType = LinkType.none;
      }
    });
    _subscriptionMessage();
  }

  void _cancelListen() {
    SocketMessageManager.instance.linkType = LinkType.none;
    _connectionStateSubscription?.cancel();
  }

  /// 发送消息
  void sendMessage(List<int> data) {}

  /// 接收消息
  void _subscriptionMessage() {}

  void _onError(error) {
    logger.severe("websocket error connect", error);
  }

  void _onDone() {
    logger.warning('_webSocketChannelSubscription onDone');
  }
}
