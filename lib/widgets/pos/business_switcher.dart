import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/pos_provider.dart';

enum BusinessType { salon, restaurant, retail }

/// Business type switcher dropdown
class BusinessSwitcher extends ConsumerWidget {
  const BusinessSwitcher({super.key});

  static const Map<BusinessType, Map<String, dynamic>> _businessTypes = {
    BusinessType.salon: {
      'label': 'Salon',
      'icon': Icons.content_cut,
    },
    BusinessType.restaurant: {
      'label': 'Restaurant',
      'icon': Icons.restaurant,
    },
    BusinessType.retail: {
      'label': 'Retail',
      'icon': Icons.shopping_bag,
    },
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final businessType = ref.watch(posProvider).businessType;
    final current = _businessTypes[businessType]!;

    return PopupMenuButton<BusinessType>(
      initialValue: businessType,
      onSelected: (BusinessType type) {
        ref.read(posProvider.notifier).setBusinessType(type);
      },
      child: Container(
        width: 160,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF383838) : const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDark ? const Color(0xFF404040) : const Color(0xFFE6E6E6),
          ),
        ),
        child: Row(
          children: [
            Icon(
              current['icon'] as IconData,
              size: 16,
              color: isDark ? const Color(0xFFD9D9D9) : const Color(0xFF262626),
            ),
            const SizedBox(width: 8),
            Text(
              current['label'] as String,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? const Color(0xFFD9D9D9) : const Color(0xFF262626),
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_drop_down,
              size: 20,
              color: isDark ? const Color(0xFFD9D9D9) : const Color(0xFF262626),
            ),
          ],
        ),
      ),
      itemBuilder: (BuildContext context) {
        return _businessTypes.entries.map((entry) {
          final type = entry.key;
          final data = entry.value;
          return PopupMenuItem<BusinessType>(
            value: type,
            child: Row(
              children: [
                Icon(
                  data['icon'] as IconData,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(data['label'] as String),
              ],
            ),
          );
        }).toList();
      },
    );
  }
}
