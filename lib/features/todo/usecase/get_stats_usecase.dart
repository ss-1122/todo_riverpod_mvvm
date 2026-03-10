import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod_mvvm/features/todo/domain/entity/todo_stats.dart';
import 'package:todo_riverpod_mvvm/features/todo/domain/repository/todo_repository.dart';
import 'package:todo_riverpod_mvvm/features/todo/repository/todo_repository_provider.dart';

part 'get_stats_usecase.g.dart';

/// 統計情報をStream取得するUseCase
///
/// DBに専用メソッドは設けず、watchAll() のStreamをmap()で加工して算出する。
class GetStatsUseCase {
  const GetStatsUseCase(this._repository);

  final TodoRepository _repository;

  Stream<TodoStats> call() => _repository.watchAll().map(
    (todos) => TodoStats(
      total: todos.length,
      completed: todos.where((t) => t.isCompleted).length,
      incomplete: todos.where((t) => !t.isCompleted).length,
    ),
  );
}

@riverpod
GetStatsUseCase getStatsUseCase(Ref ref) {
  return GetStatsUseCase(ref.watch(todoRepositoryProvider));
}
