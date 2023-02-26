import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'views/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  const WindowOptions windowOptions = WindowOptions(
      size: Size(800, 600),
      minimumSize: Size(800, 600),
      maximumSize: Size(800, 600),
      center: true,
      titleBarStyle: TitleBarStyle.normal);

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(const Home());
}
