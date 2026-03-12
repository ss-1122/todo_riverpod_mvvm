import 'dart:async';

import 'package:todo_riverpod_mvvm/features/todo/domain/entity/todo.dart';
import 'package:todo_riverpod_mvvm/features/todo/domain/repository/todo_repository.dart';

/// テスト用の手動スタブ Repository
///
/// 内部に `List<Todo>` を保持し、Stream で変更を通知する。
/// 外部モックライブラリを使わず、flutter_test のみで完結する。
class FakeTodoRepository implements TodoRepository {
  FakeTodoRepository([List<Todo>? initialTodos])
    : _todos = List.of(initialTodos ?? []);

  final List<Todo> _todos;
  final _controller = StreamController<List<Todo>>.broadcast();
  int _nextId = 100;

  /// テスト側から現在の内部状態を確認するためのゲッター
  List<Todo> get todos => List.unmodifiable(_todos);

  void _notify() {
    _controller.add(List.unmodifiable(_todos));
  }

  @override
  Stream<List<Todo>> watchAll() {
    // 購読開始直後に現在の状態を流す
    Future.microtask(_notify);
    return _controller.stream;
  }

  @override
  Future<Todo?> findById(int id) async {
    try {
      return _todos.firstWhere((t) => t.id == id);
    } on StateError {
      return null;
    }
  }

  @override
  Future<void> add({required String title, String? memo}) async {
    final todo = Todo(
      id: _nextId++,
      title: title,
      memo: memo,
      isCompleted: false,
    );
    _todos.add(todo);
    _notify();
  }

  @override
  Future<void> update(Todo todo) async {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index == -1) throw Exception('Todo not found: ${todo.id}');
    _todos[index] = todo;
    _notify();
  }

  @override
  Future<void> delete(int id) async {
    _todos.removeWhere((t) => t.id == id);
    _notify();
  }

  void dispose() {
    _controller.close();
  }
}
