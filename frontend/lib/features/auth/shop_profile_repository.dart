import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../core/database/database.dart';
import '../../core/database/database_provider.dart';

class ShopProfileRepository {
  final AppDatabase _db;

  ShopProfileRepository(this._db);

  Future<ShopProfile?> getShopProfile() async {
    return await _db.select(_db.shopProfiles).getSingleOrNull();
  }

  Future<void> createShopProfile(String name, String? phone) async {
    await _db.into(_db.shopProfiles).insert(
          ShopProfilesCompanion.insert(
            name: name,
            phone: phone != null && phone.isNotEmpty ? drift.Value(phone) : const drift.Value.absent(),
          ),
        );
  }
}

final shopProfileRepositoryProvider = Provider<ShopProfileRepository>((ref) {
  return ShopProfileRepository(ref.watch(appDatabaseProvider));
});

final currentShopProfileProvider = FutureProvider<ShopProfile?>((ref) {
  final repo = ref.watch(shopProfileRepositoryProvider);
  return repo.getShopProfile();
});
