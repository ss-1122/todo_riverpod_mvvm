// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_todo_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(addTodoUseCase)
final addTodoUseCaseProvider = AddTodoUseCaseProvider._();

final class AddTodoUseCaseProvider
    extends $FunctionalProvider<AddTodoUseCase, AddTodoUseCase, AddTodoUseCase>
    with $Provider<AddTodoUseCase> {
  AddTodoUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addTodoUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addTodoUseCaseHash();

  @$internal
  @override
  $ProviderElement<AddTodoUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AddTodoUseCase create(Ref ref) {
    return addTodoUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AddTodoUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AddTodoUseCase>(value),
    );
  }
}

String _$addTodoUseCaseHash() => r'2c318c9d0c35f6de8b6cd4b35de117e70c30ea73';
