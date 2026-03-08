import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod_mvvm/core/database/tables/todo_table.dart';

part 'app_database.g.dart';

/// Driftのデータベースクラス
///
/// @DriftDatabase アノテーションにより、コード生成で _$AppDatabase ミックスインが生成される。
/// テーブル定義は core/database/tables/ に切り出して管理する。
@DriftDatabase(tables: [Todos])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

/// データベースファイルの接続を遅延初期化する
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'todo.db'));
    return NativeDatabase.createInBackground(file);
  });
}

/// AppDatabase を Riverpod で管理する Provider
///
/// ref.onDispose で DB を適切にクローズする。
@riverpod
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
}
