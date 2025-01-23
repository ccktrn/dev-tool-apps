import 'package:app_novelviewer/src/view/importer.dart';
import 'package:flutter/material.dart';
import 'package:app_novelviewer/src/view/util/util.dart';

class NovelTile extends StatelessWidget {
  const NovelTile({
    super.key,
    required this.novel,
    required this.onTap,
    this.onLongPress,
  });

  final Novel novel;
  final void Function() onTap;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: (novel.epNum <= novel.epViewed)
          ? const Icon(Icons.book_outlined)
          : const Icon(Icons.book),
      title: Text(
        "${novel.title}",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: FractionallySizedBox(
          widthFactor: 1,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Expanded(
              flex: 3,
              child: Text(
                "${novel.author}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text(
                    "${novel.epViewed}/${novel.epNum}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                  ),
                )),
            Expanded(
                flex: 5,
                child: Text(
                  "${FormatText.dt2str(novel.nvUpdate)} ${NovelsPageText.update}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                )),
          ])),
      onTap: onTap,
      onLongPress: onLongPress,
    ));
  }
}
