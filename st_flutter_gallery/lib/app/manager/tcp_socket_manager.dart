import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:just_debounce_it/just_debounce_it.dart';
import 'package:just_throttle_it/just_throttle_it.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/modules/link_mode/link_mode_select/link_mode_select_logic.dart';
import 'package:st/helpers/logger/logger_helper.dart';

enum TcpConnectionStatus {
  disconnected,
  connected,
}

class TcpSocketManager {
  TcpSocketManager._internal();

  /// 客户端 Socket 连接
  Socket? _socket;

  /// 数据监听流
  StreamSubscription? _tcpSocketChannelSubscription;

  /// 连接状态
  ValueNotifier<TcpConnectionStatus> connectionStatus =
      ValueNotifier(TcpConnectionStatus.disconnected);

  // 是否可以重连
  bool _canReconnect = false;

  /// ip地址
  String ipAddress = '192.168.80.1';

  /// ip端口号
  int port = 6000;

  /// ping时长
  static const pingInterval = Duration(seconds: 3);

  /// ping计时器
  Timer? _pingTimer;

  static final TcpSocketManager instance = TcpSocketManager._internal();

  /// 开始连接
  Future<void> connect() async {
    try {
      await SocketMessageManager.instance.disconnect();

      /// 开始ping
      _startPing();

      _canReconnect = true;

      logger.info("开始尝试连接 $ipAddress");
      await EasyLoading.show(
        status: '设备连接中',
        maskType: EasyLoadingMaskType.black,
      );
      _socket = await Socket.connect(ipAddress, port);
      _tcpSocketChannelSubscription = _socket?.listen(
        SocketMessageManager.instance.subscriptionMessage,
        onError: _onError,
        onDone: _onDone,
      );

      SocketMessageManager.instance.linkType = LinkType.tcp;
      if (Get.isRegistered<LinkModeSelectLogic>()) {
        Get.find<LinkModeSelectLogic>().update();
      }
      connectionStatus.value = TcpConnectionStatus.connected;
      logger.info('已经连接到了设备');
      showToast('设备连接成功');

      /// 连接状态监听
      connectionStatus.addListener(_connectionStatusChange);
    } catch (e) {
      if (e is SocketException) {
        showToast('设备连接失败:${e.message}');
      }
      logger.severe('设备连接失败:$e');
    } finally {
      await EasyLoading.dismiss();
    }
  }

  /// 断开连接
  Future<void> disconnect() async {
    if (connectionStatus.value == TcpConnectionStatus.connected) {
      _canReconnect = false;
      connectionStatus.value = TcpConnectionStatus.disconnected;
      SocketMessageManager.instance.linkType = LinkType.none;
      if (Get.isRegistered<LinkModeSelectLogic>()) {
        Get.find<LinkModeSelectLogic>().update();
      }
      await _close();
      showToast('设备断开连接');
    }
  }

  /// 关闭连接
  Future _close() async {
    try {
      connectionStatus
        ..value = TcpConnectionStatus.disconnected
        ..removeListener(_connectionStatusChange);
      const timeout = Duration(seconds: 3);
      await _tcpSocketChannelSubscription?.cancel().timeout(timeout);
      await _socket?.close().timeout(timeout);
    } catch (e) {
      logger.severe('设备连接 close 失败:$e');
    }
  }

  /// 消息写入
  void sendMessage(List<int> data) {
    try {
      logger.warning("tcp_websocket 原数据 : $data");
      _socket?.add(Uint8List.fromList(data));
    } catch (e) {
      logger.warning("tcp_websocket send message error : $e");
    }
  }

  void _connectionStatusChange() {
    if (connectionStatus.value == TcpConnectionStatus.connected) {
      SocketMessageManager.instance.linkType = LinkType.tcp;
    } else {
      SocketMessageManager.instance.linkType = LinkType.none;
    }
  }

  void _startPing() {
    Timer.periodic(pingInterval, (_) {
      if (connectionStatus.value != TcpConnectionStatus.connected) return;
      _checkWsConnected();
    });
  }

  void _checkWsConnected() {
    if (_sendPing()) {
      _pingTimer?.cancel();
      _pingTimer = Timer(pingInterval, () {
        logger.warning("No pong received.");
        connectionStatus.value = TcpConnectionStatus.disconnected;
        _reconnect();
      });
    }
  }

  bool _sendPing() {
    try {
      _socket!.add([]);
      connectionStatus.value = TcpConnectionStatus.connected;
    } catch (e) {
      logger.warning("tcp ping 发送消息异常:", e);
      connectionStatus.value = TcpConnectionStatus.disconnected;
      _reconnect();
      return false;
    }
    return true;
  }

  void _reconnect() {
    Throttle.milliseconds(3000, _reconnectDebounce);
    Debounce.milliseconds(3000, _reconnectDebounce);
  }

  void _reconnectDebounce() {
    logger.warning("_reconnectDebounce _canReconnect $_canReconnect");
    if (_canReconnect == false) return;
    logger.warning("_reconnecting");
    connect();
  }

  void _onError(error) {
    logger.severe("tcp 连接异常:", error);
  }

  void _onDone() {
    disconnect();
    logger.warning('远端断开连接');
  }
}
