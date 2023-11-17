import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/link_mode/bluetooth/bluetooth_scan_classic_page/bluetooth_scan_classic_page/bluetooth_scan_classic_page_logic.dart';
import 'package:st/utils/snackbar/snack_bar_util.dart';

class BluetoothClassicOffView extends StatelessWidget {
  const BluetoothClassicOffView({super.key});

  Widget buildBluetoothOffIcon(BuildContext context) {
    return const Icon(
      Icons.bluetooth_disabled,
      size: 200,
      color: Colors.white54,
    );
  }

  Widget buildTitle(
    BuildContext context,
    BluetoothScanClassicPageLogic bluetoothScanClassicPageLogic,
  ) {
    final state =
        bluetoothScanClassicPageLogic.bluetoothState.isEnabled.toString();
    return Text(
      '设备蓝牙状态是: $state',
      style: Theme.of(context)
          .primaryTextTheme
          .titleSmall
          ?.copyWith(color: Colors.white),
    );
  }

  Widget buildTurnOnButton(
    BuildContext context,
    BluetoothScanClassicPageLogic bluetoothScanClassicPageLogic,
  ) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: bluetoothScanClassicPageLogic.bluetoothState.isEnabled
          ? ElevatedButton(
              child: const Text('关闭'),
              onPressed: () async {
                try {
                  if (Platform.isAndroid) {
                    await bluetoothScanClassicPageLogic.requestDisable();
                  }
                } catch (e) {
                  SnackBarUtil.show(
                    ABC.a,
                    prettyException("蓝牙打开错误:", e),
                    success: false,
                  );
                }
              },
            )
          : ElevatedButton(
              child: const Text('打开'),
              onPressed: () async {
                try {
                  if (Platform.isAndroid) {
                    await bluetoothScanClassicPageLogic.requestEnable();
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
    return GetBuilder<BluetoothScanClassicPageLogic>(
      id: BluetoothScanClassicPageLogic.BluetoothOffView_ID,
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
                  if (Platform.isAndroid) buildTurnOnButton(context, logic),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
