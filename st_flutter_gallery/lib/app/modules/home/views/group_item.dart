import 'package:flutter/material.dart';
import 'package:st/utils/text_size/calculate_text_size.dart';

class GroupItem extends StatelessWidget {
  const GroupItem({
    super.key,
    this.text = '',
    this.padding = const EdgeInsets.all(8),
  });

  final String text;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    final size = CalculateTextSize.boundingTextSize(
      context,
      text,
      const TextStyle(),
    );
    return Padding(
      padding: padding,
      child: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          width: size.width + 4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
              ),
              Container(
                width: size.width,
                height: 4,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(3),
                    topRight: Radius.circular(3),
                  ),
                  gradient: LinearGradient(
                    end: Alignment.topLeft,
                    begin: Alignment.bottomRight,
                    colors: [
                      Colors.cyan,
                      Colors.deepPurpleAccent,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
