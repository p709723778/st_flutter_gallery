import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/bluetooth/bluetooth_scan_page/controllers/bluetooth_scan_page_controller.dart';
import 'package:st/app/modules/bluetooth/bluetooth_scan_page/widgets/bluetooth_off_view.dart';
import 'package:st/app/modules/bluetooth/bluetooth_scan_page/widgets/bluetooth_scan_list_view.dart';

class BluetoothScanPage extends StatefulWidget {
  const BluetoothScanPage({super.key});

  @override
  State<BluetoothScanPage> createState() => _BluetoothScanPageState();
}

class _BluetoothScanPageState extends State<BluetoothScanPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<BluetoothScanPageController>(
      init: BluetoothScanPageController(),
      id: BluetoothScanPageController.BluetoothOffView_ID,
      builder: (logic) {
        if (logic.adapterState != BluetoothAdapterState.on) {
          return const BluetoothOffView();
        } else {
          return const BluetoothScanListView();
        }
      },
    );
  }
}
