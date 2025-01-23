import 'package:app_novelviewer/src/view/importer.dart';
import 'package:flutter/material.dart';

class DeleteNovelDialog extends StatelessWidget {
  const DeleteNovelDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // icon: const Icon(Icons.delete),
      title: const Text(DialogText.deleteNovelTitle),
      content: const Text(DialogText.deleteNovelMessage),
      actions: [
        // ボタン領域
        MaterialButton(
          child: const Text(DialogText.yes),
          onPressed: () => Navigator.pop(context, true),
        ),
        MaterialButton(
          child: const Text(DialogText.no),
          onPressed: () => Navigator.pop(context, false),
        ),
      ],
    );
  }
}
