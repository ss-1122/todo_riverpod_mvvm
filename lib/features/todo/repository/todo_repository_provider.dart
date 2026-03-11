import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod_mvvm/core/database/app_database.dart';
import 'package:todo_riverpod_mvvm/features/todo/domain/repository/todo_repository.dart';
import 'package:todo_riverpod_mvvm/features/todo/repository/todo_local_source.dart';
import 'package:todo_riverpod_mvvm/features/todo/repository/todo_repository_impl.dart';

part 'todo_repository_provider.g.dart';

/// TodoRepository を Riverpod で管理する Provider
///
/// AppDatabase から TodoLocalSource を生成し、
/// TodoRepositoryImpl にDIして TodoRepository として提供する。
@riverpod
TodoRepository todoRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  final localSource = TodoLocalSource(db);
  return TodoRepositoryImpl(localSource);
}
