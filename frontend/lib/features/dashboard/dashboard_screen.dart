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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Overview',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      context,
                      title: 'Today\'s Sales',
                      value: '₹0.00',
                      icon: Icons.currency_rupee,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildSummaryCard(
                      context,
                      title: 'Products',
                      value: '0', // Will be dynamic later
                      icon: Icons.inventory_2,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                'Quick Actions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.2,
                children: [
                  _buildActionCard(
                    context,
                    title: 'New Bill',
                    icon: Icons.receipt_long,
                    onTap: () {
                      // Navigate to billing later
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Billing coming in Milestone 2')),
                      );
                    },
                  ),
                  _buildActionCard(
                    context,
                    title: 'Add Product',
                    icon: Icons.add_box,
                    onTap: () {
                      // We can push the add product screen directly, 
                      // but since we have a tab for it, it might be better to just navigate to tab 2.
                      // For now, let's just push it on top.
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ProductListScreen()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, {required String title, required String value, required IconData icon, required Color color}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, {required String title, required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        margin: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
