// import 'dart:developer';

// import 'package:app_novelviewer/src/importer.dart';

import 'package:app_novelviewer/src/model/repository/local/pref_provider.dart';

Future<void> setRecentRead(int? epId) async {
  PrefProvider.lastEpId = epId;
  // log("setRecentRead: $epId");
  return;
}
