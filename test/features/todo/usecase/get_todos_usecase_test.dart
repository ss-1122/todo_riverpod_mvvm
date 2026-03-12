import 'package:flutter_test/flutter_test.dart';
import 'package:todo_riverpod_mvvm/features/todo/usecase/get_todos_usecase.dart';

import '../../../helpers/fake_todo_repository.dart';

void main() {
  late FakeTodoRepository repository;
  late GetTodosUseCase useCase;

  setUp(() {
    repository = FakeTodoRepository();
    useCase = GetTodosUseCase(repository);
  });

  tearDown(() {
    repository.dispose();
  });

  test('初期状態で空のリストがStreamに流れる', () async {
    final stream = useCase.call();
    final todos = await stream.first;
    expect(todos, isEmpty);
  });

  test('Todoが追加されるとStreamに反映される', () async {
    final stream = useCase.call();

    // watchAll() の初回通知（空リスト）をスキップし、追加後の通知を取得
    final future = stream.skip(1).first;
    await repository.add(title: 'テストTodo');
    final todos = await future;

    expect(todos, hasLength(1));
    expect(todos.first.title, 'テストTodo');
  });

  test('複数Todoが含まれるStreamを返す', () async {
    await repository.add(title: 'Todo 1');
    await repository.add(title: 'Todo 2');
    await repository.add(title: 'Todo 3');

    final stream = useCase.call();
    final todos = await stream.first;

    expect(todos, hasLength(3));
  });
}
