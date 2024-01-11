import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_ume_kit_console_plus/flutter_ume_kit_console_plus.dart'; // debugPrint 插件包
import 'package:flutter_ume_kit_device_plus/flutter_ume_kit_device_plus.dart'; // 设备信息插件包
import 'package:flutter_ume_kit_dio_plus/flutter_ume_kit_dio_plus.dart'; // Dio 网络请求调试工具
import 'package:flutter_ume_kit_perf_plus/flutter_ume_kit_perf_plus.dart'; // 性能插件包
import 'package:flutter_ume_kit_show_code_plus/flutter_ume_kit_show_code_plus.dart'; // 代码查看插件包
import 'package:flutter_ume_kit_ui_plus/flutter_ume_kit_ui_plus.dart'; // UI 插件包
import 'package:flutter_ume_plus/flutter_ume_plus.dart'; // UME 框架
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:st/app/lang/translation_service.dart';
import 'package:st/app/modules/app_tab_bar.dart';
import 'package:st/app/network_request/http.dart';
import 'package:st/app/routes/app_pages.dart';
import 'package:st/app/themes/themes.dart';
import 'package:st/config/env_config.dart';
import 'package:st/helpers/logger/logger_helper.dart';
import 'package:st/services/route_observer/page_route_observer.dart';
import 'package:st/services/services_manager.dart';

const appName = '应用画廊';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ServicesManager.initServices();

  if (kDebugMode) {
    PluginManager.instance // 注册插件
      ..register(const WidgetInfoInspector())
      ..register(const WidgetDetailInspector())
      ..register(const ColorSucker())
      ..register(AlignRuler())
      ..register(const ColorPicker()) // 新插件
      ..register(const TouchIndicator()) // 新插件
      ..register(Performance())
      ..register(const ShowCode())
      ..register(const MemoryInfoPage())
      ..register(CpuInfoPage())
      ..register(const DeviceInfoPanel())
      ..register(Console())
      ..register(DioInspector(dio: Http.networkHelper.dio)); // 传入你的 Dio 实例
    // flutter_ume 0.3.0 版本之后
    runApp(
      ValueListenableBuilder<bool>(
        valueListenable: EnvConfig.isEnableUME,
        builder: (context, enable, child) {
          return UMEWidget(enable: enable, child: const MyApp());
        },
      ),
    ); // 初始化
    // / 初始化
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const tabBar = AppTabBar();
    var body = buildGetMaterialApp(home: tabBar);
    if (kDebugMode || EnvConfig.isDebug) {
      body = buildGetMaterialApp(
        home: Banner(
          message: EnvConfig.env.title,
          location: BannerLocation.topStart,
          child: tabBar,
        ),
      );
    }

    return body;
  }

  Widget buildGetMaterialApp({Widget? home}) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: AdaptiveTheme(
        light: lightTheme,
        dark: darkTheme,
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) {
          return OKToast(
            textPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: GetMaterialApp(
              title: appName,
              locale: TranslationService.locale,
              theme: theme,
              darkTheme: darkTheme,
              enableLog: EnvConfig.isDebug || kDebugMode,
              logWriterCallback: LoggerHelper.log,
              fallbackLocale: TranslationService
                  .fallbackLocale, // 添加一个回调语言选项，以备上面指定的语言翻译不存在
              translations: TranslationService(),
              localizationsDelegates: const [
                // ... app-specific localization delegate[s] here
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale.fromSubtags(languageCode: 'zh'),
                Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
                Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Haunt'),
                Locale.fromSubtags(
                  languageCode: 'zh',
                  scriptCode: 'Hans',
                  countryCode: 'CN',
                ),
                Locale.fromSubtags(
                  languageCode: 'zh',
                  scriptCode: 'Haunt',
                  countryCode: 'TW',
                ),
                Locale.fromSubtags(
                  languageCode: 'zh',
                  scriptCode: 'Haunt',
                  countryCode: 'HK',
                ),
                Locale('en', 'US'),
              ],
              navigatorObservers: [
                /// 页面监听
                PageRouteObserver.routeObserver,
              ],
              // initialRoute: AppPages.INITIAL,
              getPages: AppPages.routes,
              home: home,
            ),
          );
        },
      ),
    );
  }
}
