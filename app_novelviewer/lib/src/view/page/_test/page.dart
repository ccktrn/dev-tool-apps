import 'package:app_novelviewer/src/view/importer.dart';
import 'package:flutter/material.dart';

class TestPage extends ConsumerStatefulWidget {
  const TestPage({super.key});

  @override
  ConsumerState<TestPage> createState() => _TestPageState();
}

class _TestPageState extends ConsumerState<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text("テストページ"),
      ),
      body: const FractionallySizedBox(
        heightFactor: 1,
        widthFactor: 1,
        child: Text("testing...."),
      ),
    );
  }
}
