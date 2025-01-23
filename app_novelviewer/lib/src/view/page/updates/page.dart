// ** 小説一覧画面 ** //
import 'package:app_novelviewer/src/model/logic/get_updated_novels.dart';

import 'package:app_novelviewer/src/view/importer.dart';
import 'package:flutter/material.dart';
// conponents
import 'package:app_novelviewer/src/view/page/updates/list.dart';

class UpdatesPage extends ConsumerStatefulWidget {
  const UpdatesPage({
    super.key,
  });

  @override
  ConsumerState<UpdatesPage> createState() => _UpdatesPageState();
}

class _UpdatesPageState extends ConsumerState<UpdatesPage> {
  // state
  late final Future<List<Novel>> _nvList;
  late final ScrollController _controller;

  @override
  void initState() {
    _nvList = getUpdatedNovels(); // dbから取得

    _controller = ScrollController();
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(UpdatesPageText.title),
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
            child: FutureBuilder(
              future: _nvList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return UpdateList(
                    controller: _controller,
                    itemlist: snapshot.data!,
                    onTap: (index) {},
                    onLongPress: (index) {},
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.offset < _controller.position.maxScrollExtent) {
            _controller.animateTo(
              _controller.position.maxScrollExtent,
              duration: const Duration(seconds: 1),
              curve: Curves.ease,
            );
          } else {
            _controller.animateTo(
              _controller.position.minScrollExtent,
              duration: const Duration(seconds: 1),
              curve: Curves.ease,
            );
          }
        },
        child: !_controller.hasClients ||
                _controller.offset < _controller.position.maxScrollExtent
            ? const Icon(Icons.expand_more)
            : const Icon(Icons.expand_less),
      ),
    );
  }
}
