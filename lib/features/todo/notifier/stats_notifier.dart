import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod_mvvm/features/todo/domain/entity/todo_stats.dart';
import 'package:todo_riverpod_mvvm/features/todo/usecase/get_stats_usecase.dart';

part 'stats_notifier.g.dart';

/// 統計画面用の Notifier
///
/// 追加の可変フィールドが不要なため StreamNotifier を採用。
/// build() で GetStatsUseCase が返す Stream をそのまま返す。
@riverpod
class StatsNotifier extends _$StatsNotifier {
  @override
  Stream<TodoStats> build() {
    return ref.watch(getStatsUseCaseProvider).call();
  }
}
