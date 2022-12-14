import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ZKCheckBox extends StatefulWidget {
  const ZKCheckBox({Key? key, this.value = false, this.onChanged})
      : super(key: key);
  final bool? value;
  final ValueChanged<bool>? onChanged;

  @override
  ZKCheckBoxState createState() => ZKCheckBoxState();
}

class ZKCheckBoxState extends State<ZKCheckBox> {
  bool? _isCheck = false;

  @override
  void initState() {
    _isCheck = widget.value;
    super.initState();
  }

  @override
  void didUpdateWidget(ZKCheckBox oldWidget) {
    if (oldWidget.value != widget.value) _isCheck = widget.value;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    const normalColor = Color(0x595C6273);
    final selectedColor = Get.theme.primaryColor;
    return GestureDetector(
      onTap: () {
        widget.onChanged?.call(!_isCheck!);
        setState(() {});
      },
      child: _isCheck!
          ? Icon(
              Icons.check_circle,
              size: 20,
              color: selectedColor,
            )
          : const Icon(
              Icons.check_circle_outlined,
              size: 20,
              color: normalColor,
            ),
    );
  }
}
