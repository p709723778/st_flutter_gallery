import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:st/app/components/fade_background_button.dart';
import 'package:st/app/themes/custom_theme_colors.dart';

class LinkTile extends StatelessWidget {
  const LinkTile(
    this.context,
    this.title, {
    Key? key,
    this.trailing,
    this.height,
    this.onTap,
    this.showTrailingIcon = false,
    this.padding,
    this.borderRadius = 0,
    this.trailingWidget,
    this.titleExpanded = false,
    this.backgroundColor,
    this.tapDownBackgroundColor,
    this.isAsterisk = false,
  }) : super(key: key);
  final BuildContext context;
  final Widget title;
  final Widget? trailing;
  final double? height;
  final GestureTapCallback? onTap;
  final bool showTrailingIcon;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final Widget? trailingWidget;
  final bool titleExpanded;
  final Color? backgroundColor;
  final Color? tapDownBackgroundColor;
  final bool isAsterisk;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FadeBackgroundButton(
      onTap: onTap,
      height: height,
      backgroundColor: backgroundColor ?? theme.backgroundColor,
      tapDownBackgroundColor:
          tapDownBackgroundColor ?? theme.backgroundColor.withOpacity(0.5),
      borderRadius: borderRadius,
      child: Padding(
        padding: padding ??
            EdgeInsets.symmetric(
              vertical: height == null ? 16 : 0,
              horizontal: 12,
            ),
        child: Row(
          children: titleExpanded ? getTitleExpanded() : getTrailingExpanded(),
        ),
      ),
    );
  }

  List<Widget> getTitleExpanded() {
    return [
      Expanded(
        child: DefaultTextStyle(
          style: Get.theme.textTheme.bodyText2!.copyWith(fontSize: 14),
          child: title,
        ),
      ),
      const SizedBox(height: 8),
      if (trailing != null)
        Align(
          alignment: Alignment.centerRight,
          child: DefaultTextStyle(
            style: Get.theme.textTheme.bodyText2!.copyWith(fontSize: 14),
            child: trailing!,
          ),
        ),
      if (showTrailingIcon)
        trailingWidget ?? const MoreIcon()
      else
        const SizedBox(height: 14, width: 14),
    ];
  }

  List<Widget> getTrailingExpanded() {
    return [
      if (isAsterisk)
        Text(
          '*',
          style: TextStyle(
            color: Get.theme.extension<CustomThemeColors>()?.dangerColor,
          ),
        ),
      title,
      const SizedBox(width: 8),
      Expanded(
        child: Align(
          alignment: Alignment.centerRight,
          child: trailing ?? const SizedBox(),
        ),
      ),
      const SizedBox(height: 8),
      if (showTrailingIcon)
        trailingWidget ?? const MoreIcon()
      else
        const SizedBox(height: 14, width: 14),
    ];
  }
}

class MoreIcon extends StatelessWidget {
  const MoreIcon({Key? key, this.size = 14, this.color}) : super(key: key);
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/svg/xiayibu.svg',
      color: color ?? Get.theme.textTheme.subtitle1?.color,
      width: size,
      height: size,
    );
  }
}
