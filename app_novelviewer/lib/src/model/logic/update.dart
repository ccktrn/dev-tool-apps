import 'dart:developer';

import 'package:app_novelviewer/src/importer.dart';

// import 'package:app_novelviewer/src/data/db_provider.dart';

//要検討 並列orキュー

Future<List<int?>> updateNovels(List<Novel> nvs) async {
  List<Future<int?>> futures = [];
  for (int i = 0; i < nvs.length; i++) {
    futures.add(updateNovel(nvs[i]));
  }
  final res = await Future.wait(futures);
  log("updateNovel: $res");
  return res;
}

Future<int> updateNovel(Novel nv) async {
  return 0;
}
