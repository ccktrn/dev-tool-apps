import 'package:app_novelviewer/src/importer.dart';
import 'package:flutter/material.dart';

class NovelInfoDialog extends StatelessWidget {
  const NovelInfoDialog({super.key, required this.nv});
  final Novel? nv;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Center(
          heightFactor: 1,
          child: SingleChildScrollView(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Text("${nv?.title}",
                      textScaler: const TextScaler.linear(1.3)),
                ),
              ),
              Center(
                  child: Text(
                "${nv?.author}",
                textScaler: const TextScaler.linear(1),
              )),
              const Divider(),
              Center(
                  child: Text(
                "${nv?.url}",
                textScaler: const TextScaler.linear(1),
              )),
              const Divider(),
              Center(
                child: Text(
                  "${nv?.description}",
                  textScaler: const TextScaler.linear(1.1),
                ),
              ),
            ],
          ))),
      actions: [
        MaterialButton(
          child: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
