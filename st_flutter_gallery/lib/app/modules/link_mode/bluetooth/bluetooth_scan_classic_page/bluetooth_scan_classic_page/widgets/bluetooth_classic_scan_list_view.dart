import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:st/app/manager/bluetooth_socket_classic_manager.dart';
import 'package:st/app/modules/link_mode/bluetooth/bluetooth_scan_classic_page/bluetooth_scan_classic_page/bluetooth_scan_classic_page_logic.dart';
import 'package:st/app/modules/link_mode/bluetooth/bluetooth_scan_classic_page/bluetooth_scan_classic_page/widgets/scan_result_tile.dart';
import 'package:st/helpers/logger/logger_helper.dart';
import 'package:st/utils/snackbar/snack_bar_util.dart';

class BluetoothScanClassicListView extends StatefulWidget {
  const BluetoothScanClassicListView({super.key});

  @override
  State<BluetoothScanClassicListView> createState() =>
      _BluetoothScanClassicListViewState();
}

class _BluetoothScanClassicListViewState
    extends State<BluetoothScanClassicListView> {
  BluetoothScanClassicPageLogic get controller =>
      Get.find<BluetoothScanClassicPageLogic>();

  //
  List<Widget> _buildScanResultTiles(List<BluetoothDiscoveryResult> results) {
    return ListTile.divideTiles(
      color: Colors.grey, // 分割线的颜色
      tiles: results
          .map(
            (r) => ScanClassicResultTile(
              result: r,
              onTap: () {
                if (BluetoothSocketClassicManager.instance
                    .isConnected(r.device)) {
                  BluetoothSocketClassicManager.instance.disconnect();
                } else {
                  BluetoothSocketClassicManager.instance.connect(r.device);
                }
              },
              onLongPress: () async {
                try {
                  if (r.device.isBonded) {
                    await FlutterBluetoothSerial.instance
                        .removeDeviceBondWithAddress(r.device.address);
                  } else {
                    await FlutterBluetoothSerial.instance
                        .bondDeviceAtAddress(r.device.address);
                  }
                } on Exception catch (ex) {
                  logger.severe('长按匹配或取消匹配失败');
                }
              },
            ),
          )
          .toList(),
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: SnackBarUtil.snackBarKeyC,
      child: GetBuilder<BluetoothScanClassicPageLogic>(
        id: BluetoothScanClassicPageLogic.BluetoothScanListView_ID,
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
                  child: logic.isDiscovering
                      ? FittedBox(
                          child: Container(
                            margin: const EdgeInsets.all(20),
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
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
                child: ListView(
                  children: [
                    ExpansionTile(
                      initiallyExpanded: true,
                      maintainState: true,
                      title: const Text(
                        '已配对的设备',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      children: _buildScanResultTiles(logic.bondedDevices),
                    ),
                    ExpansionTile(
                      initiallyExpanded: true,
                      maintainState: true,
                      title: const Text(
                        '其他设备',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      children: _buildScanResultTiles(logic.notBondDevices),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
