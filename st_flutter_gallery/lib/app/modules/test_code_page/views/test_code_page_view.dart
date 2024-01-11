import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/lang/translation_service.dart';
import 'package:st/app/modules/test_code_page/controllers/test_code_page_controller.dart';
import 'package:st/app/themes/custom_theme_colors.dart';
import 'package:st/config/env_config.dart';

class TestCodePageView extends GetView<TestCodePageController> {
  const TestCodePageView({super.key});

  @override
  Widget build(BuildContext context) {
    Widget body = AnimatedTheme(
      duration: const Duration(milliseconds: 300),
      data: Theme.of(context),
      child: GetBuilder<TestCodePageController>(
        assignId: true,
        init: TestCodePageController(context: context),
        builder: (logic) {
          return Scaffold(
            appBar: AppBar(
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: Text('测试代码'.tr),
            ),
            body: Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: IntrinsicHeight(
                  child: Column(
                    // Column is also a layout widget. It takes a list of children and
                    // arranges them vertically. By default, it sizes itself to fit its
                    // children horizontally, and tries to be as tall as its parent.
                    //
                    // Invoke "debug painting" (press "p" in the console, choose the
                    // "Toggle Debug Paint" action from the Flutter Inspector in Android
                    // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                    // to see the wireframe for each widget.
                    //
                    // Column has various properties to control how it sizes itself and
                    // how it positions its children. Here we use mainAxisAlignment to
                    // center the children vertically; the main axis here is the vertical
                    // axis because Columns are vertical (the cross axis would be
                    // horizontal).
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '当前主题模式'.tr,
                        style: const TextStyle(
                          fontSize: 20,
                          letterSpacing: 0.8,
                        ),
                      ),
                      Text(
                        AdaptiveTheme.of(context).mode.modeName.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '您已经多次按下按钮：'.tr,
                      ),
                      const Spacer(),
                      Text(
                        '当前主题扩展颜色'.tr,
                        style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 0.8,
                          color: Theme.of(context)
                              .extension<CustomThemeColors>()!
                              .testColor,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () =>
                            AdaptiveTheme.of(context).toggleThemeMode(),
                        style: ElevatedButton.styleFrom(
                          visualDensity:
                              const VisualDensity(horizontal: 4, vertical: 2),
                        ),
                        child: Text('切换主题模式'.tr),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => AdaptiveTheme.of(context).setDark(),
                        style: ElevatedButton.styleFrom(
                          visualDensity:
                              const VisualDensity(horizontal: 4, vertical: 2),
                        ),
                        child: Text('设置黑暗'.tr),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => AdaptiveTheme.of(context).setLight(),
                        style: ElevatedButton.styleFrom(
                          visualDensity:
                              const VisualDensity(horizontal: 4, vertical: 2),
                        ),
                        child: Text('设置浅色'.tr),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => AdaptiveTheme.of(context).setSystem(),
                        style: ElevatedButton.styleFrom(
                          visualDensity:
                              const VisualDensity(horizontal: 4, vertical: 2),
                        ),
                        child: Text('设置系统默认值'.tr),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => AdaptiveTheme.of(context).setTheme(
                          light: ThemeData(
                            brightness: Brightness.light,
                            primarySwatch: Colors.pink,
                            extensions: const <ThemeExtension<dynamic>>[
                              CustomThemeColors(
                                testColor: Colors.lightBlue,
                              ),
                            ],
                          ),
                          dark: ThemeData(
                            brightness: Brightness.dark,
                            primarySwatch: Colors.pink,
                            extensions: const <ThemeExtension<dynamic>>[
                              CustomThemeColors(
                                testColor: Colors.lightGreenAccent,
                              ),
                            ],
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          visualDensity:
                              const VisualDensity(horizontal: 4, vertical: 2),
                        ),
                        child: Text('设置自定义主题'.tr),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => AdaptiveTheme.of(context).reset(),
                        style: ElevatedButton.styleFrom(
                          visualDensity:
                              const VisualDensity(horizontal: 4, vertical: 2),
                        ),
                        child: Text('重置为默认主题'.tr),
                      ),
                      Text(
                        '${logic.count}',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                TranslationService.changeLocale();
                logic.increment();
              },
              tooltip: '增量'.tr,
              child: const Icon(Icons.add),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          );
        },
      ),
    );
    if (EnvConfig.isLamentGrey) {
      body = ColorFiltered(
        colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.color),
        child: body,
      );
    }

    return body;
  }
}
