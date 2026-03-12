import 'package:flutter_test/flutter_test.dart';
import 'package:todo_riverpod_mvvm/features/todo/usecase/add_todo_usecase.dart';

import '../../../helpers/fake_todo_repository.dart';

void main() {
  late FakeTodoRepository repository;
  late AddTodoUseCase useCase;

  setUp(() {
    repository = FakeTodoRepository();
    useCase = AddTodoUseCase(repository);
  });

  tearDown(() {
    repository.dispose();
  });

  test('タイトルのみでTodoを追加できる', () async {
    await useCase.call(title: 'テストTodo');

    expect(repository.todos, hasLength(1));
    expect(repository.todos.first.title, 'テストTodo');
    expect(repository.todos.first.memo, isNull);
    expect(repository.todos.first.isCompleted, false);
  });

  test('タイトルとメモ付きでTodoを追加できる', () async {
    await useCase.call(title: 'タスク', memo: 'メモ内容');

    expect(repository.todos, hasLength(1));
    expect(repository.todos.first.title, 'タスク');
    expect(repository.todos.first.memo, 'メモ内容');
  });

  test('複数のTodoを順番に追加できる', () async {
    await useCase.call(title: 'Todo 1');
    await useCase.call(title: 'Todo 2');
    await useCase.call(title: 'Todo 3');

    expect(repository.todos, hasLength(3));
    expect(repository.todos[0].title, 'Todo 1');
    expect(repository.todos[1].title, 'Todo 2');
    expect(repository.todos[2].title, 'Todo 3');
  });
}
