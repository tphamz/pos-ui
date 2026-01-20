import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'tabs/products_tab.dart';
import 'tabs/tables_tab.dart';
import 'tabs/staff_tab.dart';
import '../../providers/blueprint_provider.dart';
import '../../providers/pos_view_provider.dart';
import 'views/placeholder_view.dart';
import 'views/settings_view.dart';

/// Center panel with tabs for Products/Services, Tables, and Staff
class CenterPanel extends ConsumerStatefulWidget {
  const CenterPanel({super.key});

  @override
  ConsumerState<CenterPanel> createState() => _CenterPanelState();
}

class _CenterPanelState extends ConsumerState<CenterPanel> with TickerProviderStateMixin {
  TabController? _tabController;
  int _previousTabCount = 0;
  List<String> _previousVisibleTabs = [];

  void _updateTabControllerIfNeeded(List<String> visibleTabs) {
    if (_tabController == null) {
      // First time - create controller
      _tabController = TabController(length: visibleTabs.length, vsync: this);
      _previousTabCount = visibleTabs.length;
      _previousVisibleTabs = visibleTabs;
    } else if (_previousTabCount != visibleTabs.length || 
               !_listsEqual(_previousVisibleTabs, visibleTabs)) {
      // Tab count or order changed - need to recreate controller
      _tabController!.dispose();
      _tabController = TabController(length: visibleTabs.length, vsync: this);
      _previousTabCount = visibleTabs.length;
      _previousVisibleTabs = visibleTabs;
    }
  }

  bool _listsEqual(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Get active view from provider
    final activeView = ref.watch(posViewProvider);
    
    // If dashboard, show placeholder view
    if (activeView == POSView.dashboard) {
      return _buildPlaceholderView(context, activeView, isDark);
    }
    
    // If not pos, show placeholder view
    if (activeView != POSView.pos) {
      return _buildPlaceholderView(context, activeView, isDark);
    }
    
    // Get blueprint data reactively
    final labelMappings = ref.watch(labelMappingsProvider);
    final uiSchema = ref.watch(uiSchemaProvider);
    
    // Get labels from blueprint
    final tableLabel = (labelMappings['tables'] as String?) ?? 'Tables';
    final productLabel = (labelMappings['products'] as String?) ?? 'Products';
    final staffLabel = (labelMappings['staff'] as String?) ?? 'Staff';
    
    // Get UI schema for conditional tab rendering
    final posScreenSchema = uiSchema['pos_screen'] as Map<String, dynamic>?;
    final showTables = posScreenSchema?['show_tables'] as bool? ?? true; // Default to true for backward compatibility
    final showStaff = posScreenSchema?['show_staff'] as bool? ?? true;
    
    // Get tabs configuration from UI schema
    final tabsSchema = uiSchema['tabs'] as Map<String, dynamic>?;
    final centerPanelTabs = tabsSchema?['center_panel'] as List<dynamic>?;
    
    // Determine which tabs to show
    final List<String> visibleTabs = [];
    if (centerPanelTabs != null) {
      // Use tabs from UI schema
      visibleTabs.addAll(centerPanelTabs.map((e) => e.toString()));
    } else {
      // Fallback: show all tabs based on show flags
      if (showTables) visibleTabs.add('tables');
      visibleTabs.add('products'); // Always show products
      if (showStaff) visibleTabs.add('staff');
    }
    
    // Update tab controller if tab count or order changed
    _updateTabControllerIfNeeded(visibleTabs);

    return Column(
      children: [
        // Tab Bar
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF292929) : Colors.white,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _tabController != null ? TabBar(
            controller: _tabController!,
            indicator: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: isDark 
                ? const Color(0xFFA3A3A3) 
                : const Color(0xFF737373),
            labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 14,
            ),
            tabs: visibleTabs.map((tabKey) {
              String label;
              IconData icon;
              
              switch (tabKey) {
                case 'tables':
                  label = tableLabel;
                  icon = Icons.restaurant;
                  break;
                case 'products':
                  label = productLabel;
                  icon = Icons.grid_view;
                  break;
                case 'staff':
                  label = staffLabel;
                  icon = Icons.people;
                  break;
                default:
                  label = tabKey;
                  icon = Icons.circle;
              }
              
              return Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 16),
                    const SizedBox(width: 8),
                    Text(label),
                  ],
                ),
              );
            }).toList(),
          ) : const SizedBox.shrink(),
        ),

        // Tab Content
        Expanded(
          child: _tabController != null ? TabBarView(
            controller: _tabController!,
            children: visibleTabs.map((tabKey) {
              switch (tabKey) {
                case 'tables':
                  return const TablesTab();
                case 'products':
                  return const ProductsTab();
                case 'staff':
                  return const StaffTab();
                default:
                  return const SizedBox.shrink();
              }
            }).toList(),
          ) : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildPlaceholderView(BuildContext context, String viewId, bool isDark) {
    switch (viewId) {
      case POSView.dashboard:
        return const PlaceholderView(
          title: 'Dashboard',
          icon: Icons.dashboard,
          description: 'Coming soon',
        );
      case POSView.orders:
        return const PlaceholderView(
          title: 'Orders',
          icon: Icons.receipt_long,
          description: 'View and manage order history. Coming soon!',
        );
      case POSView.reports:
        return const PlaceholderView(
          title: 'Reports',
          icon: Icons.bar_chart,
          description: 'Sales reports and analytics. Coming soon!',
        );
      case POSView.schedule:
        return const PlaceholderView(
          title: 'Schedule',
          icon: Icons.calendar_today,
          description: 'Manage appointments and staff schedules. Coming soon!',
        );
      case POSView.customers:
        return const PlaceholderView(
          title: 'Customers',
          icon: Icons.people,
          description: 'Manage customer information and history. Coming soon!',
        );
      case POSView.inventory:
        return const PlaceholderView(
          title: 'Inventory',
          icon: Icons.inventory_2,
          description: 'Track stock levels and inventory movements. Coming soon!',
        );
      case POSView.payments:
        return const PlaceholderView(
          title: 'Payments',
          icon: Icons.payment,
          description: 'View payment history and methods. Coming soon!',
        );
      case POSView.timeClock:
        return const PlaceholderView(
          title: 'Time Clock',
          icon: Icons.access_time,
          description: 'Track staff time and attendance. Coming soon!',
        );
      case POSView.help:
        return const PlaceholderView(
          title: 'Help',
          icon: Icons.help_outline,
          description: 'Documentation and support. Coming soon!',
        );
      case POSView.settings:
        return const SettingsView();
      default:
        return const PlaceholderView(
          title: 'Coming Soon',
          icon: Icons.construction,
        );
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
}
