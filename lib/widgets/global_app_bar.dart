import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import 'theme_toggle_button.dart';

class GlobalAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const GlobalAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  ConsumerState<GlobalAppBar> createState() => _GlobalAppBarState();
}

class _GlobalAppBarState extends ConsumerState<GlobalAppBar> {
  // Create a stream that emits current time every second
  final Stream<DateTime> _timeStream = Stream.periodic(
    const Duration(seconds: 1),
    (_) => DateTime.now(),
  );

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    final second = time.second.toString().padLeft(2, '0');
    return '$hour:$minute:$second';
  }

  String _formatDate(DateTime time) {
    final weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    final months = ['January', 'February', 'March', 'April', 'May', 'June', 
                    'July', 'August', 'September', 'October', 'November', 'December'];
    
    return '${weekdays[time.weekday - 1]}, ${months[time.month - 1]} ${time.day}, ${time.year}';
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Show logout only when authenticated
    final showLogout = authState.isAuthenticated;

    return AppBar(
      automaticallyImplyLeading: false,
      leading: const ThemeToggleButton(),
      title: const Text('POS System'),
      actions: [
        if (showLogout) ...[
          // Date and Time
          StreamBuilder<DateTime>(
            stream: _timeStream,
            initialData: DateTime.now(),
            builder: (context, snapshot) {
              final time = snapshot.data ?? DateTime.now();
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Clock with bigger font
                    Text(
                      _formatTime(time),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isDark 
                            ? const Color(0xFFA3A3A3) 
                            : const Color(0xFF737373),
                      ),
                    ),
                    const SizedBox(height: 1),
                    // Date
                    Text(
                      _formatDate(time),
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark 
                            ? const Color(0xFFA3A3A3) 
                            : const Color(0xFF737373),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(width: 8),
          // Logout button
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authProvider.notifier).logout();
              // Navigation will be handled by the auth state listener in main.dart
            },
          ),
        ],
      ],
    );
  }
}
