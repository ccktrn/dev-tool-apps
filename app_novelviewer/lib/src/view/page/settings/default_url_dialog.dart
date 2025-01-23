import 'package:app_novelviewer/src/view/importer.dart';
import 'package:flutter/material.dart';

class DefaultUrlDialog extends StatelessWidget {
  const DefaultUrlDialog({
    super.key,
    this.url,
  });
  final String? url;

  @override
  Widget build(BuildContext context) {
    String url = "";
    return AlertDialog(
      // icon: const Icon(Icons.search_outlined),
      title: const Text(DialogText.defaultUrlTitle),
      content: FractionallySizedBox(
        widthFactor: 1,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text(DialogText.defaultUrlMessage),
          TextField(
            decoration: const InputDecoration(
              hintText: DialogText.defaultUrlExampleUrl,
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
