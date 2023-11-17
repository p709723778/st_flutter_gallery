import 'package:flutter/material.dart';
import 'package:st/helpers/logger/logger_helper.dart';
import 'package:st/services/route_observer/page_route_observer.dart';

class PageRouteAwareView extends StatefulWidget {
  const PageRouteAwareView({super.key});

  @override
  State<PageRouteAwareView> createState() => _PageRouteAwareViewState();
}

// mixin RouteAware {}

class _PageRouteAwareViewState extends State<PageRouteAwareView>
    implements RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context)! as PageRoute;
    PageRouteObserver.routeObserver.subscribe(this, route);
  }

  /// 当前的页面被push显示到用户面前 viewWillAppear.
  @override
  void didPush() {
    logger.info('didPush');
  }

  /// 当前的页面被pop viewWillDisappear.
  @override
  void didPop() {
    logger.info('didPop');
  }

  /// 上面的页面被pop后当前页面被显示时 viewWillAppear.
  @override
  void didPopNext() {
    logger.info('didPopNext');
  }

  /// 从当前页面push到另一个页面 viewWillDisappear.
  @override
  void didPushNext() {
    logger.info('didPushNext');
  }

  @override
  void dispose() {
    PageRouteObserver.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PageRouteAwareView',
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PageRouteAwareView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
