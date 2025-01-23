import 'package:app_novelviewer/src/importer.dart';
import 'package:flutter/material.dart';

class NovelInfo extends StatelessWidget {
  const NovelInfo({
    super.key,
    required this.novel,
  });

  final Novel? novel;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text("${novel?.title}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textScaler: const TextScaler.linear(1.3)),
                  ),
                ),
                Center(
                    child: Text(
                  "${novel?.author}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textScaler: const TextScaler.linear(1),
                )),
                const Divider(),
                Expanded(
                  // flex: 6,
                  child: Center(
                    // child: SingleChildScrollView(
                    child: Text(
                      "${novel?.description}",
                      textScaler: const TextScaler.linear(1.1),
                    ),
                    // ),
                  ),
                ),
              ],
            )));
  }
}
