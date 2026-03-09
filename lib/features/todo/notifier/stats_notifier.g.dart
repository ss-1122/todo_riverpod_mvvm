// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 統計画面用の Notifier
///
/// 追加の可変フィールドが不要なため StreamNotifier を採用。
/// build() で GetStatsUseCase が返す Stream をそのまま返す。

@ProviderFor(StatsNotifier)
final statsProvider = StatsNotifierProvider._();

/// 統計画面用の Notifier
///
/// 追加の可変フィールドが不要なため StreamNotifier を採用。
/// build() で GetStatsUseCase が返す Stream をそのまま返す。
final class StatsNotifierProvider
    extends $StreamNotifierProvider<StatsNotifier, TodoStats> {
  /// 統計画面用の Notifier
  ///
  /// 追加の可変フィールドが不要なため StreamNotifier を採用。
  /// build() で GetStatsUseCase が返す Stream をそのまま返す。
  StatsNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'statsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$statsNotifierHash();

  @$internal
  @override
  StatsNotifier create() => StatsNotifier();
}

String _$statsNotifierHash() => r'f5a6343add16e069d0715b619f0062f8a12ff2b6';

/// 統計画面用の Notifier
///
/// 追加の可変フィールドが不要なため StreamNotifier を採用。
/// build() で GetStatsUseCase が返す Stream をそのまま返す。

abstract class _$StatsNotifier extends $StreamNotifier<TodoStats> {
  Stream<TodoStats> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<TodoStats>, TodoStats>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<TodoStats>, TodoStats>,
        AsyncValue<TodoStats>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
