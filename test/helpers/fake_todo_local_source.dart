import 'dart:async';

import 'package:todo_riverpod_mvvm/core/database/app_database.dart';

/// TodoLocalSource のテスト用スタブ
///
/// TodoRepositoryImpl が依存する TodoLocalSource と同じメソッドシグネチャを持ち、
/// メモリ上で DB 操作をシミュレートする。
class FakeTodoLocalSource {
  FakeTodoLocalSource([List<TodoData>? initialData])
    : _data = List.of(initialData ?? []);

  final List<TodoData> _data;
  final _controller = StreamController<List<TodoData>>.broadcast();
  int _nextId = 100;

  /// テスト側から内部状態を直接確認するゲッター
  List<TodoData> get data => List.unmodifiable(_data);

  void _notify() {
    _controller.add(List.unmodifiable(_data));
  }

  Stream<List<TodoData>> watchAll() {
    Future.microtask(_notify);
    return _controller.stream;
  }

  Future<TodoData?> findById(int id) async {
    try {
      return _data.firstWhere((d) => d.id == id);
    } on StateError {
      return null;
    }
  }

  Future<void> insertTodo({required String title, String? memo}) async {
    _data.add(
      TodoData(id: _nextId++, title: title, memo: memo, isCompleted: false),
    );
    _notify();
  }

  Future<void> updateTodo(TodoData todo) async {
    final index = _data.indexWhere((d) => d.id == todo.id);
    if (index == -1) throw Exception('TodoData not found: ${todo.id}');
    _data[index] = todo;
    _notify();
  }

  Future<void> deleteTodo(int id) async {
    _data.removeWhere((d) => d.id == id);
    _notify();
  }

  void dispose() {
    _controller.close();
  }
}
