import 'package:app_novelviewer/src/importer.dart';
import 'package:app_novelviewer/src/model/const/tables.dart';
import 'package:app_novelviewer/src/model/repository/local/db_provider.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'chapter.g.dart';

// reading? novel
@Riverpod(keepAlive: true)
class ChapterState extends _$ChapterState {
  @override
  Chapter? build() {
    return null;
  }

  void set(Chapter ch) => state = ch;
}

// ChaptersList of listpage (use 'mode' props for instance)
// filter条件とかここで指定してもいいかも
@riverpod
class ChapterListState extends _$ChapterListState {
  @override
  FutureOr<List<Chapter>> build(int? nvId) async {
    if (nvId == null) {
      return [];
    } else {
      return (await DbProvider.queryAllRows(
        Tables.chapters,
        filter: {ChapterTable.novelId.name: nvId},
        sort: ChapterTable.chOrder.name,
      ))
          .map((e) => Chapter.fromMap(e))
          .toList();
    }
  }

  void set(List<Chapter> chs) {
    state = AsyncData(chs);
  }
}
