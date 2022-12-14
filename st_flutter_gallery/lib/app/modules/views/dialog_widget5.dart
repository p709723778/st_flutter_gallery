import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/constants/text_max_length.dart';
import 'package:st/app/themes/custom_theme_colors.dart';
import 'package:st/utils/text_input_formatter/number_input_limit.dart';

class DialogModel5 {
  String fengKongChangDu = '';
  String remark = '';

  @override
  String toString() {
    return 'fengKongChangDu = $fengKongChangDu  remark = $remark';
  }
}

class DialogWidget5 extends StatefulWidget {
  const DialogWidget5({Key? key}) : super(key: key);

  @override
  State<DialogWidget5> createState() => _DialogWidget5State();
}

class _DialogWidget5State extends State<DialogWidget5> {
  final textEditingControllerZhiJing = TextEditingController();
  final textEditingControllerShenDu = TextEditingController();
  final textEditingControllerRemark = TextEditingController();
  final dialogModel5 = DialogModel5();

  @override
  void initState() {
    textEditingControllerZhiJing.addListener(() {
      dialogModel5.fengKongChangDu = textEditingControllerZhiJing.text;
    });

    textEditingControllerRemark.addListener(() {
      dialogModel5.remark = textEditingControllerRemark.text;
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
            height: 325,
            constraints: const BoxConstraints(maxHeight: 325, minHeight: 325),
            padding: const EdgeInsets.symmetric(
              horizontal: 29,
              vertical: 36,
            ),
            decoration: BoxDecoration(
              color: Get.theme.backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView(
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
                                  text: '封孔长度(m)',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            constraints: const BoxConstraints(maxHeight: 40),
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
    if (dialogModel5.fengKongChangDu.isEmpty) {
      showToast('请填写封孔长度');
      return;
    }

    Get.back(result: dialogModel5);
  }
}
