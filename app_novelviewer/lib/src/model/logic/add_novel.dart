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

Future<void> addNovel(String nvurlStr) async {
  final nvurl = Uri.parse(nvurlStr);
  log("$nvurlStr => $nvurl");
  final Novel? registerd = await _registerd(nvurl);
  if (registerd != null && registerd.status != NovelStatus.deleted) {
    return;
  }
  late final Map<String, dynamic>? nvmap;
  // register novel //
  try {
    nvmap = await ApiProvider.getNovel(nvurl);
  } on FormatException {
    rethrow;
  } on HttpException {
    rethrow;
  } on ClientException {
    rethrow;
  }
  if (registerd == null) {
    // first registerd
    nvmap.addAll({
      NovelTable.pkey: await DbProvider.insert(Tables.novels, nvmap)
    }); //insert
  } else {
    //re-download
    nvmap.addAll({NovelTable.pkey: registerd.id});
    await DbProvider.update(Tables.novels, nvmap);
  }
  final nv = Novel.fromMap(nvmap); //toNovel

  // register chapters,episodes //
  late final List<Map<String, dynamic>> chmaps;
  late final List<Map<String, dynamic>> epmaps;
  try {
    (chmaps, epmaps) = await ApiProvider.getChapterAndEpisode(
        nvurl, nv.id!, nv.type, nv.epNum);
  } on ClientException {
    rethrow;
  } on FormatException {
    rethrow;
  } on HttpException {
    rethrow;
  }
  if (chmaps.isNotEmpty) {
    final List<Future<Chapter>> chfutures = [];
    for (var chmap in chmaps) {
      chfutures.add((Map<String, dynamic> map) async {
        var id = await DbProvider.insert(Tables.chapters, map);
        map.addAll({ChapterTable.pkey: id});
        return Chapter.fromMap(map);
      }(chmap));
    }
    await Future.wait(chfutures);
  }

  final List<Future<Episode>> epfutures = [];
  for (var epmap in epmaps) {
    epfutures.add((Map<String, dynamic> map) async {
      var id = await DbProvider.insert(Tables.episodes, map);
      map.addAll({EpisodeTable.pkey: id});
      return Episode.fromMap(map);
    }(epmap));
  }
  final eps = await Future.wait(epfutures);

  // download episodes text (on background) //
  //         filname = Episode.epFilename(int nvId, int epId)
  _downloadEpisodes(nv, eps);

  log("addNovel: nvId=${nv.id} epN=${nv.epNum}");

  return;
}

Future<Novel?> _registerd(Uri nvurl) async {
  final List<Map<String, dynamic>> res = await DbProvider.queryAllRows(
      Tables.novels,
      filter: {NovelTable.url.name: nvurl.toString()});
  if (res.isEmpty) {
    return null;
  } else {
    return Novel.fromMap(res[0]);
  }
}

Future<void> _downloadEpisodes(Novel nv, List<Episode> eps) async {
  for (var ep in eps) {
    try {
      await Future.delayed(const Duration(milliseconds: ApiProvider.interval),
          () async {
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
      }); // 制限回避用delay
    } on ClientException catch (e) {
      // offline
      log("ClientException: ${e.message}.");
      return;
    } on HttpException catch (e) {
      //serverside
      log("$e");
      continue;
    }
  }
  nv.status = NovelStatus.downloaded;
  DbProvider.update(Tables.novels, nv.toMap());
  log("addNovel: download completed.");
}
