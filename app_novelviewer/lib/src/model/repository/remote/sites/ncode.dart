// https://ncode.syosetu.com/

import 'dart:developer';
import 'dart:io';
import 'package:app_novelviewer/src/importer.dart';
import 'package:app_novelviewer/src/model/const/tables.dart';
import 'package:app_novelviewer/src/model/repository/remote/api_provider.dart';
import 'package:yaml/yaml.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;

//-- https://ncode.syosetu.com/n{0000aa}/{0} -- //
class Ncode {
  static const sitename = '小説家になろう';
  static const host = 'ncode.syosetu.com';
  static const api = 'https://api.syosetu.com/novelapi/api/';
  static final regTimestamp =
      RegExp(r'\d{4}/\d{2}/\d{2} \d{2}:\d{2}'); //正規表現の日付の形
  static const maxP = 100; // n6958gk/?p={ページ番号} のmax

  static Future<Map<String, dynamic>?> getNovel(Uri nvurl) async {
    //narou

    final ncode = nvurl.pathSegments[0];
    const of = 't-n-w-s-nt-e-nu-ga'; //取得するデータの指定
    final apiurl = Uri.parse("$api?out=yaml&libtype=1&ncode=$ncode&of=$of");
    late final http.Response response;
    try {
      response =
          await http.get(apiurl, headers: ApiProvider.headers); //needs on web
    } on HttpException {
      rethrow;
    } on http.ClientException {
      // log("kokokoko");
      rethrow;
    }
    if (response.statusCode != 200) {
      throw HttpException("code: ${response.statusCode}");
    }
    final yaml = loadYaml(response.body)[1]; //最初の要素は全要素数
    return {
      NovelTable.url.name: nvurl.toString(),
      NovelTable.title.name: yaml['title'],
      NovelTable.author.name: yaml['writer'],
      NovelTable.description.name: yaml['story'],
      NovelTable.type.name: yaml['noveltype'] -
          yaml['end'], //novel_type:{連載:1,短編:2},end:{完結,短編:0,未完:1}
      NovelTable.nvUpdate.name: yaml['novelupdated_at'],
      NovelTable.epNum.name: yaml['general_all_no'],
      NovelTable.status.name: NovelStatus.downloading.value,
    };
  }

  static Future<(List<Map<String, dynamic>>, List<Map<String, dynamic>>)>
      getChapterAndEpisode(Uri nvurl, int nvId, NovelType type, int epNum,
          {String? nvtitle, String? nvUpdate}) async {
    //get epInfo
    late final List<Map<String, dynamic>> chInfoMaps;
    late final List<Map<String, dynamic>> epInfoMaps;
    try {
      if (type == NovelType.short) {
        // if short
        chInfoMaps = [];
        epInfoMaps = [
          {
            EpisodeTable.url.name: nvurl.toString(),
            EpisodeTable.novelId.name: nvId,
            EpisodeTable.chOrder.name: 0,
            EpisodeTable.epOrder.name: 1,
            EpisodeTable.title.name: nvtitle ?? "",
            EpisodeTable.epUpdate.name: nvUpdate,
            EpisodeTable.viewed.name: null,
          }
        ];
      } else {
        // if long
        (chInfoMaps, epInfoMaps) = await _getChEpInfos(nvurl, nvId, epNum);
      }
    } on HttpException {
      rethrow;
    } on http.ClientException {
      rethrow;
    }

    return (chInfoMaps, epInfoMaps);
  }

  static Future<String?> getEpisodeText(Uri epurl) async {
    late final http.Response response;
    try {
      response =
          await http.get(epurl, headers: ApiProvider.headers); //needs on web
    } on http.ClientException {
      rethrow;
    }
    if (response.statusCode != 200) {
      throw HttpException("code: ${response.statusCode}");
    }
    final document = html.parse(response.body); //html document

    final textP = document.getElementById('novel_p')?.text;
    final textM = document.getElementById('novel_honbun')?.text;
    final textA = document.getElementById('novel_a')?.text;
    // log("Ep:\n p:${textP?.length} m:${textM?.length} a:${textA?.length}");
    return "${textP ?? ""}\n--\n$textM\n--\n${textA ?? ""}";
  }

  static Future<String?> getLastUpdate(Uri nvurl) async {
    final ncode = nvurl.pathSegments[0];
    const of = 'nu'; //取得するデータの指定
    final apiurl = Uri.parse("$api?out=yaml&libtype=1&ncode=$ncode&of=$of");
    late final http.Response response;

    try {
      response =
          await http.get(apiurl, headers: ApiProvider.headers); //needs on web
    } on HttpException {
      rethrow;
    } on http.ClientException {
      rethrow;
    }
    if (response.statusCode != 200) {
      throw HttpException("code: ${response.statusCode}");
    }
    if (loadYaml(response.body).length != 1) {
      final yaml = loadYaml(response.body)[1]; //最初の要素は全要素数
      return yaml['novelupdated_at'];
    } else {
      //novel deleted?
      return "0000-00-00 00:00";
    }
  }

// -- private methods //

