import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoadingUtil {
  static void showLoading({String? message}) {
    EasyLoading.show(
      status: message ?? '命令发送中',
      maskType: EasyLoadingMaskType.black,
    );
    Future.delayed(const Duration(seconds: 3), EasyLoading.dismiss);
  }
}
