import 'dart:developer';
import 'package:app_novelviewer/src/model/importer.dart';

import 'package:app_novelviewer/src/model/repository/local/db_provider.dart';

Future<List<Chapter>> getChapterList(int nvId) async {
  //from database
  final res = await DbProvider.queryAllRows(
    Tables.chapters,
    filter: {ChapterTable.novelId.name: nvId},
    sort: ChapterTable.chOrder.name,
  );
  log("getChapterList: nvId=$nvId, epN=${res.length}");
  List<Chapter> chList =
      res.isNotEmpty ? res.map((m) => Chapter.fromMap(m)).toList() : [];
  return chList;
}
