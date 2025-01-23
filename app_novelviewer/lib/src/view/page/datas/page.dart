import 'package:app_novelviewer/src/view/importer.dart';
import 'package:flutter/material.dart';

//export,import, delete-allbackup-inAppdir

class DatasPage extends ConsumerStatefulWidget {
  const DatasPage({super.key});

  @override
  ConsumerState<DatasPage> createState() => _DatasPageState();
}

class _DatasPageState extends ConsumerState<DatasPage> {
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
        child: const Text("db import, export"),
      ),
    );
  }
}
