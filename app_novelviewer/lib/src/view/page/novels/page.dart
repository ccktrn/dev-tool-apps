// ** 小説一覧画面 ** //

import 'dart:developer';

import 'package:app_novelviewer/src/model/logic/delete_novel.dart';
import 'package:app_novelviewer/src/provider/provider/data/novel.dart';
import 'package:app_novelviewer/src/view/component/dialog/delete_novel_dialog.dart';
import 'package:app_novelviewer/src/view/component/dialog/select_dialog.dart';
import 'package:app_novelviewer/src/view/component/snackbar/message_snackbar.dart';
import 'package:app_novelviewer/src/view/importer.dart';
import 'package:flutter/material.dart';
//pages
import 'package:app_novelviewer/src/view/page/episodes/page.dart';
import 'package:app_novelviewer/src/view/page/novels/list.dart';
//core

class NovelsPage extends ConsumerStatefulWidget {
  const NovelsPage({
    super.key,
  });

  @override
  ConsumerState<NovelsPage> createState() => _NovelsPageState();
}

class _NovelsPageState extends ConsumerState<NovelsPage> {
  // state
  late final ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nvList = ref.watch(novelListStateProvider('list'));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(NovelsPageText.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {},
          ),
        ],
      ),
      body: FractionallySizedBox(
        heightFactor: 1,
        widthFactor: 1,
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: nvList.when(
              data: (v) => NovelList(
                controller: _controller,
                itemlist: v,
                onTap: _routeEpisodesPage,
                onLongPress: _openTileMenu,
              ),
              error: (o, s) => Text(o.toString()),
              loading: () => const Center(child: CircularProgressIndicator()),
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scrolltoStartEnd,
        child: !_controller.hasClients ||
                _controller.offset < _controller.position.maxScrollExtent
            ? const Icon(Icons.expand_more)
            : const Icon(Icons.expand_less),
      ),
    );
  }

  // routing
  void _routeEpisodesPage(int index) async {
    final nvlist = ref.watch(novelListStateProvider('list')).value;
    if (nvlist == null) {
      return;
    } else if (nvlist[index].status == NovelStatus.deleted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(messageSnackBar(SnackBarText.deleted));
    } else {
      ref.read(novelStateProvider.notifier).set(nvlist[index]);
      await Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return const EpisodesPage();
        },
      ));
      setState(() {});
    }
    log("${ref.watch(novelStateProvider)?.id}");
    log("${nvlist[index].id}");
  }

  void _openTileMenu(int index) async {
    final void Function(int) resfunc = await showDialog(
      context: context,
      builder: (_) => SelectDialog(
          optNames: NovelsPageText.tilemenus,
          optValues: [_renewIndex, _renewAllEp, _delete]),
    );
    resfunc(index);
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

  //tilemenu func
  void _renewIndex(int index) async {}
  void _renewAllEp(int index) async {}
  void _delete(int index) async {
    final nvList = ref.watch(novelListStateProvider('list')).value;
    final bool? res = await showDialog(
        context: context, builder: (_) => const DeleteNovelDialog());
    if ((res ?? false) && nvList != null) {
      deleteNovel(nvList[index]);
      if (mounted) Navigator.of(context).pop();
      setState(() {});
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(messageSnackBar(SnackBarText.finished));
      }
    }
  }
}
