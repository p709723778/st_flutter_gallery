import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:st/app/locale/message_keys.dart';
import 'package:st/app/modules/home/views/home_view.dart';
import 'package:st/app/routes/app_pages.dart';
import 'package:st/config/env_config.dart';
import 'package:st/services/services_manager.dart';

const appName = '应用画廊';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ServicesManager.initServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const home = HomeView();
    final body = buildGetMaterialApp(home: home);
    if (kDebugMode || EnvConfig.isDebug) {
      return buildGetMaterialApp(
        home: Banner(
          message: EnvConfig.envConvertString(EnvConfig.env),
          location: BannerLocation.topStart,
          child: home,
        ),
      );
    }
    return body;
  }

  Widget buildGetMaterialApp({Widget? home}) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: AdaptiveTheme(
        light: ThemeData.light(),
        dark: ThemeData.dark(),
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) {
          return GetMaterialApp(
            title: appName,
            locale: Get.deviceLocale,
            theme: theme,
            darkTheme: darkTheme,
            enableLog: EnvConfig.isDebug || kDebugMode,
            fallbackLocale:
                const Locale('zh', 'Hans'), // 添加一个回调语言选项，以备上面指定的语言翻译不存在
            translations: MessageKeys(),
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
            // initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            home: home,
          );
        },
      ),
    );
  }
}
