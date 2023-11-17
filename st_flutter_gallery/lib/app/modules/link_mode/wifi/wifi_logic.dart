import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/manager/tcp_socket_manager.dart';

class WifiLogic extends GetxController {
  final TextEditingController serverIpController = TextEditingController();
  final TextEditingController serverPortController = TextEditingController();

  @override
  void onInit() {
    serverIpController.text = '192.168.80.1';
    serverPortController.text = '6000';
    super.onInit();
  }

  @override
  void onClose() {
    serverIpController.dispose();
    serverPortController.dispose();
    super.onClose();
  }

  Future<void> connect() async {
    if (serverIpController.text.isEmpty) {
      showToast('请输入服务器IP地址');
      return;
    }

    if (serverPortController.text.isEmpty) {
      showToast('请输入服务器端口');
      return;
    }

    TcpSocketManager.instance
      ..ipAddress = serverIpController.text
      ..port = int.parse(serverPortController.text);
    await TcpSocketManager.instance.connect();
    update();
  }

  Future<void> disconnect() async {
    await TcpSocketManager.instance.disconnect();
    update();
  }

  bool get isConnect =>
      TcpSocketManager.instance.connectionStatus.value ==
      TcpConnectionStatus.connected;
}
