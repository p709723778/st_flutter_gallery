import 'package:get/get.dart';
import 'package:st/app/modules/component_detail_page/bindings/component_detail_page_binding.dart';
import 'package:st/app/modules/component_detail_page/views/component_detail_view.dart';
import 'package:st/app/modules/home/bindings/home_binding.dart';
import 'package:st/app/modules/home/views/home_view.dart';
import 'package:st/app/modules/page_route_aware/bindings/page_route_aware_binding.dart';
import 'package:st/app/modules/page_route_aware/views/page_route_aware_view.dart';
import 'package:st/app/modules/test_code_page/bindings/test_code_page_binding.dart';
import 'package:st/app/modules/test_code_page/views/test_code_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PAGE_ROUTE_AWARE,
      page: () => const PageRouteAwareView(),
      binding: PageRouteAwareBinding(),
    ),
    GetPage(
      name: _Paths.TEST_CODE_PAGE,
      page: () => const TestCodePageView(),
      binding: TestCodePageBinding(),
    ),
    GetPage(
      name: _Paths.COMPONENT_DETAIL_PAGE,
      page: () => const ComponentDetailView(),
      binding: ComponentDetailPageBinding(),
    ),
  ];
}
