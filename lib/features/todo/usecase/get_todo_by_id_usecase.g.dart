// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_todo_by_id_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getTodoByIdUseCase)
final getTodoByIdUseCaseProvider = GetTodoByIdUseCaseProvider._();

final class GetTodoByIdUseCaseProvider extends $FunctionalProvider<
    GetTodoByIdUseCase,
    GetTodoByIdUseCase,
    GetTodoByIdUseCase> with $Provider<GetTodoByIdUseCase> {
  GetTodoByIdUseCaseProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'getTodoByIdUseCaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$getTodoByIdUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetTodoByIdUseCase> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetTodoByIdUseCase create(Ref ref) {
    return getTodoByIdUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetTodoByIdUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetTodoByIdUseCase>(value),
    );
  }
}

String _$getTodoByIdUseCaseHash() =>
    r'd2728e6b5339c58dbe827b2ea4df07ff9c38e208';
