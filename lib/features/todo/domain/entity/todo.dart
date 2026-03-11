import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';

/// Todoのドメインエンティティ
///
/// DBスキーマと1対1対応。is_completed (DB) → isCompleted (Dart) はDrift側でマッピング。
/// freezed により == / hashCode / copyWith が自動生成される。
@freezed
abstract class Todo with _$Todo {
  const factory Todo({
    required int id,
    required String title,
    String? memo,
    required bool isCompleted,
  }) = _Todo;
}
