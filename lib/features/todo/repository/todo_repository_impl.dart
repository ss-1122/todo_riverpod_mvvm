import 'package:todo_riverpod_mvvm/core/database/app_database.dart';
import 'package:todo_riverpod_mvvm/features/todo/domain/entity/todo.dart';
import 'package:todo_riverpod_mvvm/features/todo/domain/repository/todo_repository.dart';
import 'package:todo_riverpod_mvvm/features/todo/repository/todo_local_source.dart';

/// TodoRepository の具象実装
///
/// TodoLocalSource（Drift DAO）を通じてDBにアクセスし、
/// TodoData（Driftデータクラス）↔ Todo（ドメインエンティティ）のマッピングを行う。
class TodoRepositoryImpl implements TodoRepository {
  const TodoRepositoryImpl(this._localSource);

  final TodoLocalSource _localSource;

  @override
  Stream<List<Todo>> watchAll() =>
      _localSource.watchAll().map((list) => list.map(_toDomain).toList());

  @override
  Future<Todo?> findById(int id) async {
    final data = await _localSource.findById(id);
    return data != null ? _toDomain(data) : null;
  }

  @override
  Future<void> add({required String title, String? memo}) =>
      _localSource.insertTodo(title: title, memo: memo);

  @override
  Future<void> update(Todo todo) => _localSource.updateTodo(_toData(todo));

  @override
  Future<void> delete(int id) => _localSource.deleteTodo(id);

  // ─── マッピング ────────────────────────────────────────────────

  Todo _toDomain(TodoData data) => Todo(
        id: data.id,
        title: data.title,
        memo: data.memo,
        isCompleted: data.isCompleted,
      );

  TodoData _toData(Todo todo) => TodoData(
        id: todo.id,
        title: todo.title,
        memo: todo.memo,
        isCompleted: todo.isCompleted,
      );
}
