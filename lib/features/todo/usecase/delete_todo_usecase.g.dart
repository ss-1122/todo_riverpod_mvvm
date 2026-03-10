// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_todo_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deleteTodoUseCase)
final deleteTodoUseCaseProvider = DeleteTodoUseCaseProvider._();

final class DeleteTodoUseCaseProvider
    extends
        $FunctionalProvider<
          DeleteTodoUseCase,
          DeleteTodoUseCase,
          DeleteTodoUseCase
        >
    with $Provider<DeleteTodoUseCase> {
  DeleteTodoUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteTodoUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteTodoUseCaseHash();

  @$internal
  @override
  $ProviderElement<DeleteTodoUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeleteTodoUseCase create(Ref ref) {
    return deleteTodoUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteTodoUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteTodoUseCase>(value),
    );
  }
}

String _$deleteTodoUseCaseHash() => r'6bf9c6e2880f1e42ec7ae50fcc3dc100c9a23904';
