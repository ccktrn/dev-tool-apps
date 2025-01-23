// 各サイト別コードに飛ばす

import 'dart:io';
import 'package:app_novelviewer/src/model/repository/remote/sites/ncode.dart';
import 'package:app_novelviewer/src/importer.dart';
import 'package:http/http.dart';

// import 'package:flutter/services.dart' show rootBundle;
// import 'package:yaml/yaml.dart';
// //サイトデータ asset にyamlで作ってよみこむ?

class ApiProvider {
  static const interval = 100; //ms
  static const headers = {
    // 'Access-Control-Allow-Origin':'*', //わかんねぇ
    'User-Agent': 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N)'
  };

  static Future<Map<String, dynamic>> getNovel(Uri url) async {
    final Map<String, dynamic>? map;
    try {
      map = switch (url.host) {
        Ncode.host => await Ncode.getNovel(url),
        _ => null,
      };
    } on HttpException {
      rethrow;
    } on ClientException {
      rethrow;
    }
    if (map == null) {
      throw const FormatException();
    }
    return map;
  }

  static Future<(List<Map<String, dynamic>>, List<Map<String, dynamic>>)>
      getChapterAndEpisode(
          Uri nvurl, int nvId, NovelType type, int epNum) async {
    late final (List<Map<String, dynamic>>, List<Map<String, dynamic>>)? res;
    try {
      res = switch (nvurl.host) {
        Ncode.host =>
          await Ncode.getChapterAndEpisode(nvurl, nvId, type, epNum),
        _ => null,
      };
    } on HttpException {
      rethrow;
    } on ClientException {
      rethrow;
    }
    if (res == null) {
      throw const FormatException();
    }
    return res;
  }

  static Future<String> getEpisodeText(Uri epurl) async {
    final String? res;
    try {
      res = switch (epurl.host) {
        Ncode.host => await Ncode.getEpisodeText(epurl),
        _ => null,
      };
    } on HttpException {
      rethrow;
    } on ClientException {
      rethrow;
    }
    if (res == null) {
      throw const FormatException();
    }
    return res;
  }

  static Future<String> getLastUpdate(Uri nvurl) async {
    final String? res;
    try {
      res = switch (nvurl.host) {
        Ncode.host => await Ncode.getLastUpdate(nvurl),
        _ => null,
      };
    } on HttpException {
      rethrow;
    } on ClientException {
      rethrow;
    }
    if (res == null) {
      throw const FormatException();
    }
    return res;
  }
}
