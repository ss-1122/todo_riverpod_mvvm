// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_stats_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getStatsUseCase)
final getStatsUseCaseProvider = GetStatsUseCaseProvider._();

final class GetStatsUseCaseProvider
    extends
        $FunctionalProvider<GetStatsUseCase, GetStatsUseCase, GetStatsUseCase>
    with $Provider<GetStatsUseCase> {
  GetStatsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getStatsUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getStatsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetStatsUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetStatsUseCase create(Ref ref) {
    return getStatsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetStatsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetStatsUseCase>(value),
    );
  }
}

String _$getStatsUseCaseHash() => r'58389fbbc041cab3b53d1980deac9ff41ed99ac1';
