// import 'package:flutter/material.dart';
// import 'package:sample/src/model/const/tables.dart';
// import "package:intl/intl.dart";

// nv,epupdate:作品の更新日時
// updateTs:アプリのDBの更新

class Novel {
  //instance Constractor
  Novel({
    this.id,
    this.updated_at,
    this.created_at,
    this.deleted_at,
    required this.url,
    required this.title,
    required this.author,
    required this.description,
  });
  //-- instance var
  final int? id; // pKey
  String url;
  String? title;
  String? author;
  String? description;
  DateTime? updated_at;
  DateTime? created_at;
  DateTime? deleted_at;

  factory Novel.fromMap(Map<String, dynamic> map) {
    return Novel(
      id: map["id"],
      url: map["url"],
      title: map["title"],
      author: map["author"],
      description: map["description"],
      updated_at: map["updated_at"],
      created_at: map["created_at"],
      deleted_at: map["deleted_at"],
    );
  }
}

enum NovelStatus {
  // Novel.status
  deleted(0),
  downloaded(1),
  downloading(2),
  downloadError(3);

  const NovelStatus(this.value);
  final int value;

  static fromValue(int? v) => switch (v) {
    0 => deleted,
    1 => downloaded,
    2 => downloading,
    3 => downloadError,
    _ => null,
  };
}

enum NovelType {
  // Novel.status
  long(0), //長編(連載中)
  completed(1), //長編(完結済)
  short(2); //短編

  const NovelType(this.value);
  final int value;

  static fromValue(int v) => switch (v) {
    0 => long,
    1 => completed,
    2 => short,
    _ => null,
  };
}

// // trans

// int? _bool2int(bool? v) => v != null ? (v ? 1 : 0) : 0; // toDB
// bool? _int2bool(int? v) =>
//     v != null ? (v != 0 ? true : false) : false; // from DB

// String? _dt2str(DateTime? v) =>
//     v != null ? DateFormat("yyyy-MM-dd HH:mm:ss").format(v) : null; // to DB
// DateTime? _str2dt(String? v) {
//   // from DB
//   if (v == null) {
//     // log("_str2dt: value is null.");
//     return null;
//   }

//   // return DateTime.parse(v);
//   final formatters = [
//     DateFormat("y-M-d H:m:s"), //base formatter
//     DateFormat("y-M-d H:m"), //without sec.
//     DateFormat("y/M/d H:m:s"), //slash with sec.
//     DateFormat("y/M/d H:m"), //slash without sec.
//   ];
//   DateTime? res;
//   for (var f in formatters) {
//     res = f.tryParse(v);
//     if (res != null) {
//       break;
//     }
//   }
//   if (res == null) {
//     log("_str2dt: any formatters isn't matched");
//     return null;
//   } else {
//     return res;
//   }
// }
