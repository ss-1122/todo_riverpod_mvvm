import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_stats.freezed.dart';

/// 統計画面用の集計値オブジェクト
///
/// GetStatsUseCase が watchAll() の Stream を加工して算出する。
/// freezed により == / hashCode / copyWith が自動生成される。
@freezed
abstract class TodoStats with _$TodoStats {
  const factory TodoStats({
    required int total,
    required int completed,
    required int incompleted,
  }) = _TodoStats;
}
