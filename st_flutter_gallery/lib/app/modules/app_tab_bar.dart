import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:st/app/modules/home/views/home_view.dart';
import 'package:st/app/modules/user_profile/views/user_profile_view.dart';
import 'package:st/app/themes/custom_theme_colors.dart';
import 'package:st/config/env_config.dart';
import 'package:st/helpers/logger/logger_helper.dart';

class AppTabBar extends StatefulWidget {
  const AppTabBar({Key? key}) : super(key: key);

  @override
  State<AppTabBar> createState() => _AppTabBarState();
}

class _AppTabBarState extends State<AppTabBar>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  final _tabBarViews = [
    const HomeView(),
    const UserProfileView(),
  ];

  @override
  void initState() {
    _tabController = TabController(
      length: _tabBarViews.length,
      vsync: this,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tabItems = [
      TabItem<Widget>(
        icon: SizedBox(
          width: 24,
          height: 24,
          child:
              Image.asset('assets/images/tab_bar/tab_bar_home_unselected.png'),
        ),
        activeIcon: SizedBox(
          width: 24,
          height: 24,
          child: Image.asset('assets/images/tab_bar/tab_bar_home_selected.png'),
        ),
        title: '作业信息'.tr,
      ),
      TabItem<Widget>(
        icon: SizedBox(
          width: 24,
          height: 24,
          child: Image.asset(
            'assets/images/tab_bar/tab_bar_profile_unselected.png',
          ),
        ),
        activeIcon: SizedBox(
          width: 24,
          height: 24,
          child: Image.asset(
            'assets/images/tab_bar/tab_bar_profile_selected.png',
          ),
        ),
        title: '个人中心'.tr,
      ),
    ];

    if (kDebugMode || EnvConfig.isDebug) {
      return Banner(
        message: EnvConfig.envConvertString(EnvConfig.env),
        location: BannerLocation.topStart,
        child: buildScaffoldBody(tabItems),
      );
    }
    return buildScaffoldBody(tabItems);
  }

  Widget buildScaffoldBody(List<TabItem<Widget>> tabItems) {
    return WillPopScope(
      onWillPop: () async {
        await MoveToBackground.moveTaskToBack();
        return false;
      },
      child: Scaffold(
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: _tabBarViews,
        ),
        bottomNavigationBar: StyleProvider(
          style: Style(),
          child: ConvexAppBar.builder(
            itemBuilder: _CustomBuilder(
              tabItems,
              Colors.transparent,
            ),
            count: tabItems.length,
            controller: _tabController,
            backgroundColor:
                Get.theme.extension<CustomThemeColors>()?.tabBarBackgroundColor,
            disableDefaultTabController: true,
            height: 50,
            top: 0,
            curveSize: 0,
            shadowColor: const Color(0xFFD1D2D2),
            elevation: 0.5,
            // gradient: const LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   colors: [Colors.blue, Colors.redAccent, Colors.green, Colors.blue],
            //   tileMode: TileMode.repeated,
            // ),
            cornerRadius: 100,
            onTapNotify: (i) {
              logger.info('onTapNotify $i');
              return true;
            },
            onTap: (i) => debugPrint('click $i'),
          ),

          // child: ConvexAppBar(
          //   items: _tabItems,
          //   style: TabStyle.react,
          //   curve: Curves.bounceInOut,
          //   backgroundColor: Theme.of(context).backgroundColor,
          //   // gradient: const LinearGradient(
          //   //   begin: Alignment.topLeft,
          //   //   end: Alignment.bottomRight,
          //   //   colors: [Colors.blue, Colors.redAccent, Colors.green, Colors.blue],
          //   //   tileMode: TileMode.repeated,
          //   // ),
          //   controller: _tabController,
          //   onTap: (int i) => debugPrint('select index=$i'),
          // ),
        ),
      ),
    );
  }
}

class _CustomBuilder extends DelegateBuilder {
  _CustomBuilder(this.items, this._tabBackgroundColor);
  final List<TabItem> items;
  final Color _tabBackgroundColor;

  @override
  Widget build(BuildContext context, int index, bool active) {
    final navigationItem = items[index];
    final color = active
        ? Get.theme.tabBarTheme.labelColor
        : Get.theme.tabBarTheme.unselectedLabelColor;

    // if (index == items.length ~/ 2) {
    //   return Container(
    //     width: 60,
    //     height: 60,
    //     margin: const EdgeInsets.all(5),
    //     decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    //     child: Icon(
    //       Icons.add,
    //       size: 40,
    //       color: _tabBackgroundColor,
    //     ),
    //   );
    // }
    final icon = active
        ? navigationItem.activeIcon ?? navigationItem.icon
        : navigationItem.icon;
    final title = navigationItem.title ?? "";
    return Container(
      color: _tabBackgroundColor,
      padding: const EdgeInsets.only(bottom: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          icon,
          const SizedBox(height: 8),
          Text(
            title,
            style: Get.theme.tabBarTheme.labelStyle?.copyWith(color: color),
          ),
        ],
      ),
    );
  }

  @override
  bool fixed() {
    return true;
  }
}

class Style extends StyleHook {
  @override
  double get activeIconSize => 40;

  @override
  double get activeIconMargin => 10;

  @override
  double get iconSize => 20;

  @override
  TextStyle textStyle(Color color, String? fontFamily) {
    return TextStyle(fontSize: 20, color: color, fontFamily: fontFamily);
  }
}
