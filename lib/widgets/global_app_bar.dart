import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import 'theme_toggle_button.dart';

class GlobalAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const GlobalAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    
    // Show logout only when authenticated
    final showLogout = authState.isAuthenticated;

    return AppBar(
      automaticallyImplyLeading: false,
      leading: const ThemeToggleButton(),
      title: const Text('POS System'),
      actions: [
        if (showLogout)
          // Logout button
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authProvider.notifier).logout();
              // Navigation will be handled by the auth state listener in main.dart
            },
          ),
      ],
    );
  }
}
