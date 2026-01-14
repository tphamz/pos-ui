import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('POS System'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authProvider.notifier).logout();
              if (context.mounted) {
                Navigator.of(context).pushReplacementNamed('/login');
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.point_of_sale,
              size: 100,
            ),
            const SizedBox(height: 24),
            Text(
              'Welcome!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            if (authState.user != null) ...[
              Text(
                'User: ${authState.user!.userId}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'Type: ${authState.user!.userType}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (authState.user!.businessId != null)
                Text(
                  'Business: ${authState.user!.businessId}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
            ],
            const SizedBox(height: 48),
            const Text(
              'Home screen - Add your POS features here',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
