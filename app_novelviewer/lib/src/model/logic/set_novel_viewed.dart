// import 'dart:developer';

import 'dart:developer';

import 'package:app_novelviewer/src/model/importer.dart';

import 'package:app_novelviewer/src/model/repository/local/db_provider.dart';

//toggle viewed,
Future<void> setNovelViewed(
  Novel nv,
  bool viewed,
) async {
  final List<Future<void>> futures = [];
  final epMaps = await DbProvider.queryAllRows(Tables.episodes,
      filter: {EpisodeTable.novelId.name: nv.id});
  final viewedvalue = viewed ? 1 : 0;
  for (Map<String, dynamic> epm in epMaps) {
    //eps update
    if (epm[EpisodeTable.viewed.name] != viewedvalue) {
      futures.add(DbProvider.update(Tables.episodes, {
        EpisodeTable.pkey: epm[EpisodeTable.pkey],
        EpisodeTable.viewed.name: viewedvalue,
      }));
    }
  }
  await Future.wait(futures);
  await DbProvider.update(Tables.novels, {
    NovelTable.pkey: nv.id,
    NovelTable.epViewed.name: viewed ? nv.epNum : 0,
  });
  log("setEpisodesViewed: $viewed");
}
