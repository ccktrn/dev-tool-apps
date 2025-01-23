// main.dart

//start from here

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:app_novelviewer/src/model/repository/local/db_provider.dart';
import 'package:app_novelviewer/src/model/repository/local/storage_provider.dart';
import 'package:app_novelviewer/src/model/repository/local/pref_provider.dart';

import 'package:app_novelviewer/src/app.dart';

void main() async {
  //init
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    PrefProvider.init(),
    DbProvider.init(),
    StrageProvider.init(),
  ]);

  runApp(const ProviderScope(child: App()));
}
