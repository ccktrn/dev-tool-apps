import 'package:app_novelviewer/src/importer.dart';
import 'package:flutter/material.dart';
import 'package:app_novelviewer/src/view/util/util.dart';

class UpdateTile extends StatelessWidget {
  const UpdateTile({
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
      leading: const Icon(Icons.book_outlined),
      trailing: _UpdateCounter(
        updateNum: novel.upNum,
      ),
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
              flex: 5,
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
                    FormatText.dt2str(novel.nvUpdate),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            Expanded(
                flex: 3,
                child: Text(
                  FormatText.dt2str(novel.upTime),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                )),
          ])),
      onTap: onTap,
      onLongPress: onLongPress,
    ));
  }
}

class _UpdateCounter extends StatelessWidget {
  const _UpdateCounter({
    required this.updateNum,
  });
  final int? updateNum;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Theme.of(context).colorScheme.inversePrimary,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 13),
          child: Text(
            updateNum == null
                ? "?"
                : updateNum! > 99
                    ? "99+"
                    : "$updateNum",
            textScaler: const TextScaler.linear(1.3),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ));
  }
}
