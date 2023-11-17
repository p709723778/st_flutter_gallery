import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/bluetooth/bluetooth_scan_page/controllers/bluetooth_scan_page_controller.dart';
import 'package:st/utils/snackbar/snack_bar_util.dart';

class BluetoothOffView extends StatelessWidget {
  const BluetoothOffView({super.key});

  Widget buildBluetoothOffIcon(BuildContext context) {
    return const Icon(
      Icons.bluetooth_disabled,
      size: 200,
      color: Colors.white54,
    );
  }

  Widget buildTitle(
    BuildContext context,
    BluetoothScanPageController bluetoothScanPageController,
  ) {
    final state =
        bluetoothScanPageController.adapterState.toString().split(".").last;
    return Text(
      '设备蓝牙状态是: $state',
      style: Theme.of(context)
          .primaryTextTheme
          .titleSmall
          ?.copyWith(color: Colors.white),
    );
  }

  Widget buildTurnOnButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        child: const Text('打开'),
        onPressed: () async {
          try {
            if (Platform.isAndroid) {
              await FlutterBluePlus.turnOn();
            }
          } catch (e) {
            SnackBarUtil.show(
              ABC.a,
              prettyException("蓝牙打开错误:", e),
              success: false,
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BluetoothScanPageController>(
      id: BluetoothScanPageController.BluetoothOffView_ID,
      builder: (logic) {
        return ScaffoldMessenger(
          key: SnackBarUtil.snackBarKeyA,
          child: Scaffold(
            backgroundColor: Colors.lightBlue,
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  buildBluetoothOffIcon(context),
                  buildTitle(context, logic),
                  if (Platform.isAndroid) buildTurnOnButton(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
