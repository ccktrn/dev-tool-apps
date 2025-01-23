// import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:app_novelviewer/src/model/const/tables.dart';
import "package:intl/intl.dart";

// nv,epupdate:作品の更新日時
// updateTs:アプリのDBの更新

class Novel {
  //instance Constractor
  Novel({
    this.id,
    this.updateTs,
    this.downloadTs,
    this.deleteTs,
    required this.status,
    this.nvUpdate,
    required this.url,
    required this.title,
    required this.author,
    required this.description,
    this.type = NovelType.long,
    this.bookmarkedEp,
    required this.epNum,
    this.epViewed = 0,
  });
  //-- instance var
  final int? id; // pKey
  NovelStatus status;
  DateTime? nvUpdate;
  String url;
  String? title;
  String? author;
  String? description;
  NovelType type;
  int? bookmarkedEp;
  int epNum;
  int epViewed;
  DateTime? updateTs;
  DateTime? downloadTs;
  DateTime? deleteTs;

  //------ non-db var  -----
  int? upNum; //use in updatedNovel
  DateTime? upTime;

  factory Novel.fromMap(Map<String, dynamic> map) {
    return Novel(
      id: map[NovelTable.id.name],
      status: NovelStatus.fromValue(map[NovelTable.status.name]),
      url: map[NovelTable.url.name],
      nvUpdate: _str2dt(map[NovelTable.nvUpdate.name]),
      updateTs: _str2dt(map[NovelTable.updateTs.name]),
      downloadTs: _str2dt(map[NovelTable.downloadTs.name]),
      deleteTs: _str2dt(map[NovelTable.deleteTs.name]),
      title: map[NovelTable.title.name],
      author: map[NovelTable.author.name],
      description: map[NovelTable.description.name],
      type: NovelType.fromValue(map[NovelTable.type.name]),
      bookmarkedEp: map[NovelTable.bookmarkedEp.name],
      epNum: map[NovelTable.epNum.name],
      epViewed: map[NovelTable.epViewed.name] ?? 0,
    );
  }
  Map<String, dynamic> toMap() {
    final map = {
      NovelTable.id.name: id,
      NovelTable.status.name: status.value,
      NovelTable.nvUpdate.name: _dt2str(nvUpdate),
      NovelTable.updateTs.name: _dt2str(updateTs),
      NovelTable.downloadTs.name: _dt2str(downloadTs),
      NovelTable.deleteTs.name: _dt2str(deleteTs),
      NovelTable.url.name: url,
      NovelTable.title.name: title,
      NovelTable.author.name: author,
      NovelTable.description.name: description,
      NovelTable.type.name: type.value,
      NovelTable.bookmarkedEp.name: bookmarkedEp,
      NovelTable.epNum.name: epNum,
      NovelTable.epViewed.name: epViewed,
    };
    map.removeWhere((k, v) => v == null); //null値を削除
    return map;
  }
}

class Episode {
  //instance Constractor
  Episode({
    this.id,
    this.updateTs,
    required this.url,
    required this.novelId,
    required this.chOrder,
    required this.epOrder,
    required this.title,
    this.epUpdate,
    this.viewed = false,
  });
  //-- instance var
  final int? id; // pKey
  final String url;
  final int? novelId; // -> Novel.id
  final int? chOrder; // (-> )Chapter.chOrder
  final int? epOrder; //ep order in novel
  DateTime? epUpdate;
  DateTime? updateTs;
  String? title;
  bool? viewed;
  //unique(novelId,epOrder)

