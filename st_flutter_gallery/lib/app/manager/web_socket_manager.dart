import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:just_debounce_it/just_debounce_it.dart';
import 'package:just_throttle_it/just_throttle_it.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/modules/link_mode/link_mode_select/link_mode_select_logic.dart';
import 'package:st/helpers/logger/logger_helper.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

enum WsConnectionStatus {
  disconnected,
  connected,
}

class WebSocketManager {
  WebSocketManager._internal();

  WebSocketChannel? _channel;
  StreamSubscription? _webSocketChannelSubscription;

  ValueNotifier<WsConnectionStatus> connectionStatus =
      ValueNotifier(WsConnectionStatus.disconnected);

  // 只有第一次主动连接后才考虑重连,不然在注册完成填写信息界面前后台切换会重连从而导致填写完信息进入homepage异常.
  // 原因是注册完成后就拿到了token满足了重连条件,但实际上只有进入了homepage才考虑重连.
  bool _canReconnect = false;

  String ipAddress = '192.168.80.1:6000';

  static const pingInterval = Duration(seconds: 25);

  Timer? _pingTimer;

  static final WebSocketManager instance = WebSocketManager._internal();

  /// 开始连接
  Future<void> connect() async {
    await SocketMessageManager.instance.disconnect();

    _startPing();

    _canReconnect = true;
    final baseUri = Uri.parse("ws://$ipAddress");
    final connectUri = Uri(
      scheme: "ws", // 或者 "wss",
      host: baseUri.host,
      path: baseUri.path,
    );

    logger.info("开始尝试连接 $connectUri ...");
    _channel = WebSocketChannel.connect(connectUri);
    _webSocketChannelSubscription = _channel?.stream.listen(
      SocketMessageManager.instance.subscriptionMessage,
      onError: _onError,
      onDone: _onDone,
    );

    connectionStatus.addListener(connectionStatusChange);
  }

  void connectionStatusChange() {
    connectionStatus.value = WsConnectionStatus.connected;
    SocketMessageManager.instance.linkType = LinkType.ws;
    if (Get.isRegistered<LinkModeSelectLogic>()) {
      Get.find<LinkModeSelectLogic>().update();
    }

    if (connectionStatus.value == WsConnectionStatus.connected) {
      SocketMessageManager.instance.linkType = LinkType.ws;
    } else {
      SocketMessageManager.instance.linkType = LinkType.none;
    }
  }

  /// 断开连接
  void disconnect() {
    if (connectionStatus.value == WsConnectionStatus.connected) {
      SocketMessageManager.instance.linkType = LinkType.none;
      _canReconnect = false;
      _close();
    }
  }

  Future _close() async {
    try {
      connectionStatus
        ..value = WsConnectionStatus.disconnected
        ..removeListener(connectionStatusChange);
      const timeout = Duration(seconds: 3);
      await _webSocketChannelSubscription?.cancel().timeout(timeout);
      await _channel?.sink.close().timeout(timeout);
    } catch (e) {
      logger.info("_close exception $e");
    }
  }

  void _startPing() {
    Timer.periodic(pingInterval, (_) {
      if (connectionStatus.value != WsConnectionStatus.connected) return;
      _checkWsConnected();
    });
  }

  void _checkWsConnected() {
    if (_sendPing()) {
      _pingTimer?.cancel();
      _pingTimer = Timer(pingInterval, () {
        logger.warning("No pong received.");
        connectionStatus.value = WsConnectionStatus.disconnected;
        _reconnect();
      });
    }
  }

  bool _sendPing() {
    try {
      _channel!.sink.add('');
      connectionStatus.value = WsConnectionStatus.connected;
    } catch (e) {
      logger.warning("_sendPing exception", e);
      connectionStatus.value = WsConnectionStatus.disconnected;
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
    logger.warning("_reconnect ing");
    connect();
  }

  void sendMessage(List<int> data) {
    try {
      logger.warning("websocket 原数据 : $data");
      _channel!.sink.add(Uint8List.fromList(data));
    } catch (e) {
      logger.warning("ws sendMessage error : $e");
    }
  }

  void _onError(error) {
    logger.severe("websocket error connect", error);
  }

  void _onDone() {
    logger.warning('_webSocketChannelSubscription onDone');
  }
}
