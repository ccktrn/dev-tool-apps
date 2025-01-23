// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$episodeStateHash() => r'b1e48ea9b7d8c94094f8f6252b038c6ca84d3c68';

/// See also [EpisodeState].
@ProviderFor(EpisodeState)
final episodeStateProvider = NotifierProvider<EpisodeState, Episode?>.internal(
  EpisodeState.new,
  name: r'episodeStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$episodeStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EpisodeState = Notifier<Episode?>;
String _$episodeListStateHash() => r'f52180b32645bd76b50b40ada58dc7e630275334';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$EpisodeListState
    extends BuildlessAutoDisposeAsyncNotifier<List<Episode>> {
  late final int? nvId;

  FutureOr<List<Episode>> build(
    int? nvId,
  );
}

/// See also [EpisodeListState].
@ProviderFor(EpisodeListState)
const episodeListStateProvider = EpisodeListStateFamily();

/// See also [EpisodeListState].
class EpisodeListStateFamily extends Family<AsyncValue<List<Episode>>> {
  /// See also [EpisodeListState].
  const EpisodeListStateFamily();

  /// See also [EpisodeListState].
  EpisodeListStateProvider call(
    int? nvId,
  ) {
    return EpisodeListStateProvider(
      nvId,
    );
  }

  @override
  EpisodeListStateProvider getProviderOverride(
    covariant EpisodeListStateProvider provider,
  ) {
    return call(
      provider.nvId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'episodeListStateProvider';
}

/// See also [EpisodeListState].
class EpisodeListStateProvider extends AutoDisposeAsyncNotifierProviderImpl<
    EpisodeListState, List<Episode>> {
  /// See also [EpisodeListState].
  EpisodeListStateProvider(
    int? nvId,
  ) : this._internal(
          () => EpisodeListState()..nvId = nvId,
          from: episodeListStateProvider,
          name: r'episodeListStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$episodeListStateHash,
          dependencies: EpisodeListStateFamily._dependencies,
          allTransitiveDependencies:
              EpisodeListStateFamily._allTransitiveDependencies,
          nvId: nvId,
        );

  EpisodeListStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.nvId,
  }) : super.internal();

  final int? nvId;

  @override
  FutureOr<List<Episode>> runNotifierBuild(
    covariant EpisodeListState notifier,
  ) {
    return notifier.build(
      nvId,
    );
  }

  @override
  Override overrideWith(EpisodeListState Function() create) {
    return ProviderOverride(
      origin: this,
      override: EpisodeListStateProvider._internal(
        () => create()..nvId = nvId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        nvId: nvId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<EpisodeListState, List<Episode>>
      createElement() {
    return _EpisodeListStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EpisodeListStateProvider && other.nvId == nvId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, nvId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EpisodeListStateRef
    on AutoDisposeAsyncNotifierProviderRef<List<Episode>> {
  /// The parameter `nvId` of this provider.
  int? get nvId;
}

class _EpisodeListStateProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<EpisodeListState,
        List<Episode>> with EpisodeListStateRef {
  _EpisodeListStateProviderElement(super.provider);

  @override
  int? get nvId => (origin as EpisodeListStateProvider).nvId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
