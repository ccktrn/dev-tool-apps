import 'package:app_novelviewer/src/model/logic/get_text.dart';

import 'package:app_novelviewer/src/view/importer.dart';
import 'package:flutter/material.dart';

class TextView extends StatefulWidget {
  const TextView({
    super.key,
    required this.ep,
    this.ch,
    this.fontsize = 0,
    this.spacing = 2,
  });

  final Episode ep; //episode
  final Chapter? ch; // chapter

  final double fontsize;
  final double spacing;

  @override
  State<TextView> createState() => _TextViewState();
}

class _TextViewState extends State<TextView> {
  late final Future<String?> _text;

  @override
  void initState() {
    _text = getText(widget.ep);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _text,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null) {
            return SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Center(
                        child: widget.ch == null
                            ? Container()
                            : Text(
                                // chTitle
                                widget.ch?.title ?? "ch.title",
                                textScaler: TextScaler.linear(
                                    1 * (1 + widget.fontsize / 10)),
                              ),
                      ),
                      Center(
                        heightFactor: 2,
                        child: Text(
                          // title
                          widget.ep.title ?? "ep.title",
                          textScaler: TextScaler.linear(
                              1.3 * (1 + widget.fontsize / 10)),
                        ),
                      ),
                      const Divider(
                        indent: 2,
                        endIndent: 2,
                      ),
                      Text(
                        // content
                        snapshot.data!,
                        textScaler:
                            TextScaler.linear(1.1 * (1 + widget.fontsize / 10)),
                        style: TextStyle(height: 1 + widget.spacing),
                      )
                    ]));
          } else {
            // textfile not found
            return Center(
              child: Text(
                ReadPageText.textEmptyMessage,
                textScaler: const TextScaler.linear(1),
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            );
          }
        } else {
          // on loading
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
