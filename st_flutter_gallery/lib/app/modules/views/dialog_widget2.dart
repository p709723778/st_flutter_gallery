import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/constants/text_max_length.dart';
import 'package:st/app/themes/custom_theme_colors.dart';

class DialogWidget2 extends StatefulWidget {
  const DialogWidget2({Key? key}) : super(key: key);

  @override
  State<DialogWidget2> createState() => _DialogWidget2State();
}

class _DialogWidget2State extends State<DialogWidget2> {
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
            constraints: const BoxConstraints(maxHeight: 250),
            padding: const EdgeInsets.symmetric(
              horizontal: 29,
              vertical: 36,
            ),
            decoration: BoxDecoration(
              color: Get.theme.backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '备注：'.tr,
                        style: Get.theme.textTheme.bodyText2,
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: textEditingControllerRemark,
                        maxLines: 3,
                        maxLength: remarkContentMaxLength,
                        style: Get.theme.textTheme.bodyText2,
                        decoration: InputDecoration(
                          counterText: "",
                          fillColor: Get.theme
                              .extension<CustomThemeColors>()
                              ?.backgroundColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Get.theme.dividerColor),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Get.theme.dividerColor),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Get.theme.dividerColor),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          // disabledBorder: OutlineInputBorder(
                          //   borderSide:
                          //       BorderSide(color: Get.theme.dividerColor),
                          //   borderRadius: BorderRadius.circular(4),
                          // ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(104, 48),
                            ),
                            onPressed: Get.back,
                            child: const Text(
                              "取消",
                            ),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(104, 48),
                            ),
                            onPressed: onConfirm,
                            child: const Text(
                              "提交",
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
    Get.back(result: textEditingControllerRemark.text);
  }
}
