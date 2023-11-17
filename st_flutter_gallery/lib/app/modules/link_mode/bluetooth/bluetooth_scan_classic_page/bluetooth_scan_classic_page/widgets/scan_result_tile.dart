import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:signal_strength_indicator/signal_strength_indicator.dart';
import 'package:st/app/manager/bluetooth_socket_classic_manager.dart';

class ScanClassicResultTile extends StatefulWidget {
  const ScanClassicResultTile({
    super.key,
    required this.result,
    this.onTap,
    this.onLongPress,
  });

  final BluetoothDiscoveryResult result;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  State<ScanClassicResultTile> createState() => _ScanClassicResultTileState();
}

class _ScanClassicResultTileState extends State<ScanClassicResultTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildTitle(BuildContext context) {
    var isHasDeviceName = true;
    var deviceName = widget.result.device.name;

    if (deviceName?.isEmpty ?? true) {
      deviceName = 'N/A';
      isHasDeviceName = false;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          deviceName!,
          overflow: TextOverflow.ellipsis,
          style: isHasDeviceName
              ? const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                )
              : const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
        ),
        Text(
          widget.result.device.address,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildConnectButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            widget.result.device.isConnected ? Colors.red : Colors.black,
        foregroundColor: Colors.white,
      ),
      onPressed: widget.onTap,
      onLongPress: widget.onLongPress,
      child: BluetoothSocketClassicManager.instance
              .isConnected(widget.result.device)
          ? const Text(
              '断开',
              style: TextStyle(
                fontSize: 16,
              ),
            )
          : const Text(
              '连接',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quality = min(max(2 * (widget.result.rssi + 100), 0), 100) / 100;
    return ExpansionTile(
      title: _buildTitle(context),
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SignalStrengthIndicator.bars(
            inactiveColor: Colors.blue.withOpacity(0.2),
            activeColor: Colors.blue,
            value: quality,
            size: 20,
            barCount: 4,
          ),
          Text(widget.result.rssi.toString()),
        ],
      ),
      trailing: _buildConnectButton(context),
    );
  }
}
