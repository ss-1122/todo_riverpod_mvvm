// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// TodoRepository を Riverpod で管理する Provider
///
/// AppDatabase から TodoLocalSource を生成し、
/// TodoRepositoryImpl にDIして TodoRepository として提供する。

@ProviderFor(todoRepository)
final todoRepositoryProvider = TodoRepositoryProvider._();

/// TodoRepository を Riverpod で管理する Provider
///
/// AppDatabase から TodoLocalSource を生成し、
/// TodoRepositoryImpl にDIして TodoRepository として提供する。

final class TodoRepositoryProvider
    extends $FunctionalProvider<TodoRepository, TodoRepository, TodoRepository>
    with $Provider<TodoRepository> {
  /// TodoRepository を Riverpod で管理する Provider
  ///
  /// AppDatabase から TodoLocalSource を生成し、
  /// TodoRepositoryImpl にDIして TodoRepository として提供する。
  TodoRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'todoRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$todoRepositoryHash();

  @$internal
  @override
  $ProviderElement<TodoRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TodoRepository create(Ref ref) {
    return todoRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TodoRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TodoRepository>(value),
    );
  }
}

String _$todoRepositoryHash() => r'9158860fcf889fe6843a2ff78a3dc0b541e45990';
