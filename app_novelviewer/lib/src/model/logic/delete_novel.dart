import 'dart:developer';
import 'package:app_novelviewer/src/model/importer.dart';
import 'package:app_novelviewer/src/model/repository/local/db_provider.dart';

Future<void> deleteNovel(Novel nv) async {
  // //fake delete
  // return Future.delayed(const Duration(seconds:1),()=>null);

  int? nvId = nv.id;

  //get episodes
  final epMaps = await DbProvider.queryAllRows(Tables.episodes,
      filter: {EpisodeTable.novelId.name: nvId});
  final chMaps = await DbProvider.queryAllRows(Tables.chapters,
      filter: {ChapterTable.novelId.name: nvId});

  List<Future<int>> futures = [];
  // delete episode,chapter data
  for (Map<String, dynamic> epm in epMaps) {
    futures.add(DbProvider.delete(
        Tables.episodes, {EpisodeTable.pkey: epm[EpisodeTable.pkey]}));
  }
  for (Map<String, dynamic> chm in chMaps) {
    futures.add(DbProvider.delete(
        Tables.chapters, {ChapterTable.pkey: chm[ChapterTable.pkey]}));
  }
  await Future.wait(futures);
  // delete Novel (set status deleted)
  if (nv.status != NovelStatus.deleted) {
    nv.status = NovelStatus.deleted;
    await DbProvider.update(Tables.novels, nv.toMap());
  }

  log("deleteNovel: nvId=$nvId, epN=${epMaps.length}, chN=${chMaps.length}");
}
