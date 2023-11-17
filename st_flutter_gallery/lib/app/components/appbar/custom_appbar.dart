import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EmptyAppBar({super.key});

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
    super.key,
    required this.title,
    this.centerTitle = true,
    this.actions,
    this.isShowLeading = true,
    this.leadingBuilder,
    this.systemOverlayStyle = SystemUiOverlayStyle.dark,
  });

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
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
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
    const icon = Icon(
      Icons.arrow_back_ios_new,
      color: Colors.black,
      size: 18,
    );

    return (leadingBuilder != null)
        ? leadingBuilder!(icon)
        : isShowLeading
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 18,
                ),
                onPressed: Get.back,
              )
            : const SizedBox();
  }

  @override
  Size get preferredSize => const Size.fromHeight(44);
}
