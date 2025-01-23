// ** ビュー(実際に読む)画面 ** //
import 'dart:developer';
import 'package:app_novelviewer/src/provider/provider/data/chapter.dart';
import 'package:app_novelviewer/src/provider/provider/data/episode.dart';
import 'package:app_novelviewer/src/provider/provider/data/novel.dart';
import 'package:app_novelviewer/src/provider/provider/pref/app_state.dart';
import 'package:app_novelviewer/src/provider/provider/pref/view_conf.dart';
import 'package:app_novelviewer/src/view/importer.dart';
import 'package:app_novelviewer/src/model/logic/download.dart';
import 'package:flutter/material.dart';
//components
import 'package:app_novelviewer/src/view/page/read/text_view.dart';
//core
import 'package:app_novelviewer/src/model/logic/set_bookmark.dart';

class ReadPage extends ConsumerStatefulWidget {
  const ReadPage({
    super.key,
    required this.initEp,
  });
  final int initEp;

  @override
  ConsumerState<ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends ConsumerState<ReadPage> {
  //state
  late int _readingEp; // order-1

  @override
  void initState() {
    _readingEp = widget.initEp;

    super.initState();

    final nv = ref.read(novelStateProvider.notifier);
    final ep = ref.read(episodeStateProvider.notifier);
    if (!(ep.viewed ?? true)) {
      ep.setViewed(true);
      nv.addEpViewed(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final nv = ref.watch(novelStateProvider);

    final epList = ref.watch(episodeListStateProvider(nv?.id!)).value;
    final chList = ref.watch(chapterListStateProvider(nv?.id!)).value;

    final fontsize = ref.watch(viewFontsizeStateProvider);
    final spacing = ref.watch(viewSpacingStateProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // centerTitle:false,
        title: Text(
          "(${_readingEp + 1}/${nv?.epNum}) ${nv?.title}",
          overflow: TextOverflow.ellipsis,
        ),
      ),
      endDrawer: SizedBox(
        width: 250,
        child: Drawer(
          child: ListView(children: [
            const SizedBox(
              height: 80,
            ), //スペース
            ListTile(
              // FontSize   デフォルトへの係数
              leading: const Icon(Icons.format_size),
              title: const Text(ReadPageText.sidebarFontSize),
              subtitle: Slider(
                  value: fontsize,
                  min: -5,
                  max: 5,
                  divisions: 10,
                  label: "${fontsize > 0 ? "+" : ""}${fontsize.round()}",
                  onChanged: _onChangeFontsize),
            ),
            ListTile(
              // spacing (space/letter)
              leading: const Icon(Icons.unfold_more),
              title: const Text(ReadPageText.sidebarSpacing),
              subtitle: Slider(
                  value: spacing,
                  min: 0,
                  max: 5,
                  divisions: 10,
                  label: spacing.toString(),
                  onChanged: _onChangeSpacing),
            ),
            ListTile(
                leading: const Icon(Icons.download),
                title: const Text(ReadPageText.sidebarDownload),
                onTap: _download),
          ]),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: PageView.builder(
            controller: PageController(initialPage: widget.initEp),
            itemCount: epList?.length,
            itemBuilder: (context, index) {
              if (epList != null && chList != null) {
                return TextView(
                  ep: epList[index],
                  ch: chList.isEmpty
                      ? null
                      : chList[epList[index].chOrder! - 1],
                  fontsize: fontsize,
                  spacing: spacing,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
            onPageChanged: _onPageChenged,
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: _setBookmark,
        child: nv!.bookmarkedEp == _readingEp
            ? const Icon(Icons.bookmark)
            : const Icon(Icons.bookmark_outline),
      ),
    );
  }

  void _onPageChenged(int index) {
    final nv = ref.read(novelStateProvider.notifier);
    final ep = ref.read(episodeStateProvider.notifier);
    log("page:${index + 1}");
    _readingEp = index;
    //set recentread
    ref.read(recentReadStateProvider.notifier).set(
        ref.watch(novelStateProvider)!,
        ref.watch(episodeListStateProvider(nv.id)).value![index]);

    if (!(ep.viewed ?? true)) {
      ep.setViewed(true);
      nv.addEpViewed(1);
    }
    setState(() {});
  }

  void _setBookmark() {
    final nv = ref.read(novelStateProvider);
    setBookmark(nv!.id!, _readingEp);
    setState(() {
      if (nv.bookmarkedEp == _readingEp) {
        nv.bookmarkedEp = null;
      } else {
        nv.bookmarkedEp = _readingEp;
      }
    });
  }

  void _download() async {
    final nv = ref.watch(novelStateProvider);
    final epList = ref.watch(episodeListStateProvider(nv?.id)).value;
    await downloadEpisode(epList![_readingEp]);
    setState(() {});
  }

  void _onChangeFontsize(double v) {
    ref.read(viewFontsizeStateProvider.notifier).set(v);
  }

  void _onChangeSpacing(double v) {
    ref.read(viewSpacingStateProvider.notifier).set(v);
  }
}
