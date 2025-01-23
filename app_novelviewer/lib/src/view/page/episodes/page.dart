// ** エピソード一覧(小説詳細)画面 ** //

import 'dart:developer';

import 'package:app_novelviewer/src/provider/provider/data/chapter.dart';
import 'package:app_novelviewer/src/provider/provider/data/episode.dart';
import 'package:app_novelviewer/src/provider/provider/data/novel.dart';
import 'package:app_novelviewer/src/view/component/dialog/select_dialog.dart';
import 'package:app_novelviewer/src/view/component/end_drawer.dart';
import 'package:app_novelviewer/src/view/component/snackbar/message_snackbar.dart';
import 'package:app_novelviewer/src/view/importer.dart';
import 'package:app_novelviewer/src/model/logic/download.dart';
import 'package:app_novelviewer/src/model/logic/update.dart';
import 'package:app_novelviewer/src/view/page/episodes/novel_info_dialog.dart';
import 'package:app_novelviewer/src/view/page/webview/page.dart';
import 'package:app_novelviewer/src/view/util/util.dart';
import 'package:flutter/material.dart';

//components
import 'package:app_novelviewer/src/view/component/dialog/delete_novel_dialog.dart';
import 'package:app_novelviewer/src/view/page/episodes/novel_info.dart';
import 'package:app_novelviewer/src/view/page/episodes/list.dart';
//pages
import 'package:app_novelviewer/src/view/page/read/page.dart';
//core
import 'package:app_novelviewer/src/model/logic/set_episode_viewed.dart';
import 'package:app_novelviewer/src/model/logic/set_novel_viewed.dart';
import 'package:app_novelviewer/src/model/logic/delete_novel.dart';

class EpisodesPage extends ConsumerStatefulWidget {
  const EpisodesPage({
    super.key,
  });

  @override
  ConsumerState<EpisodesPage> createState() => _EpisodesPageState();
}

class _EpisodesPageState extends ConsumerState<EpisodesPage> {
  late final ScrollController _controller;

