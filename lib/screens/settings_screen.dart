import 'package:english_words_app/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ThemeController.to;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Theme',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: ThemeMode.values.map((mode) {
                  final selected = controller.themeMode.value == mode;
                  return ListTile(
                    leading: Icon(_iconFor(mode)),
                    title: Text(controller.labelFor(mode)),
                    selected: selected,
                    trailing: selected ? const Icon(Icons.check) : null,
                    onTap: () {
                      controller.setThemeMode(mode);
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconFor(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return Icons.light_mode_outlined;
      case ThemeMode.dark:
        return Icons.dark_mode_outlined;
      case ThemeMode.system:
        return Icons.brightness_auto_outlined;
    }
  }
}
