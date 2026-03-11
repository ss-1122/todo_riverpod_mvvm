import 'package:drift/drift.dart';

/// DriftのTodosテーブル定義
///
/// DBスキーマ:
/// - id          : INTEGER, PRIMARY KEY AUTOINCREMENT
/// - title       : TEXT, NOT NULL
/// - memo        : TEXT, NULL許容
/// - is_completed: INTEGER (bool), NOT NULL, DEFAULT 0
///
/// Driftはテーブルクラス名の末尾 's' を除いた名前（ここでは `Todo`）をデータクラスとして生成する。
/// これはドメインエンティティ [Todo] と衝突するため、@DataClassName でDB行クラス名を `TodoData` に指定する。
/// これはDrift公式が推奨する命名衝突の解決パターンである。
@DataClassName('TodoData')
class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get memo => text().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
}
