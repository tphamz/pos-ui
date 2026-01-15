import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';

class ThemeToggleButton extends ConsumerWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    
    IconData icon;
    
    switch (themeMode) {
      case ThemeMode.light:
        icon = Icons.light_mode;
        break;
      case ThemeMode.dark:
        icon = Icons.dark_mode;
        break;
      case ThemeMode.system:
        icon = Icons.brightness_auto;
        break;
    }
    
    return IconButton(
      icon: Icon(icon),
      onPressed: () async {
        await ref.read(themeProvider.notifier).toggleTheme();
      },
    );
  }
}
