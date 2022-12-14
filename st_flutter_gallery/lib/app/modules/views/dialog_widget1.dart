import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/constants/text_max_length.dart';
import 'package:st/app/themes/custom_theme_colors.dart';
import 'package:st/utils/text_input_formatter/number_input_limit.dart';

class DialogModel1 {
  String zuanGanChangDu = '';
  String dangBanJinChi = '';
  String zuanKongZhiJing = '';
  String remark = '';

  @override
  String toString() {
    return 'zuanGanChangDu = $zuanGanChangDu   dangBanJinChi = $dangBanJinChi  zuanKongZhiJing = $zuanKongZhiJing  remark = $remark';
  }
}

class DialogWidget1 extends StatefulWidget {
  const DialogWidget1({Key? key}) : super(key: key);

  @override
  State<DialogWidget1> createState() => _DialogWidget1State();
}

class _DialogWidget1State extends State<DialogWidget1> {
  final textEditingControllerLength = TextEditingController();
  final textEditingControllerJinChi = TextEditingController();
  final textEditingControllerZhiJing = TextEditingController();
  final textEditingControllerRemark = TextEditingController();
  final dialogModel1 = DialogModel1();

  @override
  void initState() {
    textEditingControllerLength.addListener(() {
      dialogModel1.zuanGanChangDu = textEditingControllerLength.text;
    });

    textEditingControllerJinChi.addListener(() {
      dialogModel1.dangBanJinChi = textEditingControllerJinChi.text;
    });

    textEditingControllerZhiJing.addListener(() {
      dialogModel1.zuanKongZhiJing = textEditingControllerZhiJing.text;
    });

    textEditingControllerRemark.addListener(() {
      dialogModel1.remark = textEditingControllerRemark.text;
    });
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
            height: 425,
            constraints: const BoxConstraints(maxHeight: 425, minHeight: 425),
            padding: const EdgeInsets.symmetric(
              horizontal: 29,
              vertical: 36,
            ),
            decoration: BoxDecoration(
              color: Get.theme.backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '*',
                                        style: TextStyle(
                                          color: Get.theme
                                              .extension<CustomThemeColors>()
                                              ?.dangerColor,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: '钻杆长度(m)',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  constraints:
                                      const BoxConstraints(maxHeight: 40),
                                  child: TextField(
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                    controller: textEditingControllerLength,
                                    inputFormatters: [
                                      NumberInputLimit(
                                        digit: 2,
                                        max: numberInputMaxLimit,
                                      ),
                                    ],
                                    style: Get.theme.textTheme.bodyText2,
                                    decoration: InputDecoration(
                                      counterText: "",
                                      fillColor: Get.theme
                                          .extension<CustomThemeColors>()
                                          ?.backgroundColor,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '*',
                                        style: TextStyle(
                                          color: Get.theme
                                              .extension<CustomThemeColors>()
                                              ?.dangerColor,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: '当班进尺(m)',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  constraints:
                                      const BoxConstraints(maxHeight: 40),
                                  child: TextField(
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                    controller: textEditingControllerJinChi,
                                    inputFormatters: [
                                      NumberInputLimit(
                                        digit: 2,
                                        max: numberInputMaxLimit,
                                      ),
                                    ],
                                    style: Get.theme.textTheme.bodyText2,
                                    decoration: InputDecoration(
                                      counterText: "",
                                      fillColor: Get.theme
                                          .extension<CustomThemeColors>()
                                          ?.backgroundColor,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '*',
                                        style: TextStyle(
                                          color: Get.theme
                                              .extension<CustomThemeColors>()
                                              ?.dangerColor,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: '钻孔直径(mm)',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  constraints:
                                      const BoxConstraints(maxHeight: 40),
                                  child: TextField(
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                    controller: textEditingControllerZhiJing,
                                    inputFormatters: [
                                      NumberInputLimit(
                                        digit: 2,
                                        max: numberInputMaxLimit,
                                      ),
                                    ],
                                    style: Get.theme.textTheme.bodyText2,
                                    decoration: InputDecoration(
                                      counterText: "",
                                      fillColor: Get.theme
                                          .extension<CustomThemeColors>()
                                          ?.backgroundColor,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
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
                                      borderSide: BorderSide(
                                        color: Get.theme.dividerColor,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Get.theme.dividerColor,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Get.theme.dividerColor,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    // disabledBorder: OutlineInputBorder(
                                    //   borderSide:
                                    //       BorderSide(color: Get.theme.dividerColor),
                                    //   borderRadius: BorderRadius.circular(4),
                                    // ),
                                  ),
                                ),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceEvenly,
                                //   children: [
                                //     OutlinedButton(
                                //       style: OutlinedButton.styleFrom(
                                //         minimumSize: const Size(104, 48),
                                //       ),
                                //       onPressed: Get.back,
                                //       child: const Text(
                                //         "取消",
                                //       ),
                                //     ),
                                //     const SizedBox(width: 16),
                                //     ElevatedButton(
                                //       style: OutlinedButton.styleFrom(
                                //         minimumSize: const Size(104, 48),
                                //       ),
                                //       onPressed: onConfirm,
                                //       child: const Text(
                                //         "提交",
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
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
                    const SizedBox(width: 16),
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
        ),
      ),
    );
  }

  void onConfirm() {
    if (dialogModel1.zuanGanChangDu.isEmpty) {
      showToast('请填写钻杆长度');
      return;
    }
    if (dialogModel1.dangBanJinChi.isEmpty) {
      showToast('请填写当班进尺');
      return;
    }
    if (dialogModel1.zuanKongZhiJing.isEmpty) {
      showToast('请填写钻孔直径');
      return;
    }

    Get.back(result: dialogModel1);
  }
}
