import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/components/custom_appbar.dart';
import 'package:st/app/constants/text_max_length.dart';
import 'package:st/app/themes/custom_theme_colors.dart';
import 'package:st/utils/text_input_formatter/number_input_limit.dart';

enum InputContentType {
  none,

  /// 数字，只能是整数
  digitsOnly,

  /// 数字包括小数
  number,

  /// 精度限制
  precisionLimit,

  /// 方位角限制
  azimuthLimit,

  /// 倾角限制
  dipLimit,
}

class TextFieldEditPage extends StatefulWidget {
  const TextFieldEditPage({
    Key? key,
    this.hintText = '',
    this.title = '',
    this.inputContentType = InputContentType.none,
    this.maxLength,
  }) : super(key: key);
  final String title;
  final String? hintText;
  final InputContentType? inputContentType;
  final int? maxLength;

  @override
  State<TextFieldEditPage> createState() => _TextFieldEditPageState();
}

class _TextFieldEditPageState extends State<TextFieldEditPage> {
  final textEditingController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    textEditingController.addListener(refresh);
    super.initState();
  }

  @override
  void dispose() {
    textEditingController
      ..removeListener(refresh)
      ..dispose();
    focusNode.dispose();
    super.dispose();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Get.theme.extension<CustomThemeColors>()?.backgroundColor,
      appBar: CustomAppbar(
        title: widget.title,
        leadingBuilder: (icon) {
          return TextButton(
            onPressed: () {
              focusNode.unfocus();
              Get.back();
            },
            child: const Text(
              "取消",
            ),
          );
        },
        actions: [
          TextButton(
            onPressed: onConfirm,
            child: const Text(
              "完成",
            ),
          ),
        ],
      ),
      body: Container(
        height: 48,
        color: Get.theme.backgroundColor,
        padding: const EdgeInsets.only(left: 24, right: 10),
        child: TextField(
          autofocus: true,
          controller: textEditingController,
          maxLength: widget.maxLength,
          focusNode: focusNode,
          keyboardType: (widget.inputContentType ==
                      InputContentType.precisionLimit ||
                  widget.inputContentType == InputContentType.digitsOnly ||
                  widget.inputContentType == InputContentType.azimuthLimit ||
                  widget.inputContentType == InputContentType.dipLimit)
              ? const TextInputType.numberWithOptions(decimal: true)
              : null,
          inputFormatters: [
            if (widget.inputContentType == InputContentType.number)
              FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
            if (widget.inputContentType == InputContentType.digitsOnly)
              FilteringTextInputFormatter.digitsOnly,
            if (widget.inputContentType == InputContentType.precisionLimit)
              NumberInputLimit(
                digit: 2,
                max: numberInputMaxLimit,
              ),
            if (widget.inputContentType == InputContentType.azimuthLimit)
              NumberInputLimit(
                digit: 0,
                max: 360,
              ),
            if (widget.inputContentType == InputContentType.dipLimit)
              NumberInputLimit(
                digit: 0,
                isNegative: true,
                max: 90,
                min: -90,
              ),
          ],
          decoration: InputDecoration(
            counterText: "",
            border: InputBorder.none,
            hintText: widget.hintText,
            suffixIconConstraints: const BoxConstraints(maxWidth: 30),
            suffixIcon: textEditingController.text.isEmpty
                ? null
                : IconButton(
                    icon: SvgPicture.asset(
                      'assets/svg/close.svg',
                      color: Get.theme.scaffoldBackgroundColor,
                      width: 14,
                      height: 14,
                    ),
                    onPressed: () {
                      textEditingController.clear();
                      setState(() {});
                    },
                  ),
          ),
        ),
      ),
    );
  }

  void onConfirm() {
    final text = textEditingController.text;
    if (text.isEmpty) {
      showToast('请输入${widget.title.isNotEmpty ? widget.title : '编辑内容'}');
      return;
    }
    Get.back(result: text);
    focusNode.unfocus();
  }
}
