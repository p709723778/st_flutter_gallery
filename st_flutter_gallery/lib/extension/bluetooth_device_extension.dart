import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:st/app/modules/link_mode/bluetooth/utils/stream_controller_ex_util.dart';

final Map<DeviceIdentifier, StreamControllerExUtil<bool>> _global = {};

/// connect & disconnect + update stream
extension BluetoothDeviceExtension on BluetoothDevice {
  // convenience
  StreamControllerExUtil<bool> get _stream {
    _global[remoteId] ??= StreamControllerExUtil(initialValue: false);
    return _global[remoteId]!;
  }

  // get stream
  Stream<bool> get isConnectingOrDisconnecting {
    return _stream.stream;
  }

  // connect & update stream
  Future<void> connectAndUpdateStream() async {
    _stream.add(true);
    try {
      await connect();
    } finally {
      _stream.add(false);
    }
  }

  // disconnect & update stream
  Future<void> disconnectAndUpdateStream() async {
    _stream.add(true);
    try {
      await disconnect();
    } finally {
      _stream.add(false);
    }
  }
}
