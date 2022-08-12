import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st/app/modules/home/controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      duration: const Duration(milliseconds: 300),
      data: Theme.of(context),
      child: GetBuilder<HomeController>(
        assignId: true,
        init: HomeController(context: context),
        builder: (logic) {
          return Scaffold(
            appBar: AppBar(
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: const Text('主页'),
            ),
            body: Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
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
                  const Text(
                    'Current Theme Mode',
                    style: TextStyle(
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
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  const Spacer(),
                  const Text(
                    'Current Theme Mode',
                    style: TextStyle(
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
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () =>
                        AdaptiveTheme.of(context).toggleThemeMode(),
                    style: ElevatedButton.styleFrom(
                      visualDensity:
                          const VisualDensity(horizontal: 4, vertical: 2),
                    ),
                    child: const Text('Toggle Theme Mode'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => AdaptiveTheme.of(context).setDark(),
                    style: ElevatedButton.styleFrom(
                      visualDensity:
                          const VisualDensity(horizontal: 4, vertical: 2),
                    ),
                    child: const Text('Set Dark'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => AdaptiveTheme.of(context).setLight(),
                    style: ElevatedButton.styleFrom(
                      visualDensity:
                          const VisualDensity(horizontal: 4, vertical: 2),
                    ),
                    child: const Text('set Light'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => AdaptiveTheme.of(context).setSystem(),
                    style: ElevatedButton.styleFrom(
                      visualDensity:
                          const VisualDensity(horizontal: 4, vertical: 2),
                    ),
                    child: const Text('Set System Default'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => AdaptiveTheme.of(context).setTheme(
                      light: ThemeData(
                        brightness: Brightness.light,
                        primarySwatch: Colors.pink,
                      ),
                      dark: ThemeData(
                        brightness: Brightness.dark,
                        primarySwatch: Colors.pink,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      visualDensity:
                          const VisualDensity(horizontal: 4, vertical: 2),
                    ),
                    child: const Text('Set Custom Theme'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => AdaptiveTheme.of(context).reset(),
                    style: ElevatedButton.styleFrom(
                      visualDensity:
                          const VisualDensity(horizontal: 4, vertical: 2),
                    ),
                    child: const Text('Reset to Default Themes'),
                  ),
                  Text(
                    '${logic.count}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                AdaptiveTheme.of(context).toggleThemeMode();
                logic.increment();
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          );
        },
      ),
    );
  }
}
