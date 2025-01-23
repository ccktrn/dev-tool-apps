import 'package:app_novelviewer/src/importer.dart';
import 'package:app_novelviewer/src/model/const/tables.dart';
import 'package:app_novelviewer/src/model/logic/set_episode_viewed.dart';
import 'package:app_novelviewer/src/model/repository/local/db_provider.dart';
import 'package:app_novelviewer/src/model/repository/local/pref_provider.dart';
import 'package:riverpod/src/framework.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'episode.g.dart';

// reading,lastread episode
@Riverpod(keepAlive: true)
class EpisodeState extends _$EpisodeState {
  @override
  Episode? build() {
    ref.listenSelf((previous, next) {
      PrefProvider.lastEpId = next?.id;
    });
    return null;
  }

  void set(Episode ep) => state = ep;

  bool? get viewed => state?.viewed;
  int? get epOrder => state?.epOrder;

  void setViewed(bool v) {
    setEpisodeViewed(state!, v);

    state?.viewed = v;
    // // listProvider も更新したい
    // _epList = ref.watch(episodeListStateProvider(state?.novelId));
    // _epList.when(data:(e){
    //   e[state!.epOrder!-1].viewed = v ;
    // }, error:(o,s){}, loading:(){});
  }
}

// episodesList (use 'nvId' props for instance)
// filter条件とかここで指定してもいいかも
@riverpod
class EpisodeListState extends _$EpisodeListState {
  @override
  FutureOr<List<Episode>> build(int? nvId) async {
    if (nvId == null) {
      return [];
    } else {
      return (await DbProvider.queryAllRows(
        Tables.episodes,
        filter: {EpisodeTable.novelId.name: nvId},
        sort: EpisodeTable.epOrder.name,
      ))
          .map((e) => Episode.fromMap(e))
          .toList();
    }
  }

  void set(List<Episode> eps) {
    state = AsyncData(eps);
  }

  void setViewed(int index, bool? v) {
    state.value?[index].viewed = v;
    DbProvider.update(Tables.episodes, {
      // db
      EpisodeTable.pkey: state.value?[index].id,
      EpisodeTable.viewed.name: v,
    });
  }
}
