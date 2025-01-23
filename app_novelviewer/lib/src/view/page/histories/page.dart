// ** ダウンロード履歴画面 ** //

import 'package:app_novelviewer/src/view/importer.dart';
import 'package:flutter/material.dart';

class HistoriesPage extends ConsumerStatefulWidget {
  const HistoriesPage({super.key});

  @override
  ConsumerState<HistoriesPage> createState() => _HistoriesPageState();
}

class _HistoriesPageState extends ConsumerState<HistoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text(AppText.name),
      ),
      body: FractionallySizedBox(
        heightFactor: 1,
        widthFactor: 1,
        child: const Text("download histories list"),
      ),
    );
  }
}
