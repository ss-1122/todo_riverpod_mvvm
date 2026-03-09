import 'package:drift/drift.dart';

/// DriftのTodosテーブル定義
///
/// DBスキーマ:
/// - id          : INTEGER, PRIMARY KEY AUTOINCREMENT
/// - title       : TEXT, NOT NULL
/// - memo        : TEXT, NULL許容
/// - is_completed: INTEGER (bool), NOT NULL, DEFAULT 0
///
/// @DataClassName('TodoData') でドメインエンティティ Todo との命名衝突を避ける
@DataClassName('TodoData')
class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get memo => text().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
}
