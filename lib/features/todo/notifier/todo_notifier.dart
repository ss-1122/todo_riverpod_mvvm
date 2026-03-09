import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod_mvvm/core/constants/filter_type.dart';
import 'package:todo_riverpod_mvvm/features/todo/domain/entity/todo.dart';
import 'package:todo_riverpod_mvvm/features/todo/usecase/get_todo_by_id_usecase.dart';
import 'package:todo_riverpod_mvvm/features/todo/usecase/get_todos_usecase.dart';
import 'package:todo_riverpod_mvvm/features/todo/usecase/update_todo_usecase.dart';

part 'todo_notifier.g.dart';

/// Todoリスト＋フィルタ状態を管理する Notifier
///
/// - build() でDriftのStreamを手動購読し、DB変更を自動反映する。
/// - _filter と _allTodos をフィールドとして保持し、フィルタ変更時に再計算する。
/// - StreamNotifier ではなく AsyncNotifier を採用（追加の可変フィールドが必要なため）。
@riverpod
class TodoNotifier extends _$TodoNotifier {
  FilterType _filter = FilterType.all;
  List<Todo> _allTodos = [];
  StreamSubscription<List<Todo>>? _sub;

  @override
  Future<List<Todo>> build() async {
    _sub = ref.watch(getTodosUseCaseProvider).call().listen(
      (todos) {
        _allTodos = todos;
        state = AsyncData(_applyFilter(todos));
      },
      onError: (Object e, StackTrace st) => state = AsyncError(e, st),
    );
    ref.onDispose(() => _sub?.cancel());
    return [];
  }

  /// 現在のフィルタ状態を返す
  FilterType get currentFilter => _filter;

  /// フィルタを変更して表示リストを更新する
  void setFilter(FilterType filter) {
    _filter = filter;
    state = AsyncData(_applyFilter(_allTodos));
  }

  /// 完了/未完了をトグルする（UpdateTodoUseCase 経由）
  Future<void> toggleCompleted(Todo todo) async {
    final updated = todo.copyWith(isCompleted: !todo.isCompleted);
    await ref.read(updateTodoUseCaseProvider).call(todo: updated);
  }

  List<Todo> _applyFilter(List<Todo> todos) => switch (_filter) {
        FilterType.all => todos,
        FilterType.completed => todos.where((t) => t.isCompleted).toList(),
        FilterType.incomplete => todos.where((t) => !t.isCompleted).toList(),
      };
}

// ─── 詳細画面用：IDからTodoを取得するProvider ────────────────────────

/// 指定IDのTodoを取得する AutoDispose FutureProvider（詳細・編集画面用）
@riverpod
Future<Todo?> todoById(Ref ref, int id) {
  return ref.watch(getTodoByIdUseCaseProvider).call(id: id);
}
