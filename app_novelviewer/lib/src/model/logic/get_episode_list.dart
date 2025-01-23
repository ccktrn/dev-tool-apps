import 'dart:developer';

import 'package:app_novelviewer/src/model/importer.dart';

import 'package:app_novelviewer/src/model/repository/local/db_provider.dart';

Future<List<Episode>> getEpisodeList(int nvId) async {
  // //fake list
  // return Future.delayed(
  //   const Duration(seconds: 1),
  //   () => List.generate(25, (i) => Episode(id:i*(i+3)-i, novelId:1,epOrder:i, updateTs:DateTime.now(),title:"これがエピソードのタイトルです", viewed:i>30,text:"ほんぶん！！！") )
  // );

  //from database
  final res = await DbProvider.queryAllRows(Tables.episodes,
      filter: {
        EpisodeTable.novelId.name: nvId,
      },
      sort: EpisodeTable.epOrder.name);
  log("getEpisodeList: nvId=$nvId, epN=${res.length}");
  List<Episode> epList =
      res.isNotEmpty ? res.map((m) => Episode.fromMap(m)).toList() : [];
  return epList;
}
