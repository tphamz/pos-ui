import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/pos/feature_menu.dart';
import '../widgets/pos/center_panel.dart';
import '../widgets/pos/ticket_panel.dart';

/// Main POS Screen with three-panel layout
class POSScreen extends ConsumerWidget {
  const POSScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Row(
        children: [
          // Left - Feature Menu (64px width)
          const FeatureMenu(),
          
          // Middle - Main Content
          const Expanded(
            child: CenterPanel(),
          ),
          
          // Right - Ticket Panel (320px width)
          const TicketPanel(),
        ],
      ),
    );
  }
}
