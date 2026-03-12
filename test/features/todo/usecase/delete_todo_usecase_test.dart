import 'package:flutter_test/flutter_test.dart';
import 'package:todo_riverpod_mvvm/features/todo/domain/entity/todo.dart';
import 'package:todo_riverpod_mvvm/features/todo/usecase/delete_todo_usecase.dart';

import '../../../helpers/fake_todo_repository.dart';

void main() {
  late FakeTodoRepository repository;
  late DeleteTodoUseCase useCase;

  setUp(() {
    repository = FakeTodoRepository([
      const Todo(id: 1, title: 'Todo 1', isCompleted: false),
      const Todo(id: 2, title: 'Todo 2', isCompleted: true),
      const Todo(id: 3, title: 'Todo 3', isCompleted: false),
    ]);
    useCase = DeleteTodoUseCase(repository);
  });

  tearDown(() {
    repository.dispose();
  });

  test('指定IDのTodoを削除できる', () async {
    await useCase.call(id: 2);

    expect(repository.todos, hasLength(2));
    expect(repository.todos.any((t) => t.id == 2), false);
  });

  test('削除後に残りのTodoが正しい', () async {
    await useCase.call(id: 1);

    expect(repository.todos, hasLength(2));
    expect(repository.todos[0].id, 2);
    expect(repository.todos[1].id, 3);
  });

  test('存在しないIDの削除はエラーにならない', () async {
    await useCase.call(id: 999);

    expect(repository.todos, hasLength(3));
  });
}
