import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/shop_profile_repository.dart';
import '../products/product_list_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopProfileAsync = ref.watch(currentShopProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: shopProfileAsync.when(
          data: (profile) => Text(profile?.name ?? 'Dashboard'),
          loading: () => const Text('Loading...'),
          error: (error, stack) => const Text('Error'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.storefront, size: 64, color: Colors.blue),
            const SizedBox(height: 16),
            const Text(
              'Welcome to your Shop',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Milestone 0 Completed!',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProductListScreen()),
                );
              },
              child: const Text('Manage Products'),
            ),
          ],
        ),
      ),
    );
  }
}
