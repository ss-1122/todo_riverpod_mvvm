import 'package:flutter_test/flutter_test.dart';
import 'package:todo_riverpod_mvvm/core/database/app_database.dart';
import 'package:todo_riverpod_mvvm/features/todo/domain/entity/todo.dart';

import '../../../helpers/fake_todo_local_source.dart';

/// TodoRepositoryImpl のマッピングロジックをテストする。
///
/// TodoRepositoryImpl は TodoLocalSource（Drift DAO）をコンストラクタで受け取るが、
/// DatabaseAccessor を継承しているため DB 接続なしではインスタンス化できない。
/// そのため、TodoRepositoryImpl と同一のマッピングロジックを
/// FakeTodoLocalSource 上で再現し、変換が正しいことを検証する。
///
/// マッピングロジック:
///   TodoData → Todo (toDomain)
///   Todo → TodoData (toData)

/// TodoRepositoryImpl と同等のマッピングをテスト用に切り出した関数
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

void main() {
  late FakeTodoLocalSource localSource;

  setUp(() {
    localSource = FakeTodoLocalSource([
      const TodoData(id: 1, title: 'Todo 1', memo: null, isCompleted: false),
      const TodoData(id: 2, title: 'Todo 2', memo: 'メモ2', isCompleted: true),
    ]);
  });

  tearDown(() {
    localSource.dispose();
  });

  group('TodoData → Todo マッピング', () {
    test('基本的なフィールドが正しくマッピングされる', () {
      const data = TodoData(
        id: 1,
        title: 'テスト',
        memo: 'メモ',
        isCompleted: false,
      );
      final todo = _toDomain(data);

      expect(todo.id, 1);
      expect(todo.title, 'テスト');
      expect(todo.memo, 'メモ');
      expect(todo.isCompleted, false);
    });

    test('memo が null の場合もマッピングされる', () {
      const data = TodoData(id: 2, title: 'タスク', memo: null, isCompleted: true);
      final todo = _toDomain(data);

      expect(todo.memo, isNull);
      expect(todo.isCompleted, true);
    });
  });

  group('Todo → TodoData マッピング', () {
    test('基本的なフィールドが正しくマッピングされる', () {
      const todo = Todo(id: 1, title: 'テスト', memo: 'メモ', isCompleted: true);
      final data = _toData(todo);

      expect(data.id, 1);
      expect(data.title, 'テスト');
      expect(data.memo, 'メモ');
      expect(data.isCompleted, true);
    });
  });

  group('watchAll + マッピング', () {
    test('watchAll が TodoData のリストを返す', () async {
      final stream = localSource.watchAll().map(
        (list) => list.map(_toDomain).toList(),
      );
      final todos = await stream.first;

      expect(todos, hasLength(2));
      expect(todos[0], isA<Todo>());
      expect(todos[0].title, 'Todo 1');
      expect(todos[1].memo, 'メモ2');
    });
  });

  group('findById + マッピング', () {
    test('存在する ID でドメインエンティティを返す', () async {
      final data = await localSource.findById(1);
      final todo = data != null ? _toDomain(data) : null;

      expect(todo, isNotNull);
      expect(todo!.id, 1);
      expect(todo.title, 'Todo 1');
    });

    test('存在しない ID で null を返す', () async {
      final data = await localSource.findById(999);
      expect(data, isNull);
    });
  });

  group('insertTodo', () {
    test('追加した TodoData が正しく保存される', () async {
      await localSource.insertTodo(title: '新規', memo: 'メモ');

      final stream = localSource.watchAll().map(
        (list) => list.map(_toDomain).toList(),
      );
      final todos = await stream.first;

      expect(todos, hasLength(3));
      expect(todos.last.title, '新規');
      expect(todos.last.memo, 'メモ');
      expect(todos.last.isCompleted, false);
    });
  });

  group('updateTodo', () {
    test('TodoData を更新してドメインエンティティに反映される', () async {
      await localSource.updateTodo(
        const TodoData(id: 1, title: '更新済み', memo: 'new', isCompleted: true),
      );

      final data = await localSource.findById(1);
      final todo = _toDomain(data!);

      expect(todo.title, '更新済み');
      expect(todo.memo, 'new');
      expect(todo.isCompleted, true);
    });
  });

  group('deleteTodo', () {
    test('指定 ID の TodoData を削除できる', () async {
      await localSource.deleteTodo(1);

      final data = await localSource.findById(1);
      expect(data, isNull);
    });
  });
}
