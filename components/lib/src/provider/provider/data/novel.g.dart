// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'novel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$novelStateHash() => r'c0330f7537a1c522f3c44106a300e3145370cf60';

/// See also [NovelState].
@ProviderFor(NovelState)
final novelStateProvider = NotifierProvider<NovelState, Novel?>.internal(
  NovelState.new,
  name: r'novelStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$novelStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NovelState = Notifier<Novel?>;
String _$novelListStateHash() => r'53f375c4e48f5337a3c88de7e70947359b1b238b';

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

abstract class _$NovelListState
    extends BuildlessAutoDisposeAsyncNotifier<List<Novel>> {
  late final String mode;

  FutureOr<List<Novel>> build(
    String mode,
  );
}

/// See also [NovelListState].
@ProviderFor(NovelListState)
const novelListStateProvider = NovelListStateFamily();

/// See also [NovelListState].
class NovelListStateFamily extends Family<AsyncValue<List<Novel>>> {
  /// See also [NovelListState].
  const NovelListStateFamily();

  /// See also [NovelListState].
  NovelListStateProvider call(
    String mode,
  ) {
    return NovelListStateProvider(
      mode,
    );
  }

  @override
  NovelListStateProvider getProviderOverride(
    covariant NovelListStateProvider provider,
  ) {
    return call(
      provider.mode,
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
  String? get name => r'novelListStateProvider';
}

/// See also [NovelListState].
class NovelListStateProvider
    extends AutoDisposeAsyncNotifierProviderImpl<NovelListState, List<Novel>> {
  /// See also [NovelListState].
  NovelListStateProvider(
    String mode,
  ) : this._internal(
          () => NovelListState()..mode = mode,
          from: novelListStateProvider,
          name: r'novelListStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$novelListStateHash,
          dependencies: NovelListStateFamily._dependencies,
          allTransitiveDependencies:
              NovelListStateFamily._allTransitiveDependencies,
          mode: mode,
        );

  NovelListStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.mode,
  }) : super.internal();

  final String mode;

  @override
  FutureOr<List<Novel>> runNotifierBuild(
    covariant NovelListState notifier,
  ) {
    return notifier.build(
      mode,
    );
  }

  @override
  Override overrideWith(NovelListState Function() create) {
    return ProviderOverride(
      origin: this,
      override: NovelListStateProvider._internal(
        () => create()..mode = mode,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        mode: mode,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<NovelListState, List<Novel>>
      createElement() {
    return _NovelListStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NovelListStateProvider && other.mode == mode;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, mode.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin NovelListStateRef on AutoDisposeAsyncNotifierProviderRef<List<Novel>> {
  /// The parameter `mode` of this provider.
  String get mode;
}

class _NovelListStateProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<NovelListState, List<Novel>>
    with NovelListStateRef {
  _NovelListStateProviderElement(super.provider);

  @override
  String get mode => (origin as NovelListStateProvider).mode;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
