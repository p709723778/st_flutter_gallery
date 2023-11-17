import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/bluetooth/bluetooth_device_page/bluetooth_device_page_logic.dart';
import 'package:st/app/modules/bluetooth/bluetooth_scan_page/widgets/service_tile.dart';
import 'package:st/utils/snackbar/snack_bar_util.dart';

class BluetoothDevicePageView extends StatefulWidget {
  const BluetoothDevicePageView({super.key});

  @override
  State<BluetoothDevicePageView> createState() =>
      _BluetoothDevicePageViewState();
}

class _BluetoothDevicePageViewState extends State<BluetoothDevicePageView> {
  BluetoothDevicePageLogic get controller =>
      Get.find<BluetoothDevicePageLogic>();

  List<Widget> _buildServiceTiles(BuildContext context, BluetoothDevice d) {
    return controller.services
        .map(
          (s) => ServiceTile(
            service: s,
            characteristicTiles:
                s.characteristics.map(_buildCharacteristicTile).toList(),
          ),
        )
        .toList();
  }

  CharacteristicTile _buildCharacteristicTile(BluetoothCharacteristic c) {
    return CharacteristicTile(
      characteristic: c,
      onReadPressed: () => controller.onReadPressed(c),
      onWritePressed: () => controller.onWritePressed(c),
      onNotificationPressed: () => controller.onSubscribePressed(c),
      descriptorTiles: c.descriptors
          .map(
            (d) => DescriptorTile(
              descriptor: d,
              onReadPressed: () => controller.onReadDescriptorPressed(d),
              onWritePressed: () => controller.onWriteDescriptorPressed(d),
            ),
          )
          .toList(),
    );
  }

  Widget buildSpinner(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(14),
      child: AspectRatio(
        aspectRatio: 1,
        child: CircularProgressIndicator(
          backgroundColor: Colors.black12,
          color: Colors.black26,
        ),
      ),
    );
  }

  Widget buildConnectOrDisconnectButton(BuildContext context) {
    return TextButton(
      onPressed: controller.isConnected
          ? controller.onDisconnectPressed
          : controller.onConnectPressed,
      child: Text(
        controller.isConnected ? "断开连接" : "连接",
        style: Theme.of(context)
            .primaryTextTheme
            .labelLarge
            ?.copyWith(color: Colors.white),
      ),
    );
  }

  Widget buildRemoteId(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text('${controller.device.remoteId}'),
    );
  }

  Widget buildRssiTile(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (controller.isConnected)
          const Icon(
            Icons.bluetooth_connected,
            color: Colors.blue,
          )
        else
          const Icon(Icons.bluetooth_disabled),
        SizedBox(
          width: 68,
          child: Text(
            ((controller.isConnected && controller.rssi != null)
                ? '${controller.rssi!} dBm'
                : ''),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }

  Widget buildGetServices(BuildContext context) {
    return IndexedStack(
      index: controller.isDiscoveringServices ? 1 : 0,
      children: <Widget>[
        TextButton(
          onPressed: controller.onDiscoverServicesPressed,
          child: const Text(
            "获取蓝牙服务",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        const IconButton(
          icon: SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.grey),
            ),
          ),
          onPressed: null,
        ),
      ],
    );
  }

  Widget buildMtuTile(BuildContext context) {
    return ListTile(
      title: const Text('MTU Size'),
      subtitle: Text('${controller.mtuSize} bytes'),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: controller.onRequestMtuPressed,
      ),
    );
  }

  Widget buildConnectButton(BuildContext context) {
    if (controller.isConnectingOrDisconnecting) {
      return buildSpinner(context);
    } else {
      return buildConnectOrDisconnectButton(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: SnackBarUtil.snackBarKeyC,
      child: GetBuilder<BluetoothDevicePageLogic>(
        builder: (logic) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                controller.device.platformName,
                style: const TextStyle(fontSize: 16),
              ),
              actions: [buildConnectButton(context)],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  buildRemoteId(context),
                  ListTile(
                    leading: buildRssiTile(context),
                    title: Text(
                      '连接状态: ${controller.connectionStateString}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    trailing: buildGetServices(context),
                  ),
                  buildMtuTile(context),
                  ..._buildServiceTiles(context, controller.device),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
