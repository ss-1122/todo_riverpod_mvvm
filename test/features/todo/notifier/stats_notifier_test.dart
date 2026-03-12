import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_riverpod_mvvm/features/todo/domain/entity/todo.dart';
import 'package:todo_riverpod_mvvm/features/todo/notifier/stats_notifier.dart';
import 'package:todo_riverpod_mvvm/features/todo/usecase/get_stats_usecase.dart';

import '../../../helpers/fake_todo_repository.dart';

void main() {
  late FakeTodoRepository fakeRepository;
  late ProviderContainer container;

  setUp(() {
    fakeRepository = FakeTodoRepository([
      const Todo(id: 1, title: 'Todo 1', isCompleted: false),
      const Todo(id: 2, title: 'Todo 2', isCompleted: true),
      const Todo(id: 3, title: 'Todo 3', isCompleted: false),
      const Todo(id: 4, title: 'Todo 4', isCompleted: true),
    ]);

    container = ProviderContainer(
      overrides: [
        getStatsUseCaseProvider.overrideWithValue(
          GetStatsUseCase(fakeRepository),
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
    fakeRepository.dispose();
  });

  test('初期状態で正しい統計を返す', () async {
    final sub = container.listen(statsProvider, (_, __) {});

    // StreamNotifier の build() が Stream の最初のイベントを受け取るまで待つ
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);

    final state = container.read(statsProvider);
    expect(state.hasValue, isTrue);

    final stats = state.value!;
    expect(stats.total, 4);
    expect(stats.completed, 2);
    expect(stats.incomplete, 2);

    sub.close();
  });

  test('Todo追加後に統計が更新される', () async {
    final sub = container.listen(statsProvider, (_, __) {});
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);

    await fakeRepository.add(title: '新しいTodo');

    // Stream 経由で更新が反映されるのを待つ
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);

    final state = container.read(statsProvider);
    expect(state.hasValue, isTrue);

    final stats = state.value!;
    expect(stats.total, 5);
    expect(stats.incomplete, 3);
    expect(stats.completed, 2);

    sub.close();
  });

  test('Todoが0件の場合、全て0の統計を返す', () async {
    final emptyRepo = FakeTodoRepository();
    final emptyContainer = ProviderContainer(
      overrides: [
        getStatsUseCaseProvider.overrideWithValue(GetStatsUseCase(emptyRepo)),
      ],
    );

    final sub = emptyContainer.listen(statsProvider, (_, __) {});
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);

    final state = emptyContainer.read(statsProvider);
    if (state.hasValue) {
      final stats = state.value!;
      expect(stats.total, 0);
      expect(stats.completed, 0);
      expect(stats.incomplete, 0);
    }

    sub.close();
    emptyContainer.dispose();
    emptyRepo.dispose();
  });
}
