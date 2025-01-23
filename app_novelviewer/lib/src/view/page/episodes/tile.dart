import 'dart:developer';

import 'package:app_novelviewer/src/view/importer.dart';
import 'package:flutter/material.dart';
import 'package:app_novelviewer/src/view/util/util.dart';

class EpisodeTile extends StatelessWidget {
  const EpisodeTile({
    super.key,
    required this.episode,
    required this.onTap,
    this.onLongPress,
    required this.isBookmarked,
  });

  final Episode episode;
  final void Function() onTap;
  final void Function()? onLongPress;
  final bool isBookmarked;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: episode.viewed!
          ? const Icon(Icons.description_outlined)
          : const Icon(Icons.description),
      trailing: isBookmarked ? const Icon(Icons.bookmark) : null,
      title: Text(
        "${episode.title}",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        // 未読bold
        style: episode.viewed!
            ? null
            : const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: FractionallySizedBox(
          widthFactor: 1,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Expanded(
              flex: 2,
              child: Text(
                "ep.${episode.epOrder}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
                flex: 3,
                child: Text(
                  "${FormatText.dt2str(episode.epUpdate)} ${EpisodesPageText.update}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),
          ])),
      onTap: onTap,
      onLongPress: onLongPress,
    ));
  }
}
