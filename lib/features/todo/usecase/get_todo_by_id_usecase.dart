import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod_mvvm/features/todo/domain/entity/todo.dart';
import 'package:todo_riverpod_mvvm/features/todo/domain/repository/todo_repository.dart';
import 'package:todo_riverpod_mvvm/features/todo/repository/todo_repository_provider.dart';

part 'get_todo_by_id_usecase.g.dart';

/// 指定IDのTodoを1件取得するUseCase（詳細・編集画面用）
class GetTodoByIdUseCase {
  const GetTodoByIdUseCase(this._repository);

  final TodoRepository _repository;

  Future<Todo?> call({required int id}) => _repository.findById(id);
}

@riverpod
GetTodoByIdUseCase getTodoByIdUseCase(Ref ref) {
  return GetTodoByIdUseCase(ref.watch(todoRepositoryProvider));
}
