import 'package:app_novelviewer/src/view/importer.dart';
import 'package:flutter/material.dart';

class AddnovelDialog extends StatelessWidget {
  const AddnovelDialog({super.key});

  @override
  Widget build(BuildContext context) {
    String url = "";
    return AlertDialog(
      // icon: const Icon(Icons.note_add_outlined),
      title: const Text(DialogText.addNovelTitle),
      content: FractionallySizedBox(
        widthFactor: 1,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text(DialogText.addNovelMessage),
          TextField(
            decoration: const InputDecoration(
              hintText: DialogText.addNovelExampleUrl,
              border: UnderlineInputBorder(),
            ),
            keyboardType: TextInputType.url,
            onChanged: (v) => url = v,
          ),
        ]),
      ),
      actions: [
        // ボタン領域
        MaterialButton(
          child: const Text(DialogText.ok),
          onPressed: () => Navigator.pop(context, url),
        ),
        MaterialButton(
          child: const Text(DialogText.cancel),
          onPressed: () => Navigator.pop(context, null),
        ),
      ],
    );
  }
}
