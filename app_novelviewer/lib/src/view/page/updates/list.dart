import 'package:app_novelviewer/src/view/importer.dart';
import 'package:flutter/material.dart';

import 'package:app_novelviewer/src/view/page/updates/tile.dart';

class UpdateList extends StatelessWidget {
  const UpdateList({
    super.key,
    required this.itemlist,
    required this.onTap,
    this.onLongPress,
    required this.controller,
  });

  final List<Novel> itemlist;
  final void Function(int) onTap;
  final void Function(int)? onLongPress;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    if (itemlist.isNotEmpty) {
      return ListView.builder(
        controller: controller,
        itemBuilder: (context, index) {
          return UpdateTile(
            novel: itemlist[index],
            onTap: () {
              onTap(index);
            },
            onLongPress: () {
              onLongPress!(index);
            },
          );
        },
        itemCount: itemlist.length,
      );
    } else {
      return const Center(child: Text(UpdatesPageText.listEmptyMessage));
    }
  }
}
