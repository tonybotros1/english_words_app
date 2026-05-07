import 'package:english_words_app/consts.dart';
import 'package:english_words_app/controllers/theme_controller.dart';
import 'package:english_words_app/screens/main_screen.dart';
import 'package:english_words_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeController = Get.put(ThemeController());
  await themeController.loadThemeMode();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeController.to.themeMode.value,
      home: MainScreen(),
    );
  }
}
