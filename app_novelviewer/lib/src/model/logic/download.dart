import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:app_novelviewer/src/model/importer.dart';

//data
import 'package:app_novelviewer/src/model/repository/local/db_provider.dart';
import 'package:app_novelviewer/src/model/repository/local/storage_provider.dart';

//api
import 'package:app_novelviewer/src/model/repository/remote/api_provider.dart';
import 'package:http/http.dart';

Future<void> renewNv(Novel nv) async {
  List<Episode> eps = (await DbProvider.queryAllRows(Tables.episodes,
          filter: {
            EpisodeTable.novelId.name: nv.id,
          },
          sort: EpisodeTable.epOrder.name))
      .map((e) => Episode.fromMap(e))
      .toList();

  for (var ep in eps) {
    try {
      await Future.delayed(const Duration(milliseconds: ApiProvider.interval),
          () async {
        await downloadEpisode(ep);
      }); // 制限回避用delay
    } on ClientException {
      // offline
      log("addNovel: download interrupted.");
      return;
    } on HttpException catch (e) {
      //serverside
      log("HttpException: ${e.message}");
      continue;
    }
  }
  nv.status = NovelStatus.downloaded;
  DbProvider.update(Tables.novels, nv.toMap());
  log("download completed.");
}

Future<void> downloadEpisode(Episode ep) async {
  try {
    log("downloading: Ep.${ep.epOrder}");
    var contents = await ApiProvider.getEpisodeText(Uri.parse(ep.url));
    await StrageProvider.saveText(
      Episode.epFilename(ep.novelId!, ep.id!),
      contents,
    );
  } on FormatException {
    rethrow;
  } on HttpException {
    rethrow;
  } on ClientException {
    rethrow;
  }
}
