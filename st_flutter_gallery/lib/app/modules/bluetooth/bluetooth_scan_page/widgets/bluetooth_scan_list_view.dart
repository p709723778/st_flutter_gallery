import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/bluetooth/bluetooth_scan_page/controllers/bluetooth_scan_page_controller.dart';
import 'package:st/app/modules/bluetooth/bluetooth_scan_page/widgets/connected_device_tile.dart';
import 'package:st/app/modules/bluetooth/bluetooth_scan_page/widgets/scan_result_tile.dart';
import 'package:st/app/routes/app_pages.dart';
import 'package:st/utils/snackbar/snack_bar_util.dart';

class BluetoothScanListView extends StatefulWidget {
  const BluetoothScanListView({super.key});

  @override
  State<BluetoothScanListView> createState() => _BluetoothScanListViewState();
}

class _BluetoothScanListViewState extends State<BluetoothScanListView> {
  BluetoothScanPageController get controller =>
      Get.find<BluetoothScanPageController>();

  List<Widget> _buildConnectedDeviceTiles(BuildContext context) {
    return controller.connectedDevices
        .map(
          (d) => ConnectedDeviceTile(
            device: d,
            onOpen: () {
              Get.toNamed(Routes.BLUETOOTH_DEVICE_PAGE_VIEW, arguments: d);
            },
            onConnect: () => controller.onConnectPressed(d),
          ),
        )
        .toList();
  }

  List<Widget> _buildScanResultTiles(BuildContext context) {
    return controller.scanResults
        .map(
          (r) => ScanResultTile(
            result: r,
            onTap: () => controller.onConnectPressed(r.device),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: SnackBarUtil.snackBarKeyC,
      child: GetBuilder<BluetoothScanPageController>(
        id: BluetoothScanPageController.BluetoothScanListView_ID,
        builder: (logic) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                '蓝牙扫描',
                style: TextStyle(fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: logic.onScanPressed,
                  child: FlutterBluePlus.isScanningNow
                      ? const Text(
                          '搜索中...',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        )
                      : const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                ),
              ],
              centerTitle: true,
            ),
            body: EasyRefresh(
              onRefresh: controller.onRefresh,
              child: SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: <Widget>[
                      ..._buildConnectedDeviceTiles(context),
                      ..._buildScanResultTiles(context),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
