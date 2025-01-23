// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chapterStateHash() => r'94bb1f2c0fc58f54c82cc4f99aa38d2b883d1e7a';

/// See also [ChapterState].
@ProviderFor(ChapterState)
final chapterStateProvider = NotifierProvider<ChapterState, Chapter?>.internal(
  ChapterState.new,
  name: r'chapterStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$chapterStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ChapterState = Notifier<Chapter?>;
String _$chapterListStateHash() => r'6f3b0f66b89ec051726cd2ca27c4267a1090309a';

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

abstract class _$ChapterListState
    extends BuildlessAutoDisposeAsyncNotifier<List<Chapter>> {
  late final int? nvId;

  FutureOr<List<Chapter>> build(
    int? nvId,
  );
}

/// See also [ChapterListState].
@ProviderFor(ChapterListState)
const chapterListStateProvider = ChapterListStateFamily();

/// See also [ChapterListState].
class ChapterListStateFamily extends Family<AsyncValue<List<Chapter>>> {
  /// See also [ChapterListState].
  const ChapterListStateFamily();

  /// See also [ChapterListState].
  ChapterListStateProvider call(
    int? nvId,
  ) {
    return ChapterListStateProvider(
      nvId,
    );
  }

  @override
  ChapterListStateProvider getProviderOverride(
    covariant ChapterListStateProvider provider,
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
  String? get name => r'chapterListStateProvider';
}

/// See also [ChapterListState].
class ChapterListStateProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ChapterListState, List<Chapter>> {
  /// See also [ChapterListState].
  ChapterListStateProvider(
    int? nvId,
  ) : this._internal(
          () => ChapterListState()..nvId = nvId,
          from: chapterListStateProvider,
          name: r'chapterListStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chapterListStateHash,
          dependencies: ChapterListStateFamily._dependencies,
          allTransitiveDependencies:
              ChapterListStateFamily._allTransitiveDependencies,
          nvId: nvId,
        );

  ChapterListStateProvider._internal(
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
  FutureOr<List<Chapter>> runNotifierBuild(
    covariant ChapterListState notifier,
  ) {
    return notifier.build(
      nvId,
    );
  }

  @override
  Override overrideWith(ChapterListState Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChapterListStateProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ChapterListState, List<Chapter>>
      createElement() {
    return _ChapterListStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChapterListStateProvider && other.nvId == nvId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, nvId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChapterListStateRef
    on AutoDisposeAsyncNotifierProviderRef<List<Chapter>> {
  /// The parameter `nvId` of this provider.
  int? get nvId;
}

class _ChapterListStateProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ChapterListState,
        List<Chapter>> with ChapterListStateRef {
  _ChapterListStateProviderElement(super.provider);

  @override
  int? get nvId => (origin as ChapterListStateProvider).nvId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
