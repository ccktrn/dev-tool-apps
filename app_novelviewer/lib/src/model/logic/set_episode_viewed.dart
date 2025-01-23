// import 'dart:developer';

import 'dart:developer';

import 'package:app_novelviewer/src/model/importer.dart';

import 'package:app_novelviewer/src/model/repository/local/db_provider.dart';

//toggle viewed,
Future<void> setEpisodeViewed(
  Episode ep,
  bool viewed,
) async {
  if (ep.viewed != viewed) {
    DbProvider.update(Tables.episodes, {
      EpisodeTable.id.name: ep.id,
      EpisodeTable.viewed.name: viewed ? 1 : 0,
    });
    final nvm = (await DbProvider.queryAllRows(Tables.novels,
        filter: {NovelTable.pkey: ep.novelId}))[0];
    DbProvider.update(Tables.novels, {
      NovelTable.id.name: nvm[NovelTable.pkey],
      NovelTable.epViewed.name:
          nvm[NovelTable.epViewed.name] + (viewed ? 1 : -1)
    });
  }
  log("setEpisodeViewed: $viewed");
}
