import 'package:flutter_test/flutter_test.dart';
import 'package:todo_riverpod_mvvm/features/todo/domain/entity/todo.dart';
import 'package:todo_riverpod_mvvm/features/todo/usecase/update_todo_usecase.dart';

import '../../../helpers/fake_todo_repository.dart';

void main() {
  late FakeTodoRepository repository;
  late UpdateTodoUseCase useCase;

  setUp(() {
    repository = FakeTodoRepository([
      const Todo(id: 1, title: '元のタイトル', memo: '元のメモ', isCompleted: false),
    ]);
    useCase = UpdateTodoUseCase(repository);
  });

  tearDown(() {
    repository.dispose();
  });

  test('タイトルを更新できる', () async {
    final updated = repository.todos.first.copyWith(title: '新しいタイトル');
    await useCase.call(todo: updated);

    expect(repository.todos.first.title, '新しいタイトル');
  });

  test('メモを更新できる', () async {
    final updated = repository.todos.first.copyWith(memo: '新しいメモ');
    await useCase.call(todo: updated);

    expect(repository.todos.first.memo, '新しいメモ');
  });

  test('完了状態をトグルできる', () async {
    final updated = repository.todos.first.copyWith(isCompleted: true);
    await useCase.call(todo: updated);

    expect(repository.todos.first.isCompleted, true);
  });

  test('存在しないTodoの更新でエラーが発生する', () async {
    const nonExistent = Todo(id: 999, title: 'なし', isCompleted: false);

    expect(() => useCase.call(todo: nonExistent), throwsException);
  });
}
