import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/pos_theme.dart';
import '../../providers/pos_view_provider.dart';

/// Left sidebar feature menu (64px width)
class FeatureMenu extends ConsumerWidget {
  const FeatureMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final List<MenuItem> menuItems = [
      MenuItem(icon: Icons.point_of_sale, label: 'POS', id: POSView.pos, isMain: true),
      MenuItem(icon: Icons.dashboard, label: 'Dashboard', id: POSView.dashboard),
      MenuItem(icon: Icons.receipt_long, label: 'Orders', id: POSView.orders),
      MenuItem(icon: Icons.bar_chart, label: 'Reports', id: POSView.reports),
      MenuItem(icon: Icons.calendar_today, label: 'Schedule', id: POSView.schedule),
      MenuItem(icon: Icons.people, label: 'Customers', id: POSView.customers),
      MenuItem(icon: Icons.inventory_2, label: 'Inventory', id: POSView.inventory),
      MenuItem(icon: Icons.payment, label: 'Payments', id: POSView.payments),
      MenuItem(icon: Icons.access_time, label: 'Time Clock', id: POSView.timeClock),
    ];

    final List<MenuItem> bottomMenuItems = [
      MenuItem(icon: Icons.help_outline, label: 'Help', id: POSView.help),
      MenuItem(icon: Icons.settings, label: 'Settings', id: POSView.settings),
    ];

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sidebarColor = POSTheme.getSidebarColor(isDark);
    final sidebarForeground = POSTheme.getSidebarForegroundColor(isDark);
    final sidebarAccent = POSTheme.getSidebarAccentColor(isDark);
    final sidebarBorder = POSTheme.getSidebarBorderColor(isDark);
    final activeItem = ref.watch(posViewProvider);

    return Container(
      width: 64,
      decoration: BoxDecoration(
        color: sidebarColor,
      ),
      child: Column(
        children: [
          // Main Menu
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                final isActive = activeItem == item.id;
                return _MenuItemButton(
                  icon: item.icon,
                  label: item.label,
                  isActive: isActive,
                  isMain: item.isMain,
                  onTap: () {
                    // Update active view via provider
                    ref.read(posViewProvider.notifier).state = item.id;
                  },
                  sidebarForeground: sidebarForeground,
                  sidebarAccent: sidebarAccent,
                );
              },
            ),
          ),

          // Bottom Menu
          Container(
            child: Column(
              children: bottomMenuItems.map((item) {
                final isActive = activeItem == item.id;
                return _MenuItemButton(
                  icon: item.icon,
                  label: item.label,
                  isActive: isActive,
                  onTap: () {
                    // Update active view via provider
                    ref.read(posViewProvider.notifier).state = item.id;
                  },
                  sidebarForeground: sidebarForeground,
                  sidebarAccent: sidebarAccent,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem {
  final IconData icon;
  final String label;
  final String id;
  final bool isMain;

  MenuItem({
    required this.icon,
    required this.label,
    required this.id,
    this.isMain = false,
  });
}

class _MenuItemButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final bool isMain;
  final VoidCallback onTap;
  final Color sidebarForeground;
  final Color sidebarAccent;

  const _MenuItemButton({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
    required this.sidebarForeground,
    required this.sidebarAccent,
    this.isMain = false,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      waitDuration: const Duration(milliseconds: 100),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: isMain && isActive
                ? Theme.of(context).colorScheme.primary
                : isActive
                    ? sidebarAccent
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: isMain && isActive
              ? const Center(
                  child: Text(
                    'POS',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              : Icon(
                  icon,
                  size: 20,
                  color: isActive 
                      ? Colors.white 
                      : sidebarForeground.withValues(alpha: 0.6),
                ),
        ),
      ),
    );
  }
}
