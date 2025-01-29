// ** 起動時初期画面 ** //
import 'dart:developer';

import 'package:sample/src/provider/importer.dart';
// import 'dart:developer';

import 'package:sample/src/view/component/end_drawer.dart';
import 'package:flutter/material.dart';

import 'package:sample/src/view/importer.dart';
//components
import 'package:sample/src/view/page/home/home_info.dart';
import 'package:sample/src/view/component/buttons.dart';
import 'package:sample/src/view/component/badges.dart';
//pages
import 'package:sample/src/view/page/settings/page.dart';
//dialog
import 'package:sample/src/view/component/dialog/loading_dialog.dart';
//snackbar
import 'package:sample/src/view/component/snackbar/message_snackbar.dart';
//core

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      log("useEffect!!");
      return () => log("dispose!");
    }, []);

    void onTapAction() async {
      await showDialog(
        context: context,
        builder: (_) => LoadingDialog(message: "now loading..."),
      );
      messageSnackBar("fin!");
    }

    void routeSettingsPage() async {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsPage()),
      );
    }

    final List<IconData> endDrawerIcons = [
      Icons.settings,
      Icons.view_list,
      Icons.browse_gallery,
      Icons.star_half,
      Icons.help,
    ];

    final List<void Function()> endDrawerfuncs = [
      routeSettingsPage,
      () {}, // _routeDatasPage,
      () {},
      () {},
      () {},
    ];

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
                    splashColor: Theme.of(context).colorScheme.inversePrimary,
                    highlightColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    onTap: () {}, //_routeRecentRead,
                    child: const HomeInfo(),
                  ),
                ),
              ),
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
                              future: Future.delayed(
                                Durations.medium1,
                                () => [],
                              ), //_update.value,
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              // Custom buttons field
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: (16 / 3) / 2, // (16/3)/{crossAxisCount}
                  children: [],
                  // customButtons
                  //   .map((e) => DefaultButton(
                  //       icon: const Icon(Icons.bolt), title: e))
                  //   .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onTapAction,
        child: const Icon(Icons.add),
      ),
    );
  }
}
