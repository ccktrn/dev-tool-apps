import 'dart:developer';
import 'package:app_novelviewer/src/model/importer.dart';

import 'package:app_novelviewer/src/model/repository/local/db_provider.dart';
import 'package:app_novelviewer/src/model/repository/remote/api_provider.dart';
import 'package:intl/intl.dart';

Future<List<Novel>> getUpdatedNovels() async {
  // return _fake();

  final List<Novel> nvs = (await DbProvider.queryAllRows(
    Tables.novels,
    filter: {
      NovelTable.status.name: [
        NovelStatus.downloaded.value,
        NovelStatus.downloading.value,
        NovelStatus.downloadError.value,
      ],
    },
    sort: NovelTable.nvUpdate.name,
  ))
      .map((e) => Novel.fromMap(e))
      .toList();
  List<Future<String>> futures = [];
  for (Novel nv in nvs) {
    futures.add(ApiProvider.getLastUpdate(Uri.parse(nv.url)));
  }
  final nvupdates = await Future.wait(futures);

  final List<Novel> res = [];
  for (int i = 0; i < nvs.length; i++) {
    var uptime = _str2dt(nvupdates[i])!;
    if (nvs[i].nvUpdate!.isBefore(uptime)) {
      nvs[i].upTime = uptime;
      res.add(nvs[i]);
    }
  }

  log("getUpdatedNovels: nvN=${res.length}");
  return res;
}

Future<List<Novel>> _fake() async {
  final fakelist = List.generate(
      10,
      (i) => Novel(
          updateTs: DateTime.now(),
          status: NovelStatus.downloaded,
          epNum: 5,
          url: "www.google.com",
          title: "title$i",
          author: "author$i",
          description: "description$i")
        ..upNum = i * 10
        ..upTime = DateTime(2025, i, i * 2));
  return Future.delayed(const Duration(milliseconds: 500), () {
    log("getUpdatesNovels: nvId=${null}");
    return fakelist;
  });
}

DateTime? _str2dt(String? v) {
  // from DB
  if (v == null) {
    // log("_str2dt: value is null.");
    return null;
  }

  // return DateTime.parse(v);
  final formatters = [
    DateFormat("y-M-d H:m:s"), //base formatter
    DateFormat("y-M-d H:m"), //without sec.
    DateFormat("y/M/d H:m:s"), //slash with sec.
    DateFormat("y/M/d H:m"), //slash without sec.
  ];
  DateTime? res;
  for (var f in formatters) {
    res = f.tryParse(v);
    if (res != null) {
      break;
    }
  }
  if (res == null) {
    log("_str2dt: any formatters isn't matched");
    return null;
  } else {
    return res;
  }
}
