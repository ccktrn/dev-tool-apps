import 'package:sample/src/importer.dart';
import 'package:sample/src/model/const/tables.dart';
import 'package:sample/src/model/repository/local/db_provider.dart';
import 'package:sample/src/model/repository/local/pref_provider.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'novel.g.dart';

// reading,last-read novel
@Riverpod(keepAlive: true)
class NovelState extends _$NovelState {
  @override
  Novel? build() {
    //  set last read
    ref.listenSelf((previous, next) {
      PrefProvider.lastNvId = next?.id;
    });
    return null;
  }

  void set(Novel nv) => state = nv;

  int? get id => state?.id;
}

// novelsList of listpage (use 'mode' props for instance)
// filter条件とかここで指定してもいいかも
@riverpod
class NovelListState extends _$NovelListState {
  @override
  FutureOr<List<Novel>> build(String mode) async {
    final filter = switch (mode) {
      "list" => {
        "status": [
          NovelStatus.downloadError.value,
          NovelStatus.downloading.value,
          NovelStatus.downloaded.value,
        ],
      },
      "deleted" => {"status": NovelStatus.deleted.value},
      _ => null,
    };
    return (await DbProvider.queryAllRows(
      Tables.novels,
      filter: filter,
    )).map((e) => Novel.fromMap(e)).toList();
  }

  void set(List<Novel> nvs) {
    state = AsyncData(nvs);
  }
}
