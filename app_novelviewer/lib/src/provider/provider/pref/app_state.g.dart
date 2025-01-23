// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isFirstRunHash() => r'3a0c4541419e4df864288f7491422603dfe8818b';

/// See also [isFirstRun].
@ProviderFor(isFirstRun)
final isFirstRunProvider = AutoDisposeProvider<bool>.internal(
  isFirstRun,
  name: r'isFirstRunProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isFirstRunHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsFirstRunRef = AutoDisposeProviderRef<bool>;
String _$recentReadStateHash() => r'bfb8ec00c95b95c7893cf0c8b533da17c152ef1d';

/// See also [RecentReadState].
@ProviderFor(RecentReadState)
final recentReadStateProvider = AutoDisposeAsyncNotifierProvider<
    RecentReadState, (Novel, Episode)?>.internal(
  RecentReadState.new,
  name: r'recentReadStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recentReadStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RecentReadState = AutoDisposeAsyncNotifier<(Novel, Episode)?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
