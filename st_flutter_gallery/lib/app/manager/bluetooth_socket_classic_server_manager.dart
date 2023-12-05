import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/manager/bluetooth_socket_classic_manager.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/modules/link_mode/bluetooth/bluetooth_scan_classic_server_page/bluetooth_scan_classic_server_page_logic.dart';
import 'package:st/app/modules/link_mode/link_mode_select/link_mode_select_logic.dart';
import 'package:st/helpers/logger/logger_helper.dart';

class BluetoothSocketClassicServerManager
    extends BluetoothSocketClassicManager {
  BluetoothSocketClassicServerManager.internal() : super.internal();

  static final BluetoothSocketClassicServerManager instance =
      BluetoothSocketClassicServerManager.internal();

  bool isConnect = false;

  bool isScanning = false;

  /// 开始连接
  Future<void> connectServer() async {
    try {
      await SocketMessageManager.instance.disconnect();

      /// 加入的设备监听
      FlutterBluetoothSerial.instance.onBluetoothSocketAccept().listen((event) {
        showToast('已连接到 "${event.name}"');
        bluetoothDevice = event;
        isConnect = true;
        isScanning = false;
        if (Get.isRegistered<BluetoothScanClassicServerPageLogic>()) {
          Get.find<BluetoothScanClassicServerPageLogic>().update();
        }
      });

      unawaited(
        BluetoothConnection.toAddress('address', isServerMode: true)
            .then((value) async {
          connection = value;

          SocketMessageManager.instance.linkType = LinkType.classicServer;
          if (Get.isRegistered<LinkModeSelectLogic>()) {
            Get.find<LinkModeSelectLogic>().update();
          }
          connection?.input?.listen((Uint8List data) {
            SocketMessageManager.instance.subscriptionMessage(data);
            if (ascii.decode(data, allowInvalid: true).contains('!')) {
              // disconnect();
            }
          }).onDone(onDone);
        }),
      );

      logger.info('开启蓝牙服务器模式成功,待设备加入');
      await EasyLoading.dismiss();
      showToast('开启蓝牙服务器模式成功,待设备加入');
    } catch (exception) {
      onError(exception);
    }

    if (Get.isRegistered<BluetoothScanClassicServerPageLogic>()) {
      Get.find<BluetoothScanClassicServerPageLogic>().update();
    }
  }

  @override
  Future<void> disconnect() async {
    try {
      await super.disconnect();
      isConnect = false;
      isScanning = false;
      bluetoothDevice = null;
    } catch (e) {
      logger.info('蓝牙经典服务器模式disconnect异常 $e');
    }
  }
}
