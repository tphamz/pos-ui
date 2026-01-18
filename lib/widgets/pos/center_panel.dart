import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'tabs/products_tab.dart';
import 'tabs/tables_tab.dart';
import 'tabs/staff_tab.dart';
import 'business_switcher.dart';
import '../../providers/pos_provider.dart';

/// Center panel with tabs for Products/Services, Tables, and Staff
class CenterPanel extends ConsumerStatefulWidget {
  const CenterPanel({super.key});

  @override
  ConsumerState<CenterPanel> createState() => _CenterPanelState();
}

class _CenterPanelState extends ConsumerState<CenterPanel> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _getTableLabel(BusinessType businessType) {
    switch (businessType) {
      case BusinessType.restaurant:
        return 'Tables';
      case BusinessType.salon:
        return 'Stations';
      case BusinessType.retail:
        return 'Registers';
    }
  }

  String _getProductLabel() {
    return 'Products';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final businessType = ref.watch(posProvider).businessType;

    return Column(
      children: [
        // Tab Bar
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF292929) : Colors.white,
            border: Border(
              bottom: BorderSide(
                color: isDark ? const Color(0xFF404040) : const Color(0xFFE6E6E6),
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TabBar(
            controller: _tabController,
            indicatorColor: Theme.of(context).colorScheme.primary,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: isDark ? Colors.white : Colors.black,
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
            tabs: [
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.restaurant, size: 16),
                    const SizedBox(width: 8),
                    Text(_getTableLabel(businessType)),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.grid_view, size: 16),
                    const SizedBox(width: 8),
                    Text(_getProductLabel()),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.people, size: 16),
                    const SizedBox(width: 8),
                    const Text('Staff'),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Tab Content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              TablesTab(),
              ProductsTab(),
              StaffTab(),
            ],
          ),
        ),
      ],
    );
  }
}