  factory Episode.fromMap(Map<String, dynamic> map) {
    return Episode(
      id: map[EpisodeTable.id.name],
      updateTs: _str2dt(map[EpisodeTable.updateTs.name]),
      url: map[EpisodeTable.url.name],
      novelId: map[EpisodeTable.novelId.name],
      chOrder: map[EpisodeTable.chOrder.name],
      epOrder: map[EpisodeTable.epOrder.name],
      epUpdate: _str2dt(map[EpisodeTable.epUpdate.name]),
      title: map[EpisodeTable.title.name],
      viewed: _int2bool(map[EpisodeTable.viewed.name]),
    );
  }
  Map<String, dynamic> toMap() {
    final map = {
      EpisodeTable.id.name: id,
      EpisodeTable.url.name: url,
      EpisodeTable.novelId.name: novelId,
      EpisodeTable.chOrder.name: chOrder,
      EpisodeTable.epOrder.name: epOrder,
      EpisodeTable.epUpdate.name: _dt2str(epUpdate),
      EpisodeTable.title.name: title,
      EpisodeTable.viewed.name: _bool2int(viewed),
      EpisodeTable.updateTs.name: _dt2str(updateTs),
    };
    map.removeWhere((k, v) => v == null); //null値を削除
    return map;
  }

  // 本文保存時のファイル名
  static String epFilename(int nvId, int epId) => "${nvId}_$epId";
}

class Chapter {
  //instance Constractor
  Chapter({
    this.id,
    this.updateTs,
    required this.novelId,
    required this.chOrder,
    required this.title,
    this.description,
    this.firstEpOrder,
    this.epNum,
  });
  //-- instance var
  final int? id; // pKey
  final int? novelId; // -> Novel.id
  final int? chOrder; //ep order in novel
  final int? firstEpOrder; //( -> )Episode.epOrder
  final int? epNum;
  String? title;
  String? description;
  DateTime? updateTs;

  factory Chapter.fromMap(Map<String, dynamic> map) {
    return Chapter(
      id: map[ChapterTable.id.name],
      updateTs: _str2dt(map[ChapterTable.updateTs.name]),
      novelId: map[ChapterTable.novelId.name],
      title: map[ChapterTable.title.name],
      description: map[ChapterTable.description.name],
      chOrder: map[ChapterTable.chOrder.name],
      firstEpOrder: map[ChapterTable.firstEpOrder.name],
      epNum: map[ChapterTable.epNum.name],
    );
  }
  Map<String, dynamic> toMap() {
    final map = {
      ChapterTable.id.name: id,
      ChapterTable.updateTs.name: _dt2str(updateTs),
      ChapterTable.novelId.name: novelId,
      ChapterTable.title.name: title,
      ChapterTable.description.name: description,
      ChapterTable.chOrder.name: chOrder,
      ChapterTable.firstEpOrder.name: firstEpOrder,
      ChapterTable.epNum.name: epNum,
    };
    map.removeWhere((k, v) => v == null); //null値を削除
    return map;
  }
}

enum NovelStatus {
  // Novel.status
  deleted(0),
  downloaded(1),
  downloading(2),
  downloadError(3),
  ;

  const NovelStatus(this.value);
  final int value;

  static fromValue(int? v) => switch (v) {
        0 => deleted,
        1 => downloaded,
        2 => downloading,
        3 => downloadError,
        _ => null
      };
}

enum NovelType {
  // Novel.status
  long(0), //長編(連載中)
  completed(1), //長編(完結済)
  short(2),
  ; //短編

  const NovelType(this.value);
  final int value;

  static fromValue(int v) =>
      switch (v) { 0 => long, 1 => completed, 2 => short, _ => null };
}

// trans

int? _bool2int(bool? v) => v != null ? (v ? 1 : 0) : 0; // toDB
bool? _int2bool(int? v) =>
    v != null ? (v != 0 ? true : false) : false; // from DB

String? _dt2str(DateTime? v) =>
    v != null ? DateFormat("yyyy-MM-dd HH:mm:ss").format(v) : null; // to DB
DateTime? _str2dt(String? v) {
  // from DB
  if (v == null) {
    // log("_str2dt: value is null.");
    return null;
  }

  // return DateTime.parse(v);
  final formatters = [
    DateFormat("y-M-d H:m:s"), //base formatter
    DateFormat("y-M-d H:m"), //without sec.
    DateFormat("y/M/d H:m:s"), //slash with sec.
    DateFormat("y/M/d H:m"), //slash without sec.
  ];
  DateTime? res;
  for (var f in formatters) {
    res = f.tryParse(v);
    if (res != null) {
      break;
    }
  }
  if (res == null) {
    log("_str2dt: any formatters isn't matched");
    return null;
  } else {
    return res;
  }
}
