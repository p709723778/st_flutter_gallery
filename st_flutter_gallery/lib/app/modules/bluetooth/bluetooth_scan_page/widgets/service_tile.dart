import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

////////////////////////////////////////////////////////////
//    _____ ______ _______      _______ _____ ______
//   / ____|  ____|  __ \ \    / /_   _/ ____|  ____|
//  | (___ | |__  | |__) \ \  / /  | || |    | |__
//   \___ \|  __| |  _  / \ \/ /   | || |    |  __|
//   ____) | |____| | \ \  \  /   _| || |____| |____
//  |_____/|______|_|  \_\  \/   |_____\_____|______|
class ServiceTile extends StatelessWidget {
  const ServiceTile({
    super.key,
    required this.service,
    required this.characteristicTiles,
  });
  final BluetoothService service;
  final List<CharacteristicTile> characteristicTiles;

  Widget buildUuid(BuildContext context) {
    final uuid = '0x${service.uuid.toString().toUpperCase()}';
    return Text(uuid, style: const TextStyle(fontSize: 13));
  }

  @override
  Widget build(BuildContext context) {
    if (characteristicTiles.isNotEmpty) {
      return ExpansionTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Service', style: TextStyle(color: Colors.blue)),
            buildUuid(context),
          ],
        ),
        children: characteristicTiles,
      );
    } else {
      return ListTile(
        title: const Text('Service'),
        subtitle: buildUuid(context),
      );
    }
  }
}

/////////////////////////////////
//    _____ _    _ _____
//   / ____| |  | |  __ \
//  | |    | |__| | |__) |
//  | |    |  __  |  _  /
//  | |____| |  | | | \ \
//   \_____|_|  |_|_|  \_\
class CharacteristicTile extends StatefulWidget {
  const CharacteristicTile({
    super.key,
    required this.characteristic,
    required this.descriptorTiles,
    this.onReadPressed,
    this.onWritePressed,
    this.onNotificationPressed,
  });
  final BluetoothCharacteristic characteristic;
  final List<DescriptorTile> descriptorTiles;
  final Future<void> Function()? onReadPressed;
  final Future<void> Function()? onWritePressed;
  final Future<void> Function()? onNotificationPressed;

  @override
  State<CharacteristicTile> createState() => _CharacteristicTileState();
}

class _CharacteristicTileState extends State<CharacteristicTile> {
  List<int> _value = [];

  late StreamSubscription<List<int>> _onValueReceivedSubscription;

  @override
  void initState() {
    super.initState();
    _onValueReceivedSubscription =
        widget.characteristic.lastValueStream.listen((value) {
      _value = value;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _onValueReceivedSubscription.cancel();
    super.dispose();
  }

  Widget buildUuid(BuildContext context) {
    final uuid = '0x${widget.characteristic.uuid.toString().toUpperCase()}';
    return Text(uuid, style: const TextStyle(fontSize: 13));
  }

  Widget buildValue(BuildContext context) {
    final data = _value.toString();
    return Text(data, style: const TextStyle(fontSize: 13, color: Colors.grey));
  }

  Widget buildReadButton(BuildContext context) {
    return TextButton(
      child: const Text("Read"),
      onPressed: () async {
        await widget.onReadPressed!();
        setState(() {});
      },
    );
  }

  Widget buildWriteButton(BuildContext context) {
    final withoutResp = widget.characteristic.properties.writeWithoutResponse;
    return TextButton(
      child: Text(withoutResp ? "WriteNoResp" : "Write"),
      onPressed: () async {
        await widget.onWritePressed!();
        setState(() {});
      },
    );
  }

  Widget buildSubscribeButton(BuildContext context) {
    final isNotifying = widget.characteristic.isNotifying;
    return TextButton(
      child: Text(isNotifying ? "Unsubscribe" : "Subscribe"),
      onPressed: () async {
        await widget.onNotificationPressed!();
        setState(() {});
      },
    );
  }

  Widget buildButtonRow(BuildContext context) {
    final read = widget.characteristic.properties.read;
    final write = widget.characteristic.properties.write;
    final notify = widget.characteristic.properties.notify;
    final indicate = widget.characteristic.properties.indicate;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (read) buildReadButton(context),
        if (write) buildWriteButton(context),
        if (notify || indicate) buildSubscribeButton(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: ListTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Characteristic'),
            buildUuid(context),
            buildValue(context),
          ],
        ),
        subtitle: buildButtonRow(context),
        contentPadding: EdgeInsets.zero,
      ),
      children: widget.descriptorTiles,
    );
  }
}

////////////////////////////////////
//  _____  ______  _____  _____
// |  __ \|  ____|/ ____|/ ____|
// | |  | | |__  | (___ | |
// | |  | |  __|  \___ \| |
// | |__| | |____ ____) | |____
// |_____/|______|_____/ \_____|
class DescriptorTile extends StatefulWidget {
  const DescriptorTile({
    super.key,
    required this.descriptor,
    this.onReadPressed,
    this.onWritePressed,
  });
  final BluetoothDescriptor descriptor;
  final VoidCallback? onReadPressed;
  final VoidCallback? onWritePressed;

  @override
  State<DescriptorTile> createState() => _DescriptorTileState();
}

class _DescriptorTileState extends State<DescriptorTile> {
  List<int> _value = [];

  late StreamSubscription<List<int>> _onValueReceivedSubscription;

  @override
  void initState() {
    super.initState();
    _onValueReceivedSubscription =
        widget.descriptor.lastValueStream.listen((value) {
      _value = value;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _onValueReceivedSubscription.cancel();
    super.dispose();
  }

  Widget buildUuid(BuildContext context) {
    final uuid = '0x${widget.descriptor.uuid.toString().toUpperCase()}';
    return Text(uuid, style: const TextStyle(fontSize: 13));
  }

  Widget buildValue(BuildContext context) {
    final data = _value.toString();
    return Text(data, style: const TextStyle(fontSize: 13, color: Colors.grey));
  }

  Widget buildReadButton(BuildContext context) {
    return TextButton(
      onPressed: widget.onReadPressed,
      child: const Text("Read"),
    );
  }

  Widget buildWriteButton(BuildContext context) {
    return TextButton(
      onPressed: widget.onWritePressed,
      child: const Text("Write"),
    );
  }

  Widget buildButtonRow(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        buildReadButton(context),
        buildWriteButton(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Descriptor'),
          buildUuid(context),
          buildValue(context),
        ],
      ),
      subtitle: buildButtonRow(context),
    );
  }
}