  @override
  void initState() {
    final nv = ref.read(novelStateProvider.notifier);
    _controller = ScrollController(
      initialScrollOffset: 72.0 * (nv.bookmarkedEp ?? 0),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nv = ref.watch(novelStateProvider);
    final eplist = ref.watch(episodeListStateProvider(nv?.id));
    final chlist =
        ref.watch(chapterListStateProvider(nv?.id)); // チャプターごとの仕切り入れる

    const List<IconData> endDrawerIcons = [
      Icons.update,
      Icons.download,
      Icons.list,
      Icons.bookmark_remove,
      Icons.description_outlined,
      Icons.description,
      Icons.open_in_browser,
      Icons.delete,
    ];
    final List<void Function()> endDrawerfuncs = [
      _update,
      _renewIndex,
      _renewAllEp,
      _deleteBookmark,
      _setViewed,
      _setNonViewed,
      _routeWebViewPage,
      _deleteNovel,
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(EpisodesPageText.title),
      ),
      endDrawer: EndDrawer(
        titles: EpisodesPageText.sidebars,
        icons: endDrawerIcons,
        onTaps: endDrawerfuncs,
      ),
      body: FractionallySizedBox(
          heightFactor: 1,
          widthFactor: 1,
          child: Column(children: <Widget>[
            Expanded(
                // novel info
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Card(
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        splashColor:
                            Theme.of(context).colorScheme.inversePrimary,
                        highlightColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        onTap: _openNovelInfo,
                        child: NovelInfo(
                          novel: nv,
                        ),
                      )),
                )),
            Expanded(
                //episodes list
                flex: 8,
                child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: eplist.when(
                      data: (v) => EpisodeList(
                        controller: _controller,
                        itemlist: v,
                        onTap: _routeReadPage,
                        onLongPress: _openTileMenu,
                        bookmarkedEp: nv?.bookmarkedEp,
                      ),
                      error: (o, s) => Text(o.toString()),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                    ))),
          ])),
      floatingActionButton: FloatingActionButton(
        onPressed: _scrolltoStartEnd,
        child: !(_controller.hasClients) ||
                (_controller.offset < _controller.position.maxScrollExtent)
            ? const Icon(Icons.expand_more)
            : const Icon(Icons.expand_less),
      ),
    );
  }

  //routing
  void _routeReadPage(index) async {
    // set recentread
    final nv = ref.watch(novelStateProvider);
    final epList = ref.watch(episodeListStateProvider(nv?.id!)).value;
    ref.read(episodeStateProvider.notifier).set(epList![index]);
    //route
    await Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return ReadPage(
          initEp: index,
        );
      },
    ));
    log("${epList[index].title}");
    setState(() {});
  }

  void _routeWebViewPage() async {
    final nv = ref.watch(novelStateProvider)!;
    final url = Uri.parse(nv.url);
    await Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return WebViewPage(url: url);
      },
    ));
    setState(() {});
  }

  // onlongpress tile
  void _openTileMenu(int index) async {
    final void Function(int) resfunc = await showDialog(
        context: context,
        builder: (_) => SelectDialog(
              optNames: EpisodesPageText.tilemenus,
              optValues: [_renewEp, _toggleEpViewed, _setAllBeforeEpViewed],
            ));
    resfunc(index);
  }

  // ontap novelInfocard
  void _openNovelInfo() async {
    final nv = ref.watch(novelStateProvider);
    await showDialog(context: context, builder: (_) => NovelInfoDialog(nv: nv));
  }

  // scroll end
  void _scrolltoStartEnd() async {
    if (_controller.offset < _controller.position.maxScrollExtent) {
      await _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.ease,
      );
      setState(() {});
    } else {
      await _controller.animateTo(
        _controller.position.minScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.ease,
      );
      setState(() {});
    }
  }

  // sidebar func
  void _update() {
    final nv = ref.watch(novelStateProvider);
    Navigator.of(context).pop();
    updateNovel(nv!);
  }

  void _renewIndex() {}
  void _renewAllEp() {
    final nv = ref.watch(novelStateProvider);
    Navigator.of(context).pop();
    renewNv(nv!);
  }

  void _deleteBookmark() {
    final nv = ref.watch(novelStateProvider);
    Navigator.of(context).pop();
    setState(() {
      nv?.bookmarkedEp = null;
    });
  }

  void _setViewed() async {
    final nv = ref.watch(novelStateProvider);
    final epList = ref.watch(episodeListStateProvider(nv?.id)).value;
    Navigator.of(context).pop();
    setState(() {
      for (int i = 0; i < epList!.length; i++) {
        epList[i].viewed = true;
      }
      nv?.epViewed = nv.epNum;
    });
    await setNovelViewed(nv!, true); //db
  }

  void _setNonViewed() async {
    final nv = ref.watch(novelStateProvider);
    final epList = ref.watch(episodeListStateProvider(nv?.id)).value;
    Navigator.of(context).pop();
    setState(() {
      for (int i = 0; i < epList!.length; i++) {
        epList[i].viewed = false;
      }
      nv?.epViewed = 0;
    });
    await setNovelViewed(nv!, false); //db
  }

  void _deleteNovel() async {
    final nv = ref.watch(novelStateProvider);
    Navigator.of(context).pop();
    final res = await showDialog(
        context: context, builder: (_) => const DeleteNovelDialog());
    if (res ?? false) {
      deleteNovel(nv!);
      if (mounted) Navigator.of(context).pop();
      setState(() {});
    }
  }

  //tilemenu func
  void _renewEp(int index) async {
    final nv = ref.watch(novelStateProvider);
    final epList = ref.watch(episodeListStateProvider(nv?.id)).value;
    if (epList == null) return;
    await downloadEpisode(epList[index]);
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(messageSnackBar(SnackBarText.finished));
    }
  }

  void _toggleEpViewed(int index) async {
    final nv = ref.watch(novelStateProvider);
    final epList = ref.watch(episodeListStateProvider(nv?.id)).value;
    final b = !epList![index].viewed!;

    await setEpisodeViewed(epList[index], b);
    epList[index].viewed = b;
    nv?.epViewed += (b ? 1 : -1);
    setState(() {});
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(messageSnackBar(SnackBarText.finished));
    }
  }

  void _setAllBeforeEpViewed(int index) async {
    final nv = ref.watch(novelStateProvider);
    final epList = ref.watch(episodeListStateProvider(nv?.id)).value;
    if (epList == null) return;
    List<Future<void>> futures = [];
    for (int i = 0; i <= index; i++) {
      if (epList[i].viewed == true) continue;
      futures.add(setEpisodeViewed(epList[i], true));
      epList[i].viewed = true;
      nv?.epViewed += 1;
    }
    await Future.wait(futures);
    setState(() {});
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(messageSnackBar(SnackBarText.finished));
    }
  }
}
