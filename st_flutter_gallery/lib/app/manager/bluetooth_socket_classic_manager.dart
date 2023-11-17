import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/modules/link_mode/bluetooth/bluetooth_scan_classic_page/bluetooth_scan_classic_page/bluetooth_scan_classic_page_logic.dart';
import 'package:st/app/modules/link_mode/link_mode_select/link_mode_select_logic.dart';
import 'package:st/helpers/logger/logger_helper.dart';

class BluetoothSocketClassicManager {
  BluetoothSocketClassicManager.internal();
  BluetoothConnection? connection;
  BluetoothDevice? bluetoothDevice;

  static final BluetoothSocketClassicManager instance =
      BluetoothSocketClassicManager.internal();

  final Set bondedDevices = {};

  bool isConnected(BluetoothDevice device) =>
      (connection?.isConnected ?? false) &&
      device.address == (bluetoothDevice?.address ?? '');

  /// 开始连接
  Future<void> connect(BluetoothDevice device) async {
    final bonded = await deviceBonded(device);

    if (!bonded) return;
    try {
      await EasyLoading.show(
        status: '设备连接中',
        maskType: EasyLoadingMaskType.black,
      );

      await SocketMessageManager.instance.disconnect();

      connection = await BluetoothConnection.toAddress(device.address);
      logger.info('已经连接到了设备');
      await EasyLoading.dismiss();
      showToast('设备连接成功');
      bluetoothDevice = device;
      SocketMessageManager.instance.linkType = LinkType.classicClient;
      if (Get.isRegistered<LinkModeSelectLogic>()) {
        Get.find<LinkModeSelectLogic>().update();
      }
      connection?.input?.listen((Uint8List data) {
        SocketMessageManager.instance.subscriptionMessage(data);
        if (ascii.decode(data, allowInvalid: true).contains('!')) {
          // disconnect();
        }
      }).onDone(onDone);
    } catch (exception) {
      onError(exception);
    }

    if (Get.isRegistered<BluetoothScanClassicPageLogic>()) {
      Get.find<BluetoothScanClassicPageLogic>().updateListView();
    }
  }

  // 蓝牙配对
  Future<bool> deviceBonded(BluetoothDevice device) async {
    try {
      var bonded = device.isBonded;
      if (bonded) {
        bondedDevices.add(device.address);
      }
      if (bonded) {
        // logger.info('Unbonding from ${device.address}...');
        // await FlutterBluetoothSerial.instance
        //     .removeDeviceBondWithAddress(device.address);
        // logger.info('Unbonding from ${device.address} has succed');
        // bondedDevices.remove(device.address);
      } else {
        if (!bondedDevices.contains(device.address)) {
          await EasyLoading.show(
            status: '设备配对中',
            maskType: EasyLoadingMaskType.black,
          );
          logger.info('设备配对中 ${device.address}...');
          bonded = (await FlutterBluetoothSerial.instance
              .bondDeviceAtAddress(device.address))!;
          logger.info('设备配对 ${device.address} '
              'has ${bonded ? '成功' : '失败'}.');
          if (bonded) {
            showToast('配对成功');
            bondedDevices.add(device.address);
          }
        }
      }
      await EasyLoading.dismiss();
      return bondedDevices.contains(device.address);
    } catch (exception) {
      SocketMessageManager.instance.linkType = LinkType.none;
      showToast('蓝牙配对相关操作失败:$exception');
    }
    await EasyLoading.dismiss();
    return false;
  }

  /// 断开连接
  Future<void> disconnect() async {
    try {
      if (connection?.isConnected ?? false) {
        await EasyLoading.show(
          status: '设备断开连接中',
          maskType: EasyLoadingMaskType.black,
        );
        await connection?.finish(); // 断开连接
        SocketMessageManager.instance.linkType = LinkType.none;
        if (Get.isRegistered<BluetoothScanClassicPageLogic>()) {
          Get.find<BluetoothScanClassicPageLogic>().updateListView();
        }
        unawaited(EasyLoading.dismiss());
        logger.info('断开连接');
      }
    } catch (e) {
      logger.info('蓝牙disconnect异常$e');
    }
  }

  /// 发送消息
  void sendMessage(List<int> data) {
    connection?.output.add(Uint8List.fromList(data));
  }

  void onError(error) {
    if (error is PlatformException) {
      EasyLoading.dismiss();
      SocketMessageManager.instance.linkType = LinkType.none;
      showToast('蓝牙连接失败:${error.message}');
    } else {
      showToast('蓝牙连接失败:$error');
    }
  }

  void onDone() {
    EasyLoading.dismiss();
    logger.info('通过远程请求断开连接');
  }
}
