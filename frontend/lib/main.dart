import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'features/auth/shop_profile_repository.dart';
import 'features/auth/shop_setup_screen.dart';
import 'features/dashboard/dashboard_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MPOSApp(),
    ),
  );
}

class MPOSApp extends ConsumerWidget {
  const MPOSApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeNotifierProvider);

    return MaterialApp(
      title: 'mPOS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: Consumer(
        builder: (context, ref, child) {
          final profileAsync = ref.watch(currentShopProfileProvider);
          
          return profileAsync.when(
            data: (profile) {
              if (profile == null) {
                return const ShopSetupScreen();
              }
              return const DashboardScreen();
            },
            loading: () => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
            error: (err, stack) => Scaffold(
              body: Center(child: Text('Error: $err')),
            ),
          );
        },
      ),
    );
  }
}
