import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/edit_mode_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/entity_providers.dart';
import '../../../providers/pos_provider.dart';
import '../../../utils/snackbar_helper.dart';
import '../password_dialog.dart';

/// Settings view for POS system (shown in main area)
class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final editMode = ref.watch(editModeProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          // Edit Mode Toggle
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Edit Mode',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Enable editing, creating, and deleting items',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark 
                              ? const Color(0xFFA3A3A3) 
                              : const Color(0xFF737373),
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: editMode,
                  onChanged: (value) {
                    ref.read(editModeProvider.notifier).setEditMode(value);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 24),
          // Sync option
          _SettingsMenuItem(
            icon: Icons.sync,
            label: 'Sync',
            description: 'Synchronize local data with server',
            onTap: () => _handleSync(context, ref),
            isWarning: false,
          ),
          const SizedBox(height: 12),
          // Backup option
          _SettingsMenuItem(
            icon: Icons.backup,
            label: 'Backup',
            description: 'Replace server data with local data (may affect user data)',
            onTap: () => _handleBackup(context, ref),
            isWarning: true,
          ),
          const SizedBox(height: 12),
          // Restore option
          _SettingsMenuItem(
            icon: Icons.restore,
            label: 'Restore',
            description: 'Replace local data with server data (may affect user data)',
            onTap: () => _handleRestore(context, ref),
            isWarning: true,
          ),
        ],
      ),
    );
  }

  Future<void> _handleSync(BuildContext context, WidgetRef ref) async {
    final authState = ref.read(authProvider);
    final businessId = authState.currentBusinessId;
    if (businessId == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Business ID not found')),
        );
      }
      return;
    }

    try {
      final entityService = ref.read(entityServiceProvider(businessId));
      await entityService.manualSync();
      
      // Refresh POS provider to reload data from local DB
      final posNotifier = ref.read(posProvider.notifier);
      await posNotifier.refresh();
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sync completed successfully. App refreshed.')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        showErrorSnackBar(context, 'Sync failed: ${e.toString()}');
      }
    }
  }

  Future<void> _handleBackup(BuildContext context, WidgetRef ref) async {
    final authState = ref.read(authProvider);
    final businessId = authState.currentBusinessId;
    if (businessId == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Business ID not found')),
        );
      }
      return;
    }

    // Show password dialog first
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) => PasswordDialog(
          title: 'Backup Data',
          message: 'This will replace server data with local data. This action may affect user data. Please enter your password to continue.',
          onVerified: () async {
            try {
              final entityService = ref.read(entityServiceProvider(businessId));
              await entityService.backup();
              
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Backup completed successfully')),
                );
              }
            } catch (e) {
              if (context.mounted) {
                showErrorSnackBar(context, 'Backup failed: ${e.toString()}');
              }
            }
          },
        ),
      );
    }
  }

  Future<void> _handleRestore(BuildContext context, WidgetRef ref) async {
    final authState = ref.read(authProvider);
    final businessId = authState.currentBusinessId;
    if (businessId == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Business ID not found')),
        );
      }
      return;
    }

    // Show password dialog first
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) => PasswordDialog(
          title: 'Restore Data',
          message: 'This will replace all local data with server data. This action may affect user data. Please enter your password to continue.',
          onVerified: () async {
            try {
              final entityService = ref.read(entityServiceProvider(businessId));
              await entityService.restore();
              
              // Refresh POS provider to reload data from local DB
              final posNotifier = ref.read(posProvider.notifier);
              await posNotifier.refresh();
              
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Restore completed successfully. App refreshed.')),
                );
              }
            } catch (e) {
              if (context.mounted) {
                showErrorSnackBar(context, 'Restore failed: ${e.toString()}');
              }
            }
          },
        ),
      );
    }
  }
}

class _SettingsMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String description;
  final VoidCallback onTap;
  final bool isWarning;

  const _SettingsMenuItem({
    required this.icon,
    required this.label,
    required this.description,
    required this.onTap,
    this.isWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isWarning 
        ? Colors.orange 
        : (isDark ? const Color(0xFFE5E5E5) : const Color(0xFF171717));

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark 
                          ? const Color(0xFFA3A3A3) 
                          : const Color(0xFF737373),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: isDark 
                  ? const Color(0xFFA3A3A3) 
                  : const Color(0xFF737373),
            ),
          ],
        ),
      ),
    );
  }
}
