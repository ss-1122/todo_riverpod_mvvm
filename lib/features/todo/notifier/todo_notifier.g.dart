// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Todoリスト＋フィルタ状態を管理する Notifier
///
/// - build() でDriftのStreamを手動購読し、DB変更を自動反映する。
/// - _filter と _allTodos をフィールドとして保持し、フィルタ変更時に再計算する。
/// - StreamNotifier ではなく AsyncNotifier を採用（追加の可変フィールドが必要なため）。

@ProviderFor(TodoNotifier)
final todoProvider = TodoNotifierProvider._();

/// Todoリスト＋フィルタ状態を管理する Notifier
///
/// - build() でDriftのStreamを手動購読し、DB変更を自動反映する。
/// - _filter と _allTodos をフィールドとして保持し、フィルタ変更時に再計算する。
/// - StreamNotifier ではなく AsyncNotifier を採用（追加の可変フィールドが必要なため）。
final class TodoNotifierProvider
    extends $AsyncNotifierProvider<TodoNotifier, List<Todo>> {
  /// Todoリスト＋フィルタ状態を管理する Notifier
  ///
  /// - build() でDriftのStreamを手動購読し、DB変更を自動反映する。
  /// - _filter と _allTodos をフィールドとして保持し、フィルタ変更時に再計算する。
  /// - StreamNotifier ではなく AsyncNotifier を採用（追加の可変フィールドが必要なため）。
  TodoNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todoNotifierHash();

  @$internal
  @override
  TodoNotifier create() => TodoNotifier();
}

String _$todoNotifierHash() => r'17fb74279c8dad0e64f57b2ea76f40bc4b2625ca';

/// Todoリスト＋フィルタ状態を管理する Notifier
///
/// - build() でDriftのStreamを手動購読し、DB変更を自動反映する。
/// - _filter と _allTodos をフィールドとして保持し、フィルタ変更時に再計算する。
/// - StreamNotifier ではなく AsyncNotifier を採用（追加の可変フィールドが必要なため）。

abstract class _$TodoNotifier extends $AsyncNotifier<List<Todo>> {
  FutureOr<List<Todo>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Todo>>, List<Todo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Todo>>, List<Todo>>,
              AsyncValue<List<Todo>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// 指定IDのTodoを取得する AutoDispose FutureProvider（詳細・編集画面用）

@ProviderFor(todoById)
final todoByIdProvider = TodoByIdFamily._();

/// 指定IDのTodoを取得する AutoDispose FutureProvider（詳細・編集画面用）

final class TodoByIdProvider
    extends $FunctionalProvider<AsyncValue<Todo?>, Todo?, FutureOr<Todo?>>
    with $FutureModifier<Todo?>, $FutureProvider<Todo?> {
  /// 指定IDのTodoを取得する AutoDispose FutureProvider（詳細・編集画面用）
  TodoByIdProvider._({
    required TodoByIdFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'todoByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$todoByIdHash();

  @override
  String toString() {
    return r'todoByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Todo?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Todo?> create(Ref ref) {
    final argument = this.argument as int;
    return todoById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TodoByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$todoByIdHash() => r'345973e027d36265331528d1bada975325fa99be';

/// 指定IDのTodoを取得する AutoDispose FutureProvider（詳細・編集画面用）

final class TodoByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Todo?>, int> {
  TodoByIdFamily._()
    : super(
        retry: null,
        name: r'todoByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 指定IDのTodoを取得する AutoDispose FutureProvider（詳細・編集画面用）

  TodoByIdProvider call(int id) => TodoByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'todoByIdProvider';
}
