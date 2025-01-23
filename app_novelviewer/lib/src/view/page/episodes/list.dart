import 'package:app_novelviewer/src/view/importer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:app_novelviewer/src/view/page/episodes/tile.dart';

class EpisodeList extends StatelessWidget {
  const EpisodeList({
    super.key,
    required this.itemlist,
    required this.onTap,
    this.onLongPress,
    required this.bookmarkedEp,
    required this.controller,
  });

  final List<Episode> itemlist;
  final void Function(int) onTap;
  final void Function(int)? onLongPress;
  final int? bookmarkedEp;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    if (itemlist.isNotEmpty) {
      return ListView.builder(
        controller: controller,
        itemBuilder: (context, index) {
          return EpisodeTile(
            episode: itemlist[index],
            onTap: () {
              onTap(index);
            },
            onLongPress: () {
              onLongPress!(index);
            },
            isBookmarked: bookmarkedEp == index,
          );
        },
        itemCount: itemlist.length,
      );
    } else {
      return const Center(child: Text(EpisodesPageText.listEmptyMessage));
    }
  }
}
