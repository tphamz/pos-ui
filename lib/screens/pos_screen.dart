import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/pos/feature_menu.dart';
import '../widgets/pos/center_panel.dart';
import '../widgets/pos/ticket_panel.dart';
import '../widgets/pos/business_switcher.dart';

/// Main POS Screen with three-panel layout
class POSScreen extends ConsumerStatefulWidget {
  const POSScreen({super.key});

  @override
  ConsumerState<POSScreen> createState() => _POSScreenState();
}

class _POSScreenState extends ConsumerState<POSScreen> {
  String _activeMenuItem = 'dashboard';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Row(
        children: [
          // Left - Feature Menu (64px width)
          const FeatureMenu(),
          
          // Middle - Main Content
          Expanded(
            child: Column(
              children: [
                // Top Bar
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: isDark 
                        ? const Color(0xFF292929) 
                        : Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: isDark 
                            ? const Color(0xFF404040) 
                            : const Color(0xFFE6E6E6),
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const BusinessSwitcher(),
                      Text(
                        _getFormattedDate(),
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
                
                // Center Panel
                const Expanded(
                  child: CenterPanel(),
                ),
              ],
            ),
          ),
          
          // Right - Ticket Panel (320px width)
          const TicketPanel(),
        ],
      ),
    );
  }

  String _getFormattedDate() {
    final now = DateTime.now();
    final weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    final months = ['January', 'February', 'March', 'April', 'May', 'June', 
                    'July', 'August', 'September', 'October', 'November', 'December'];
    
    return '${weekdays[now.weekday - 1]}, ${months[now.month - 1]} ${now.day}, ${now.year}';
  }
}
