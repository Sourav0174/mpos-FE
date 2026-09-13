import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

/// Base table containing all the audit fields required by the Core Engineering Rules.
/// Every table inheriting from this will automatically get UUIDs, timestamps, and sync tracking.
abstract class BaseTable extends Table {
  TextColumn get id => text().clientDefault(() => uuid.v4())(); // UUID v4, generated at insert
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  
  /// Tracks if this record needs to be synced to the backend: 'pending', 'synced', or 'failed'
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ShopProfile')
class ShopProfiles extends BaseTable {
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
}

@DataClassName('Product')
class Products extends BaseTable {
  TextColumn get barcode => text().unique()();
  TextColumn get name => text()();
  RealColumn get sellingPrice => real()();
  RealColumn get currentStock => real().withDefault(const Constant(0.0))();
}

@DataClassName('Bill')
class Bills extends BaseTable {
  RealColumn get totalAmount => real()();
  TextColumn get paymentMode => text().nullable()(); // e.g., 'CASH', 'UPI', 'CARD', 'SPLIT'
  TextColumn get status => text().withDefault(const Constant('COMPLETED'))();
}

@DataClassName('BillItem')
class BillItems extends BaseTable {
  TextColumn get billId => text().references(Bills, #id)();
  TextColumn get productId => text().references(Products, #id)();
  RealColumn get quantity => real()();
  RealColumn get unitPrice => real()();
  RealColumn get totalPrice => real()();
}
