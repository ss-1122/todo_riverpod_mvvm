import 'package:flutter_test/flutter_test.dart';
import 'package:todo_riverpod_mvvm/features/todo/domain/entity/todo.dart';
import 'package:todo_riverpod_mvvm/features/todo/usecase/get_stats_usecase.dart';

import '../../../helpers/fake_todo_repository.dart';

void main() {
  late FakeTodoRepository repository;
  late GetStatsUseCase useCase;

  setUp(() {
    repository = FakeTodoRepository();
    useCase = GetStatsUseCase(repository);
  });

  tearDown(() {
    repository.dispose();
  });

  test('Todoが0件の場合、全て0の統計を返す', () async {
    final stream = useCase.call();
    final stats = await stream.first;

    expect(stats.total, 0);
    expect(stats.completed, 0);
    expect(stats.incomplete, 0);
  });

  test('完了・未完了が混在する場合の統計を正しく返す', () async {
    final repo = FakeTodoRepository([
      const Todo(id: 1, title: 'Todo 1', isCompleted: false),
      const Todo(id: 2, title: 'Todo 2', isCompleted: true),
      const Todo(id: 3, title: 'Todo 3', isCompleted: false),
      const Todo(id: 4, title: 'Todo 4', isCompleted: true),
      const Todo(id: 5, title: 'Todo 5', isCompleted: true),
    ]);
    final uc = GetStatsUseCase(repo);

    final stream = uc.call();
    final stats = await stream.first;

    expect(stats.total, 5);
    expect(stats.completed, 3);
    expect(stats.incomplete, 2);

    repo.dispose();
  });

  test('全て未完了の場合の統計', () async {
    final repo = FakeTodoRepository([
      const Todo(id: 1, title: 'A', isCompleted: false),
      const Todo(id: 2, title: 'B', isCompleted: false),
    ]);
    final uc = GetStatsUseCase(repo);

    final stats = await uc.call().first;

    expect(stats.total, 2);
    expect(stats.completed, 0);
    expect(stats.incomplete, 2);

    repo.dispose();
  });

  test('全て完了済みの場合の統計', () async {
    final repo = FakeTodoRepository([
      const Todo(id: 1, title: 'A', isCompleted: true),
      const Todo(id: 2, title: 'B', isCompleted: true),
    ]);
    final uc = GetStatsUseCase(repo);

    final stats = await uc.call().first;

    expect(stats.total, 2);
    expect(stats.completed, 2);
    expect(stats.incomplete, 0);

    repo.dispose();
  });

  test('Todo追加で統計がリアルタイム更新される', () async {
    final stream = useCase.call();

    // 初期状態（空）をスキップし、追加後の通知を取得
    final future = stream.skip(1).first;
    await repository.add(title: '新しいTodo');
    final stats = await future;

    expect(stats.total, 1);
    expect(stats.completed, 0);
    expect(stats.incomplete, 1);
  });
}
