import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_life_state/flutter_life_state.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:st/app/lang/translation_service.dart';
import 'package:st/app/routes/app_pages.dart';
import 'package:st/app/themes/themes.dart';
import 'package:st/common/engine.dart';
import 'package:st/common/global.dart';
import 'package:st/config/env_config.dart';
import 'package:st/helpers/logger/logger_helper.dart';
import 'package:st/services/services_manager.dart';

const appName = '矿用智能打钻管理助手';

Future<void> main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  // flutter闪屏后再隐藏原生闪屏UI([Engine.allowRender])
  Engine.deferRender(binding);

  initLogger();

  Global.packageInfo = await PackageInfo.fromPlatform();

  logger
    ..info('版本号: ${Global.packageInfo?.version}')
    ..info('buildNumber: ${Global.packageInfo?.buildNumber}');

  await ServicesManager.initServices();
  // 设置Android头部的导航栏透明
  if (GetPlatform.isAndroid) {
    final systemUiOverlayStyle =
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final body = buildGetMaterialApp();
    return body;
  }

  Widget buildGetMaterialApp() {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: AdaptiveTheme(
        light: lightTheme,
        dark: darkTheme,
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) {
          return OKToast(
            radius: 8,
            backgroundColor: Get.textTheme.bodyText2?.color?.withOpacity(0.95),
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
              navigatorKey: Global.navigatorKey,
              initialRoute: AppPages.INITIAL,
              getPages: AppPages.routes,
              builder: EasyLoading.init(),
              navigatorObservers: [
                lifeFouteObserver,
              ],
            ),
          );
        },
      ),
    );
  }
}