  // return (chMaps,epMaps)
  static Future<(List<Map<String, dynamic>>, List<Map<String, dynamic>>)>
      _getChEpInfos(Uri nvurl, int nvId, int epNum) async {
    final List<Map<String, dynamic>> chMaps = [];
    final List<Map<String, dynamic>> epMaps = [];
    int cEpInCh = 0; //ep in ch count
    int cEp = 0; //ep count

    for (int i = 1; cEp < epNum; i++) {
      late http.Response response;
      await Future.delayed(const Duration(milliseconds: ApiProvider.interval),
          () async {
        response = await http.get(nvurl.replace(queryParameters: {'p': "$i"}),
            headers: ApiProvider.headers); //needs on web
      });
      if (response.statusCode != 200) {
        throw HttpException("code:${response.statusCode}");
      }
      final document = html.parse(response.body); //html document
      final nc = document.getElementById('novel_color');
      if (nc == null) {
        // pages not found = (lastpage)
        log("html elements not found : id='novel_color'");
      } else if (nc.getElementsByClassName('novel_sublist').isNotEmpty) {
        //if pc mode
        final list = nc
            .getElementsByClassName('novel_sublist')
            .first
            .children
            .first
            .children;
        for (var l in list) {
          if (l.className == 'chapter') {
            if (chMaps.isNotEmpty) {
              //↓の「あとで」部分を実行
              chMaps.last[ChapterTable.firstEpOrder.name] = cEp - cEpInCh + 1;
              chMaps.last[ChapterTable.epNum.name] = cEpInCh;
              cEpInCh = 0; //count reset
            }
            chMaps.add({
              ChapterTable.novelId.name: nvId,
              ChapterTable.chOrder.name: chMaps.length + 1,
              ChapterTable.title.name: l.text.trim(),
              ChapterTable.description.name: null,
              ChapterTable.firstEpOrder.name: null, //あとで
              ChapterTable.epNum.name: null, //あとで
            });
          } else {
            cEp++;
            cEpInCh++;
            var aTagE = l.getElementsByTagName('a').first;
            var upEtext = l.getElementsByClassName('kaikou').first.text;
            var upStr = regTimestamp
                .allMatches(upEtext)
                .last
                .group(0); //upEtextのなかで最後にマッチした文字列
            epMaps.add({
              EpisodeTable.url.name:
                  nvurl.replace(path: aTagE.attributes['href']).toString(),
              EpisodeTable.novelId.name: nvId,
              EpisodeTable.chOrder.name: chMaps.length,
              EpisodeTable.epOrder.name: cEp,
              EpisodeTable.title.name: aTagE.text.trim(),
              EpisodeTable.epUpdate.name: upStr,
              EpisodeTable.viewed.name: null,
            });
          }
        }
      } else if (nc.getElementsByClassName('index_box').isNotEmpty) {
        // if phone mode
        final list = nc.getElementsByClassName('index_box').first.children;
        for (var l in list) {
          if (l.className == 'chapter_title') {
            if (chMaps.isNotEmpty) {
              //{あとで}を実行
              chMaps.last[ChapterTable.firstEpOrder.name] = cEp - cEpInCh + 1;
              chMaps.last[ChapterTable.epNum.name] = cEpInCh;
              cEpInCh = 0; //count reset
            }
            chMaps.add({
              ChapterTable.novelId.name: nvId,
              ChapterTable.chOrder.name: chMaps.length + 1,
              ChapterTable.title.name: l.text.trim(),
              ChapterTable.description.name: null,
              ChapterTable.firstEpOrder.name: null, //あとで
              ChapterTable.epNum.name: null, //あとで
            });
          } else {
            cEp++;
            cEpInCh++;
            var aTagE = l
                .getElementsByClassName('subtitle')
                .first
                .getElementsByTagName('a')
                .first; //<a>Elements
            var luCrassE = l.getElementsByClassName('long_update').first;
            var spanTagElist = luCrassE.getElementsByTagName('span');
            var upEtext = spanTagElist.isNotEmpty
                ? spanTagElist.first.attributes['title']
                : luCrassE.text; //updateText
            var upStr = regTimestamp.allMatches(upEtext!).last.group(0);
            epMaps.add({
              EpisodeTable.url.name:
                  nvurl.replace(path: aTagE.attributes['href']).toString(),
              EpisodeTable.novelId.name: nvId,
              EpisodeTable.chOrder.name: chMaps.length,
              EpisodeTable.epOrder.name: cEp,
              EpisodeTable.title.name: aTagE.text.trim(),
              EpisodeTable.epUpdate.name: upStr,
              EpisodeTable.viewed.name: null,
            });
          }
        }
      } else {
        //pageerror?
        throw HttpException(
            "can't get Element: ${nvurl.replace(queryParameters: {
              'p': "$i"
            })}");
      }
    }

    if (chMaps.isNotEmpty) {
      //
      chMaps.last[ChapterTable.firstEpOrder.name] = cEp - cEpInCh + 1;
      chMaps.last[ChapterTable.epNum.name] = cEpInCh;
    }

    // success
    return (chMaps, epMaps);
  }
}
