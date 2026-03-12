import 'package:flutter_test/flutter_test.dart';
import 'package:todo_riverpod_mvvm/features/todo/domain/entity/todo.dart';
import 'package:todo_riverpod_mvvm/features/todo/usecase/get_todo_by_id_usecase.dart';

import '../../../helpers/fake_todo_repository.dart';

void main() {
  late FakeTodoRepository repository;
  late GetTodoByIdUseCase useCase;

  setUp(() {
    repository = FakeTodoRepository([
      const Todo(id: 1, title: 'Todo 1', isCompleted: false),
      const Todo(id: 2, title: 'Todo 2', memo: 'メモ', isCompleted: true),
    ]);
    useCase = GetTodoByIdUseCase(repository);
  });

  tearDown(() {
    repository.dispose();
  });

  test('存在するIDでTodoを返す', () async {
    final todo = await useCase.call(id: 1);

    expect(todo, isNotNull);
    expect(todo!.id, 1);
    expect(todo.title, 'Todo 1');
    expect(todo.isCompleted, false);
  });

  test('存在するIDでメモ付きTodoを返す', () async {
    final todo = await useCase.call(id: 2);

    expect(todo, isNotNull);
    expect(todo!.memo, 'メモ');
    expect(todo.isCompleted, true);
  });

  test('存在しないIDでnullを返す', () async {
    final todo = await useCase.call(id: 999);
    expect(todo, isNull);
  });
}
