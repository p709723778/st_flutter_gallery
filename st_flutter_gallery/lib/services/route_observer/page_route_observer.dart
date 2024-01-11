import 'package:flutter/material.dart';
import 'package:st/helpers/logger/logger_helper.dart';

/// https://blog.csdn.net/sinat_17775997/article/details/106570011
/// 可以参照此博客
class PageRouteObserver extends RouteObserver<PageRoute> {
  // 用于路由返回监听
  static final PageRouteObserver routeObserver = PageRouteObserver();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    logger.info('生命周期监听', 'didPush');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    logger.info('生命周期监听', 'didPop');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    logger.info('生命周期监听', 'didReplace');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    logger.info('生命周期监听', 'didRemove');
  }
}
