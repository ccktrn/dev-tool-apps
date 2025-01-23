// ** 起動時初期画面 ** //
import 'dart:developer';

import 'package:app_novelviewer/src/provider/importer.dart';
import 'package:app_novelviewer/src/provider/provider/pref/app_state.dart';
import 'package:app_novelviewer/src/view/page/_test/page.dart';
// import 'dart:developer';

import 'dart:io';

import 'package:app_novelviewer/src/provider/provider/data/episode.dart';
import 'package:app_novelviewer/src/provider/provider/data/novel.dart';
import 'package:app_novelviewer/src/provider/provider/pref/custom_conf.dart';
import 'package:app_novelviewer/src/view/component/end_drawer.dart';
import 'package:flutter/material.dart';

import 'package:app_novelviewer/src/view/importer.dart';
//components
import 'package:app_novelviewer/src/view/page/home/home_info.dart';
import 'package:app_novelviewer/src/view/component/buttons.dart';
import 'package:app_novelviewer/src/view/component/badges.dart';
//pages
import 'package:app_novelviewer/src/view/page/read/page.dart';
import 'package:app_novelviewer/src/view/page/webview/page.dart';
import 'package:app_novelviewer/src/view/page/novels/page.dart';
import 'package:app_novelviewer/src/view/page/updates/page.dart';
import 'package:app_novelviewer/src/view/page/episodes/page.dart';
import 'package:app_novelviewer/src/view/page/settings/page.dart';
import 'package:app_novelviewer/src/view/page/histories/page.dart';
import 'package:app_novelviewer/src/view/page/datas/page.dart';
//dialog
import 'package:app_novelviewer/src/view/component/dialog/add_novel_dialog.dart';
import 'package:app_novelviewer/src/view/component/dialog/loading_dialog.dart';
//snackbar
import 'package:app_novelviewer/src/view/component/snackbar/message_snackbar.dart';
//core
import 'package:app_novelviewer/src/model/logic/add_novel.dart';
import 'package:http/http.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<IconData> endDrawerIcons = [
      Icons.settings,
      Icons.view_list,
      Icons.browse_gallery,
      Icons.star_half,
      Icons.help,
    ];
    final List<void Function()> endDrawerfuncs = [
      () {}, // _routeSettingsPage,
      () {}, // _routeDatasPage,
      () {}, // _routeHistoriesPage,
      () {},
      () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => const TestPage())),
    ];

    useEffect(() {
      log("useEffect!!");
    }, []);

    // // routing
    // void _routeRecentRead() async {
    //   final recent = ref.watch(recentReadStateProvider).value;
    //   if (recent == null || recent.$1.status == NovelStatus.deleted) {
    //     return;
    //   }
    //   ref.read(novelStateProvider.notifier).set(recent.$1);
    //   ref.read(episodeStateProvider.notifier).set(recent.$2);
    //   // novels => episodes => read
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => const NovelsPage()));
    //   Navigator.push(context,
    //       MaterialPageRoute(builder: (context) => const EpisodesPage()));
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => ReadPage(
    //                 initEp: recent.$2.epOrder! - 1,
    //               )));
    // }

    // void _routeNovelsPage() async {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => const NovelsPage()));
    // }

    // void _routeUpdatesPage() async {
    //   Navigator.push(context,
    //       MaterialPageRoute(builder: (context) => const UpdatesPage()));
    // }

    // void _routeWebViewPage() async {
    //   Navigator.push(context,
    //       MaterialPageRoute(builder: (context) => const WebViewPage()));
    // }

    // void _routeSettingsPage() async {
    //   Navigator.of(context).pop();
    //   Navigator.push(context,
    //       MaterialPageRoute(builder: (context) => const SettingsPage()));
    // }

    // void _routeDatasPage() async {
    //   Navigator.of(context).pop();
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => const DatasPage()));
    // }

    // void _routeHistoriesPage() async {
    //   Navigator.of(context).pop();
    //   Navigator.push(context,
    //       MaterialPageRoute(builder: (context) => const HistoriesPage()));
    // }

    // // func
    // void _addNovel() async {
    //   final String? res = await showDialog(
    //       context: context, builder: (_) => const AddnovelDialog());
    //   showDialog(
    //     context: context,
    //     barrierDismissible: false, //範囲外タップで戻る無効
    //     builder: (_) => const LoadingDialog(message: "目次取得中…"),
    //   );

    //   try {
    //     if (res != null) {
    //       await addNovel(res);
    //       ScaffoldMessenger.of(context)
    //           .showSnackBar(messageSnackBar(SnackBarText.registerd));
    //     }
    //   } on FormatException {
    //     ScaffoldMessenger.of(context)
    //         .showSnackBar(messageSnackBar(SnackBarText.unexpectedURL));
    //   } on ClientException {
    //     // ScaffoldMessenger.of(context).showSnackBar(messageSnackBar("$e"));
    //     ScaffoldMessenger.of(context)
    //         .showSnackBar(messageSnackBar(SnackBarText.networkerror));
    //   } on HttpException catch (e) {
    //     ScaffoldMessenger.of(context).showSnackBar(messageSnackBar("$e"));
    //   }
    //   // close loadingDialog
    //   Navigator.pop(context);
    // }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text(HomePageText.title),
      ),
      endDrawer: EndDrawer(
        titles: HomePageText.sidebars,
        icons: endDrawerIcons,
        onTaps: endDrawerfuncs,
      ),
      body: FractionallySizedBox(
        heightFactor: 1,
        widthFactor: 1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AspectRatio(
              // Recent read field
              aspectRatio: 8 / 5,
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Card(
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                          splashColor:
                              Theme.of(context).colorScheme.inversePrimary,
                          highlightColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          onTap: () {}, //_routeRecentRead,
                          child: const HomeInfo(
                              nv: null,
                              ep: null) //HomeInfo(nv: recent?.$1, ep: recent?.$2)
                          ))),
            ),
            AspectRatio(
                // default buttons field
                aspectRatio: 8 / 3,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          // novels button
                          flex: 6,
                          child: DefaultButton(
                            // novels
                            title: HomePageText.novelsPageButton,
                            icon: const Icon(Icons.list),
                            onPressed: () {}, //_routeNovelsPage,
                          ),
                        ),
                        Expanded(
                            flex: 6,
                            child: Column(
                              children: [
                                Expanded(
                                  // updates button
                                  flex: 6,
                                  child: DefaultBadge(
                                    // use update badge
                                    future: Future.delayed(Durations.medium1,
                                        () => []), //_update.value,
                                    badgebuilder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        final n = snapshot.data?.length;
                                        if (n == 0) {
                                          return null;
                                        } else if (n! > 99) {
                                          return const Text("99+");
                                        } else {
                                          return Text("$n");
                                        }
                                      } else {
                                        return null;
                                      }
                                    },
                                    child: DefaultButton(
                                      // updates
                                      title: HomePageText.updatesPageButton,
                                      icon: const Icon(Icons.update),
                                      onPressed: () {}, //_routeUpdatesPage,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  // Serch button
                                  flex: 6,
                                  child: DefaultButton(
                                    // search
                                    title: HomePageText.serchPageButton,
                                    icon: const Icon(Icons.search),
                                    onPressed: () {}, //_routeWebViewPage,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ))),
            Expanded(
                // Custom buttons field
                child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio:
                            (16 / 3) / 2, // (16/3)/{crossAxisCount}
                        children: []
                        // customButtons
                        //   .map((e) => DefaultButton(
                        //       icon: const Icon(Icons.bolt), title: e))
                        //   .toList(),
                        ))),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, //_addNovel,
        child: const Icon(Icons.add),
      ),
    );
  }
}
