import 'package:flutter/material.dart';
import '../../theme/pos_theme.dart';
import 'settings_dialog.dart';

/// Left sidebar feature menu (64px width)
class FeatureMenu extends StatefulWidget {
  const FeatureMenu({super.key});

  @override
  State<FeatureMenu> createState() => _FeatureMenuState();
}

class _FeatureMenuState extends State<FeatureMenu> {
  String _activeItem = 'dashboard';

  final List<MenuItem> _menuItems = [
    MenuItem(icon: Icons.dashboard, label: 'Dashboard', id: 'dashboard'),
    MenuItem(icon: Icons.receipt_long, label: 'Orders', id: 'orders'),
    MenuItem(icon: Icons.bar_chart, label: 'Reports', id: 'reports'),
    MenuItem(icon: Icons.calendar_today, label: 'Schedule', id: 'schedule'),
    MenuItem(icon: Icons.people, label: 'Customers', id: 'customers'),
    MenuItem(icon: Icons.inventory_2, label: 'Inventory', id: 'inventory'),
    MenuItem(icon: Icons.payment, label: 'Payments', id: 'payments'),
    MenuItem(icon: Icons.access_time, label: 'Time Clock', id: 'timeclock'),
  ];

  final List<MenuItem> _bottomMenuItems = [
    MenuItem(icon: Icons.help_outline, label: 'Help', id: 'help'),
    MenuItem(icon: Icons.settings, label: 'Settings', id: 'settings'),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sidebarColor = POSTheme.getSidebarColor(isDark);
    final sidebarForeground = POSTheme.getSidebarForegroundColor(isDark);
    final sidebarAccent = POSTheme.getSidebarAccentColor(isDark);
    final sidebarBorder = POSTheme.getSidebarBorderColor(isDark);

    return Container(
      width: 64,
      decoration: BoxDecoration(
        color: sidebarColor,
        border: Border(
          right: BorderSide(color: sidebarBorder),
        ),
      ),
      child: Column(
        children: [
          // Logo
          Container(
            height: 56,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: sidebarBorder),
              ),
            ),
            child: Center(
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'POS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Main Menu
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _menuItems.length,
              itemBuilder: (context, index) {
                final item = _menuItems[index];
                final isActive = _activeItem == item.id;
                return _MenuItemButton(
                  icon: item.icon,
                  label: item.label,
                  isActive: isActive,
                  onTap: () {
                    setState(() {
                      _activeItem = item.id;
                    });
                    // Show settings dialog when settings is clicked
                    if (item.id == 'settings') {
                      showDialog(
                        context: context,
                        builder: (context) => const SettingsDialog(),
                      );
                    }
                  },
                  sidebarForeground: sidebarForeground,
                  sidebarAccent: sidebarAccent,
                );
              },
            ),
          ),

          // Bottom Menu
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: sidebarBorder),
              ),
            ),
            child: Column(
              children: _bottomMenuItems.map((item) {
                final isActive = _activeItem == item.id;
                return _MenuItemButton(
                  icon: item.icon,
                  label: item.label,
                  isActive: isActive,
                  onTap: () {
                    setState(() {
                      _activeItem = item.id;
                    });
                    // Show settings dialog when settings is clicked
                    if (item.id == 'settings') {
                      showDialog(
                        context: context,
                        builder: (context) => const SettingsDialog(),
                      );
                    }
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

  MenuItem({required this.icon, required this.label, required this.id});
}

class _MenuItemButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
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
            color: isActive ? sidebarAccent : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: isActive 
                ? Colors.white 
                : sidebarForeground.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}
