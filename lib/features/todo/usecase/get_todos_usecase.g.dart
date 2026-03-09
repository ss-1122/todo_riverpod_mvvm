// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_todos_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getTodosUseCase)
final getTodosUseCaseProvider = GetTodosUseCaseProvider._();

final class GetTodosUseCaseProvider extends $FunctionalProvider<GetTodosUseCase,
    GetTodosUseCase, GetTodosUseCase> with $Provider<GetTodosUseCase> {
  GetTodosUseCaseProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'getTodosUseCaseProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$getTodosUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetTodosUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetTodosUseCase create(Ref ref) {
    return getTodosUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetTodosUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetTodosUseCase>(value),
    );
  }
}

String _$getTodosUseCaseHash() => r'69e4a1194e59d00f6d722703a060f01922c0b10a';
