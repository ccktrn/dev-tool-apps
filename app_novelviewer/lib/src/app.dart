// root class of app

import 'dart:developer';
// import 'package:package_info_plus/package_info_plus.dart';

import 'package:app_novelviewer/src/provider/provider/pref/theme_conf.dart';
import 'package:app_novelviewer/src/view/const/texts.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import 'package:app_novelviewer/src/view/page/home/page.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  late StreamSubscription _intentSub;
  final List<SharedMediaFile> _sharedFiles = [];

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      // if web
    } else {
      //if non-web (in native)

      // Listen to media sharing coming from outside the app while the app is in the memory.
      _intentSub = ReceiveSharingIntent.getMediaStream().listen((value) {
        setState(() {
          _sharedFiles.clear();
          _sharedFiles.addAll(value);

          log(_sharedFiles.map((f) => f.path).join(', '));
        });
      }, onError: (err) {
        log("getIntentDataStream error: $err");
      });
      // Get the media sharing coming from outside the app while the app is closed.
      ReceiveSharingIntent.getInitialMedia().then((value) {
        setState(() {
          _sharedFiles.clear();
          _sharedFiles.addAll(value);
          log(_sharedFiles.map((f) => f.path).join(', '));

          // Tell the library that we are done processing the intent.
          ReceiveSharingIntent.reset();
        });
      });
    }
  }

  @override
  void dispose() {
    _intentSub.cancel();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppText.name,
      themeMode: ref.watch(themeModeStateProvider),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: ref.watch(themeColorStateProvider).color,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: ref.watch(themeColorStateProvider).color,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false, // debug-modeの右上バナー消去
    );
  }
}
