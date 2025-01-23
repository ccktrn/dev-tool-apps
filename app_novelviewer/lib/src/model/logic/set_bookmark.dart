import 'dart:developer';

import 'package:app_novelviewer/src/model/importer.dart';

import 'package:app_novelviewer/src/model/repository/local/db_provider.dart';

Future<void> setBookmark(int nvId, int epId) async {
  await DbProvider.update(Tables.novels,
      {NovelTable.pkey: nvId, NovelTable.bookmarkedEp.name: epId});
  log("setBookmark: nvId:$nvId ep.$epId");
  return;
}
