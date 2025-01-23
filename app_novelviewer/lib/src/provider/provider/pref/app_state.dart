import 'package:app_novelviewer/src/model/importer.dart';
import 'package:app_novelviewer/src/model/repository/local/db_provider.dart';
import 'package:app_novelviewer/src/model/repository/local/pref_provider.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'app_state.g.dart';

@riverpod
bool isFirstRun(ref) {
  ref.listenSelf((previous, next) {
    PrefProvider.firstRun = next;
  });
  return PrefProvider.firstRun;
}

@riverpod
class RecentReadState extends _$RecentReadState {
  @override
  FutureOr<(Novel, Episode)?> build() async {
    final epId = PrefProvider.lastEpId;
    if (epId == null) {
      return null;
    } else {
      final ep = Episode.fromMap((await DbProvider.queryAllRows(Tables.episodes,
          filter: {EpisodeTable.pkey: epId}))[0]);
      final nv = Novel.fromMap((await DbProvider.queryAllRows(Tables.novels,
          filter: {NovelTable.pkey: ep.novelId}))[0]);
      ref.listenSelf((previous, next) {
        PrefProvider.lastEpId = next.value?.$2.id;
      });
      return (nv, ep);
    }
  }

  void set(Novel nv, Episode ep) {
    state = AsyncData((nv, ep));
  }
}
