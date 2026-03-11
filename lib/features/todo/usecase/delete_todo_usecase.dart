import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod_mvvm/features/todo/domain/repository/todo_repository.dart';
import 'package:todo_riverpod_mvvm/features/todo/repository/todo_repository_provider.dart';

part 'delete_todo_usecase.g.dart';

/// 指定IDのTodoを削除するUseCase
class DeleteTodoUseCase {
  const DeleteTodoUseCase(this._repository);

  final TodoRepository _repository;

  Future<void> call({required int id}) => _repository.delete(id);
}

@riverpod
DeleteTodoUseCase deleteTodoUseCase(Ref ref) {
  return DeleteTodoUseCase(ref.watch(todoRepositoryProvider));
}
