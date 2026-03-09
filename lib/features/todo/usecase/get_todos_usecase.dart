import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod_mvvm/features/todo/domain/entity/todo.dart';
import 'package:todo_riverpod_mvvm/features/todo/domain/repository/todo_repository.dart';
import 'package:todo_riverpod_mvvm/features/todo/repository/todo_repository_provider.dart';

part 'get_todos_usecase.g.dart';

/// 全TodoをStream取得するUseCase
class GetTodosUseCase {
  const GetTodosUseCase(this._repository);

  final TodoRepository _repository;

  Stream<List<Todo>> call() => _repository.watchAll();
}

@riverpod
GetTodosUseCase getTodosUseCase(Ref ref) {
  return GetTodosUseCase(ref.watch(todoRepositoryProvider));
}
