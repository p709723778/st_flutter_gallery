import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/manager/socket_message_manager.dart';
import 'package:st/app/models/platform_domain_name/platform_domain_name_set_req_model.dart';
import 'package:st/app/models/platform_domain_name/platform_domain_name_set_resp_model.dart';
import 'package:st/app/models/platform_ip/platform_ip_get_req_model.dart';
import 'package:st/app/models/platform_ip/platform_ip_get_resp_model.dart';
import 'package:st/extension/string_extension.dart';
import 'package:st/utils/reg_exps/reg_exps.dart';

class PlatformDomainNameSetLogic extends GetxController {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();

  final TextEditingController controllerPort1 = TextEditingController();
  final TextEditingController controllerPort2 = TextEditingController();
  final TextEditingController controllerPort3 = TextEditingController();

  late StreamSubscription _streamSubscription;

  bool isSelectTcp1 = true;
  bool isSelectTcp2 = false;
  bool isSelectTcp3 = false;

  @override
  void onInit() {
    // controller1.text = '192.168.12.0';
    // controller2.text = '192.168.12.1';
    // controller3.text = '192.168.12.2';
    // controllerPort1.text = '6000';
    // controllerPort2.text = '6001';
    // controllerPort3.text = '6002';

    _streamSubscription = SocketMessageManager.instance
        .on<PlatformIpGetRespModel>()
        .listen((event) {
      if (event.tcpInfo.hasValue) {
        setTcpInfo(event.tcpInfo);
        showToast('平台域名查询成功');
      } else {
        showToast('平台域名查询失败');
      }
      EasyLoading.dismiss();

      update();
    });

    _streamSubscription = SocketMessageManager.instance
        .on<PlatformDomainNameSetRespModel>()
        .listen((event) {
      EasyLoading.dismiss();
      if (event.result == 0) {
        showToast('平台域名设置成功');
      } else {
        showToast('平台域名设置失败');
      }
      update();
    });
    search();
    super.onInit();
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
    super.onClose();
  }

  void done() {
    final tcp1 = controller1.text;
    final tcp2 = controller2.text;
    final tcp3 = controller3.text;

    final port1 = controllerPort1.text;
    final port2 = controllerPort2.text;
    final port3 = controllerPort3.text;

    if ((tcp1.isEmpty && port1.isEmpty) &&
        (tcp2.isEmpty && port2.isEmpty) &&
        (tcp3.isEmpty && port3.isEmpty)) {
      showToast('请至少输入一个TCP地址和端口号');
      return;
    }

    var tcpList = '';

    final doMainRegExp = RegExp(regExp_SimpleDoMain);

    if (isSelectTcp1) {
      if (tcp1.isEmpty || port1.isEmpty) {
        showToast('请输入TCP1完整的信息');
        return;
      } else {
        if (!doMainRegExp.hasMatch(tcp1)) {
          showToast('请输入正确的TCP1域名地址');
          return;
        }

        tcpList += 'T$tcp1,$port1';
      }
    }

    if (isSelectTcp2) {
      if (tcp2.isEmpty || port2.isEmpty) {
        showToast('请输入TCP2完整的信息');
        return;
      } else {
        if (!doMainRegExp.hasMatch(tcp2)) {
          showToast('请输入正确的TCP2域名地址');
          return;
        }
        tcpList += 't$tcp2,$port2';
      }
    }

    if (isSelectTcp3) {
      if (tcp3.isEmpty || port3.isEmpty) {
        showToast('请输入TCP3完整的信息');
        return;
      } else {
        if (!doMainRegExp.hasMatch(tcp3)) {
          showToast('请输入正确的TCP3域名地址');
          return;
        }
        tcpList += 's$tcp3,$port3';
      }
    }

    final bytes = utf8.encode(tcpList);

    final reqModel = PlatformDomainNameSetReqModel(dataBytes: bytes);
    SocketMessageManager.instance.sendMessage(reqModel.commandFrame);
  }

  void search() {
    SocketMessageManager.instance
        .sendMessage(PlatformIpGetReqModel().commandFrame);
  }

  /// 查询到的tcp信息进行匹配, 显示在输入框里
  void setTcpInfo(String tcpInfo) {
    final tempListString = tcpInfo.replaceAll('\r\n\\0', '');

    /// TCP2匹配
    final tcpPort3 = extractionTcpString(tempListString, 'TCP2:', ' ');

    /// TCP1匹配
    final tcpPort2 = extractionTcpString(tempListString, 'TCP1:', ' TCP:');

    /// TCP匹配
    const startString = ' TCP:';
    final startIndex = tempListString.indexOf(startString) + startString.length;
    final endIndex = tempListString.length;
    var result = '';
    if (startIndex != -1 && endIndex != -1) {
      result = tempListString.substring(startIndex, endIndex).trim();
    }
    final tcpPort1 = result.replaceAll('\r\n\\0', '');

    if (tcpPort3.hasValue) {
      final tcpPortStrList3 = tcpPort3.split(',');
      controller3.text = tcpPortStrList3.first;
      controllerPort3.text = tcpPortStrList3.last;
    }

    if (tcpPort2.hasValue) {
      final tcpPortStrList2 = tcpPort2.split(',');
      controller2.text = tcpPortStrList2.first;
      controllerPort2.text = tcpPortStrList2.last;
    }

    if (tcpPort1.hasValue) {
      final tcpPortStrList1 = tcpPort1.split(',');
      controller1.text = tcpPortStrList1.first;
      controllerPort1.text = tcpPortStrList1.last;
    }
  }

  /// tcp字符串信息提取
  String extractionTcpString(
    String tempListString,
    String startString,
    String endString,
  ) {
    try {
      final startIndex =
          tempListString.indexOf(startString) + startString.length;
      final endIndex = tempListString.indexOf(endString);
      var result = '';
      if (startIndex != -1 && endIndex != -1) {
        result = tempListString.substring(startIndex, endIndex).trim();
      }
      return result;
    } catch (e) {
      return '';
    }
  }
}
