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
    final currentRoute = ModalRoute.of(context)?.settings.name;

    // Don't show back button on home screen or login screen
    // Check if we can pop by checking if route is not initial routes
    final showBackButton = currentRoute != '/home' && 
                          currentRoute != '/login' &&
                          currentRoute != null;
    
    // Show logout only when authenticated
    final showLogout = authState.isAuthenticated;

    return AppBar(
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                // Use Navigator only when button is pressed, not during build
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
            )
          : null,
      automaticallyImplyLeading: false,
      title: const Text('POS System'),
      actions: [
        if (showLogout) ...[
          // Theme toggle next to logout
          const ThemeToggleButton(),
          // Logout button
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authProvider.notifier).logout();
              if (context.mounted) {
                Navigator.of(context).pushReplacementNamed('/login');
              }
            },
          ),
        ] else ...[
          // Theme toggle when not logged in
          const ThemeToggleButton(),
        ],
      ],
    );
  }
}
