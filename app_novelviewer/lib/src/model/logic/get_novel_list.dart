import 'dart:developer';
import 'package:app_novelviewer/src/model/importer.dart';

import 'package:app_novelviewer/src/model/repository/local/db_provider.dart';

Future<List<Novel>> getNovelList(
    {Map<String, dynamic>? filter, String? sort}) async {
  //from database
  final res = await DbProvider.queryAllRows(
    Tables.novels,
    filter: filter,
    sort: sort,
  );

  List<Novel> nvList =
      res.isNotEmpty ? res.map((m) => Novel.fromMap(m)).toList() : [];

  log("getNovelList: nvN=${res.length}");
  return nvList;
}
