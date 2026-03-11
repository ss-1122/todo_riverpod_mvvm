import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod_mvvm/features/todo/domain/repository/todo_repository.dart';
import 'package:todo_riverpod_mvvm/features/todo/repository/todo_repository_provider.dart';

part 'add_todo_usecase.g.dart';

/// 新規Todoを登録するUseCase
class AddTodoUseCase {
  const AddTodoUseCase(this._repository);

  final TodoRepository _repository;

  Future<void> call({required String title, String? memo}) =>
      _repository.add(title: title, memo: memo);
}

@riverpod
AddTodoUseCase addTodoUseCase(Ref ref) {
  return AddTodoUseCase(ref.watch(todoRepositoryProvider));
}
