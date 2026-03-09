import 'package:todo_riverpod_mvvm/features/todo/domain/entity/todo.dart';

/// Todoリポジトリの抽象インタフェース
///
/// 依存性逆転の原則 (DIP) に基づき、domain層がインタフェースを定義し、
/// repository層がこれを実装する。
abstract interface class TodoRepository {
  /// 全Todoをリアルタイム監視するStream（Insert/Update/Delete後に自動更新）
  Stream<List<Todo>> watchAll();

  /// 指定IDのTodoを1件取得（詳細・編集画面用）
  Future<Todo?> findById(int id);

  /// 新規Todoを登録する
  Future<void> add({required String title, String? memo});

  /// 既存Todoを更新する
  Future<void> update(Todo todo);

  /// 指定IDのTodoを削除する
  Future<void> delete(int id);
}
