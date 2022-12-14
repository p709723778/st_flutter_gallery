import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EmptyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Size get preferredSize => const Size.fromHeight(0);
}

typedef AppbarLeadingBuilder = Widget Function(Widget);

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    Key? key,
    required this.title,
    this.centerTitle = true,
    this.actions,
    this.isShowLeading = true,
    this.leadingBuilder,
    this.systemOverlayStyle = SystemUiOverlayStyle.dark,
  }) : super(key: key);

  /// 标题
  final String title;
  final bool centerTitle;
  final bool isShowLeading;
  final List<Widget>? actions;
  final AppbarLeadingBuilder? leadingBuilder;
  final SystemUiOverlayStyle systemOverlayStyle;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        centerTitle: centerTitle,
        title: Text(title),
        actions: actions,
        leading: _leading(),
        systemOverlayStyle: systemOverlayStyle,
        flexibleSpace: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              stops: [0.0, 1.0],
              colors: [
                Color(0xFFC7CCDF),
                Color(0xFFE6E8F0),
              ],
            ),
          ),
        ),
        elevation: 0,
        // surfaceTintColor: Colors.transparent,
        // shadowColor: Colors.transparent,
        // backgroundColor: Colors.transparent,
        // foregroundColor: Colors.transparent,
      ),
    );
  }

  /// 左侧视图
  Widget _leading() {
    final icon = Image.asset(
      'assets/images/nav_bar/nav_bar_back.png',
      width: 18,
      height: 17,
    );

    return (leadingBuilder != null)
        ? leadingBuilder!(icon)
        : isShowLeading
            ? IconButton(
                icon: Image.asset(
                  'assets/images/nav_bar/nav_bar_back.png',
                  width: 18,
                  height: 17,
                ),
                onPressed: Get.back,
              )
            : const SizedBox();
  }

  @override
  Size get preferredSize => const Size.fromHeight(44);
}
