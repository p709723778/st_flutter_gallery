import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogWidget3 extends StatefulWidget {
  const DialogWidget3({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<DialogWidget3> createState() => _DialogWidget3State();
}

class _DialogWidget3State extends State<DialogWidget3> {
  final textEditingControllerRemark = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 245, maxWidth: 343),
            padding: const EdgeInsets.symmetric(
              horizontal: 29,
            ),
            decoration: BoxDecoration(
              color: Get.theme.backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 77),
                      Text(
                        widget.title ?? '是否确认?'.tr,
                        style: Get.theme.textTheme.bodyText2,
                      ),
                      const SizedBox(height: 70),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(104, 48),
                            ),
                            onPressed: onCancel,
                            child: const Text(
                              "取消",
                            ),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(104, 48),
                            ),
                            onPressed: onConfirm,
                            child: const Text(
                              "确定",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onConfirm() {
    Get.back(result: true);
  }

  void onCancel() {
    Get.back(result: false);
  }
}
