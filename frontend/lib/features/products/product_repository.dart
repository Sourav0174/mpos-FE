import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../core/database/database.dart';
import '../../core/database/database_provider.dart';

class ProductRepository {
  final AppDatabase _db;

  ProductRepository(this._db);

  /// Streams all products ordered by newest first.
  Stream<List<Product>> watchProducts() {
    return (_db.select(_db.products)
          ..orderBy([
            (t) => drift.OrderingTerm(expression: t.createdAt, mode: drift.OrderingMode.desc)
          ]))
        .watch();
  }

  /// Adds a new product to the local database.
  Future<void> addProduct({
    required String barcode,
    required String name,
    required double sellingPrice,
    required double currentStock,
  }) async {
    await _db.into(_db.products).insert(
          ProductsCompanion.insert(
            barcode: barcode,
            name: name,
            sellingPrice: sellingPrice,
            currentStock: drift.Value(currentStock),
          ),
        );
  }
}

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository(ref.watch(appDatabaseProvider));
});

final productListStreamProvider = StreamProvider<List<Product>>((ref) {
  final repo = ref.watch(productRepositoryProvider);
  return repo.watchProducts();
});
