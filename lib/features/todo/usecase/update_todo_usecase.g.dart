// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_todo_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(updateTodoUseCase)
final updateTodoUseCaseProvider = UpdateTodoUseCaseProvider._();

final class UpdateTodoUseCaseProvider extends $FunctionalProvider<
    UpdateTodoUseCase,
    UpdateTodoUseCase,
    UpdateTodoUseCase> with $Provider<UpdateTodoUseCase> {
  UpdateTodoUseCaseProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'updateTodoUseCaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$updateTodoUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateTodoUseCase> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UpdateTodoUseCase create(Ref ref) {
    return updateTodoUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateTodoUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateTodoUseCase>(value),
    );
  }
}

String _$updateTodoUseCaseHash() => r'3c97ba6211f801d6551d6959bbe0b903bc569161';
