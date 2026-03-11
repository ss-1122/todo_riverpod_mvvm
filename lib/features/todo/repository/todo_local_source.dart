import 'package:drift/drift.dart';
import 'package:todo_riverpod_mvvm/core/database/app_database.dart';
import 'package:todo_riverpod_mvvm/core/database/tables/todo_table.dart';

part 'todo_local_source.g.dart';

/// DriftのDAO（Data Access Object）
///
/// Driftを使ったDB操作のローカルソース。
/// ドメインエンティティへのマッピングは TodoRepositoryImpl が担う。
@DriftAccessor(tables: [Todos])
class TodoLocalSource extends DatabaseAccessor<AppDatabase>
    with _$TodoLocalSourceMixin {
  TodoLocalSource(super.db);

  /// 全TodoをStream取得（DBの変更をリアルタイム監視）
  /// id の昇順で固定し、返却順を保証する。
  Stream<List<TodoData>> watchAll() =>
      (select(todos)..orderBy([(t) => OrderingTerm.asc(t.id)])).watch();

  /// 指定IDのTodoを1件取得
  Future<TodoData?> findById(int id) =>
      (select(todos)..where((t) => t.id.equals(id))).getSingleOrNull();

  /// 新規Todoを挿入
  Future<void> insertTodo({required String title, String? memo}) => into(
    todos,
  ).insert(TodosCompanion.insert(title: title, memo: Value(memo)));

  /// 既存Todoを更新
  Future<void> updateTodo(TodoData todo) =>
      (update(todos)..where((t) => t.id.equals(todo.id))).write(
        TodosCompanion(
          title: Value(todo.title),
          memo: Value(todo.memo),
          isCompleted: Value(todo.isCompleted),
        ),
      );

  /// 指定IDのTodoを削除
  Future<void> deleteTodo(int id) =>
      (delete(todos)..where((t) => t.id.equals(id))).go();
}
