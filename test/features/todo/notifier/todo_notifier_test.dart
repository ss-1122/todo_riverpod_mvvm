import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_riverpod_mvvm/core/constants/filter_type.dart';
import 'package:todo_riverpod_mvvm/features/todo/domain/entity/todo.dart';
import 'package:todo_riverpod_mvvm/features/todo/notifier/todo_notifier.dart';
import 'package:todo_riverpod_mvvm/features/todo/usecase/get_todos_usecase.dart';
import 'package:todo_riverpod_mvvm/features/todo/usecase/update_todo_usecase.dart';

import '../../../helpers/fake_todo_repository.dart';

void main() {
  late FakeTodoRepository fakeRepository;
  late ProviderContainer container;

  setUp(() {
    fakeRepository = FakeTodoRepository([
      const Todo(id: 1, title: 'Todo 1', isCompleted: false),
      const Todo(id: 2, title: 'Todo 2', isCompleted: true),
      const Todo(id: 3, title: 'Todo 3', isCompleted: false),
    ]);

    container = ProviderContainer(
      overrides: [
        getTodosUseCaseProvider.overrideWithValue(
          GetTodosUseCase(fakeRepository),
        ),
        updateTodoUseCaseProvider.overrideWithValue(
          UpdateTodoUseCase(fakeRepository),
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
    fakeRepository.dispose();
  });

  test('初期状態でTodoリストを取得できる', () async {
    // provider を listen して build() を起動
    final sub = container.listen(todoProvider, (_, _) {});

    // build() 内の非同期処理（Stream.first）が完了するのを待つ
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);

    final state = container.read(todoProvider);
    expect(state.hasValue, isTrue);
    expect(state.value, hasLength(3));

    sub.close();
  });

  test('フィルタをcompletedに変更すると完了のみ返す', () async {
    final sub = container.listen(todoProvider, (_, _) {});
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);

    final notifier = container.read(todoProvider.notifier);
    notifier.setFilter(FilterType.completed);

    final state = container.read(todoProvider);
    expect(state.hasValue, isTrue);
    expect(state.value!.length, 1);
    expect(state.value!.every((t) => t.isCompleted), isTrue);

    sub.close();
  });

  test('フィルタをincompleteに変更すると未完了のみ返す', () async {
    final sub = container.listen(todoProvider, (_, _) {});
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);

    final notifier = container.read(todoProvider.notifier);
    notifier.setFilter(FilterType.incomplete);

    final state = container.read(todoProvider);
    expect(state.hasValue, isTrue);
    expect(state.value!.length, 2);
    expect(state.value!.every((t) => !t.isCompleted), isTrue);

    sub.close();
  });

  test('フィルタをallに戻すと全件返す', () async {
    final sub = container.listen(todoProvider, (_, _) {});
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);

    final notifier = container.read(todoProvider.notifier);
    notifier.setFilter(FilterType.completed);
    notifier.setFilter(FilterType.all);

    final state = container.read(todoProvider);
    expect(state.hasValue, isTrue);
    expect(state.value, hasLength(3));

    sub.close();
  });

  test('currentFilter が正しい値を返す', () async {
    final sub = container.listen(todoProvider, (_, _) {});
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);

    final notifier = container.read(todoProvider.notifier);
    expect(notifier.currentFilter, FilterType.all);

    notifier.setFilter(FilterType.completed);
    expect(notifier.currentFilter, FilterType.completed);

    sub.close();
  });

  test('toggleCompleted でTodoの完了状態が反転する', () async {
    final sub = container.listen(todoProvider, (_, _) {});
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);

    final notifier = container.read(todoProvider.notifier);
    final todo = container.read(todoProvider).value!.first; // id:1, false
    await notifier.toggleCompleted(todo);

    // FakeRepository 内部状態を確認
    final updated = await fakeRepository.findById(1);
    expect(updated!.isCompleted, isTrue);

    sub.close();
  });
}
