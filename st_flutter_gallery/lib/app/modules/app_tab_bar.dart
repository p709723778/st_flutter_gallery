import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/home/views/home_view.dart';
import 'package:st/app/modules/page_route_aware/views/page_route_aware_view.dart';
import 'package:st/app/modules/test_code_page/views/test_code_page_view.dart';
import 'package:st/config/env_config.dart';
import 'package:st/helpers/logger/logger_helper.dart';

class AppTabBar extends StatefulWidget {
  const AppTabBar({super.key});

  @override
  State<AppTabBar> createState() => _AppTabBarState();
}

class _AppTabBarState extends State<AppTabBar>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  final _tabBarViews = [
    const HomeView(),
    const TestCodePageView(),
    const PageRouteAwareView(),
    const Text('data4'),
    const Text('data5'),
  ];

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 2,
      length: _tabBarViews.length,
      vsync: this,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tabItems = [
      TabItem<IconData>(icon: Icons.home, title: '首页'.tr),
      TabItem<IconData>(icon: Icons.category, title: '分类'.tr),
      TabItem<IconData>(icon: Icons.search, title: '搜索'.tr),
      TabItem<IconData>(icon: Icons.mode, title: '样例'.tr),
      TabItem<IconData>(icon: Icons.people, title: '我的'.tr),
    ];

    Widget bottomNavigationBar = StyleProvider(
      style: Style(),
      child: ConvexAppBar.builder(
        itemBuilder: _CustomBuilder(tabItems, Theme.of(context).primaryColor),
        count: tabItems.length,
        controller: _tabController,
        backgroundColor: Theme.of(context).primaryColor,
        disableDefaultTabController: true,
        height: 50,
        top: 0,
        elevation: 0,
        curveSize: 0,
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
    );

    if (EnvConfig.isLamentGrey) {
      bottomNavigationBar = ColorFiltered(
        colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.color),
        child: bottomNavigationBar,
      );
    }

    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: _tabBarViews,
      ),
      bottomNavigationBar: bottomNavigationBar,
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
    final color = active ? Colors.white : Colors.white60;

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
          Icon(icon, color: color),
          Text(title, style: TextStyle(color: color)),
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
