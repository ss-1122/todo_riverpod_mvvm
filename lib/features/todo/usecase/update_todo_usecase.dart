import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod_mvvm/features/todo/domain/entity/todo.dart';
import 'package:todo_riverpod_mvvm/features/todo/domain/repository/todo_repository.dart';
import 'package:todo_riverpod_mvvm/features/todo/repository/todo_repository_provider.dart';

part 'update_todo_usecase.g.dart';

/// 既存Todoを更新するUseCase
class UpdateTodoUseCase {
  const UpdateTodoUseCase(this._repository);

  final TodoRepository _repository;

  Future<void> call({required Todo todo}) => _repository.update(todo);
}

@riverpod
UpdateTodoUseCase updateTodoUseCase(Ref ref) {
  return UpdateTodoUseCase(ref.watch(todoRepositoryProvider));
}
