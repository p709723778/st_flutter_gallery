import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/link_mode/bluetooth/bluetooth_scan_classic_page/bluetooth_scan_classic_page/bluetooth_scan_classic_page_logic.dart';
import 'package:st/app/modules/link_mode/bluetooth/bluetooth_scan_classic_page/bluetooth_scan_classic_page/widgets/bluetooth_classic_off_view.dart';
import 'package:st/app/modules/link_mode/bluetooth/bluetooth_scan_classic_page/bluetooth_scan_classic_page/widgets/bluetooth_classic_scan_list_view.dart';

class BluetoothScanClassicPage extends StatefulWidget {
  const BluetoothScanClassicPage({super.key});

  @override
  State<BluetoothScanClassicPage> createState() =>
      _BluetoothScanClassicPageState();
}

class _BluetoothScanClassicPageState extends State<BluetoothScanClassicPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<BluetoothScanClassicPageLogic>(
      init: BluetoothScanClassicPageLogic(),
      id: BluetoothScanClassicPageLogic.BluetoothOffView_ID,
      builder: (logic) {
        if (!logic.bluetoothState.isEnabled) {
          return const BluetoothClassicOffView();
        } else {
          return const BluetoothScanClassicListView();
        }
      },
    );
  }
}
