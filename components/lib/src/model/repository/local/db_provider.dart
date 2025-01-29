import 'dart:io';
import 'package:sample/src/model/importer.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sample/src/model/const/tables.dart';

//  Database provides
class DbProvider {
  static late Database _db;
  static const _dbName = "sample.db";
  static const _dbVersion = 1;

  static Future<String> getDbPath() async {
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
      return "web_$_dbName";
    } else if (Platform.isAndroid) {
      final documentsDirectoryPath = await getDatabasesPath();
      return join(documentsDirectoryPath, _dbName);
    } else if (Platform.isIOS) {
      final documentsDirectory = await getLibraryDirectory();
      return join(documentsDirectory.path, _dbName);
    } else {
      return ""; // サポート外
    }
  }

  // this opens the database (and creates it if it doesn't exist)
  static Future<void> init() async {
    final String path = await getDbPath();

    _db = await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  static Future _onCreate(Database db, int version) async {
    await Future.wait([for (Tables t in Tables.values) db.execute(_cmd(t))]);
  }

  static String _cmd(Tables t) {
    // UNOQUE(${EpisodeTable.novelId.name}, ${EpisodeTable.order.name})
    final columns = t.columns.entries
        .map((e) => "${e.key} ${e.value}")
        .join(",");
    final pkey = "PRIMARY KEY(${t.pkey})";
    return "CREATE TABLE ${t.tablename} ($columns,$pkey)";
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  static Future<int> insert(Tables t, Map<String, dynamic> data) async {
    return await _db.insert(t.tablename, data);
  }

  // All of the rows are returned as a list of maps, where each map is a key-value list of columns.
  //
  //---- if search  key1=v1 and key2={v2a or v2b}, sorted by key3,
  // queryAllRows(
  //   Table1 ,
  //   filter: {
  //      "key1": "v1",
  //      "key2": ["v2a","v2b"],
  //   },
  //   sort: "key3"
  // )
  static Future<List<Map<String, dynamic>>> queryAllRows(
    Tables t, {
    Map<String, dynamic>? filter,
    String? sort,
  }) async {
    String? statement = filter?.entries
        .map((e) {
          if (e.value is Iterable) {
            String inList = List.filled(e.value.length, '?').join(",");
            return '${e.key} in ($inList)';
          } else {
            return '${e.key} = ?';
          }
        })
        .join(' AND ');
    List<Object?>? args = () {
      if (filter == null) {
        return null;
      } else {
        List<Object?> res = [];
        for (var e in filter.entries) {
          if (e.value is Iterable) {
            res.addAll(e.value);
          } else {
            res.add(e.value);
          }
        }
        return res;
      }
    }();

    return await _db.query(
      t.tablename,
      where: statement,
      whereArgs: args,
      orderBy: sort,
    );
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  static Future<int> queryRowCount(Tables t) async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM ${t.tablename}');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  static Future<int> update(Tables t, Map<String, dynamic> row) async {
    return await _db.update(
      t.tablename,
      row,
      where: '${t.pkey} = ?',
      whereArgs: [row[t.pkey]],
    );
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  static Future<int> delete(Tables t, Map<String, dynamic> row) async {
    return await _db.delete(
      t.tablename,
      where: '${t.pkey} = ?',
      whereArgs: [row[t.pkey]],
    );
  }
}




// // in use :
// // ---------------------
//       class Test {
//         //create instance
//         final db = DbProvider(); 
//         //init
//         Test(){db.init();} 
//         //insert
//         void _onTap() async { 
//               Map<String, dynamic> data = {
//                   "title": "This is title !",
//                   "number": 0,
//                 }; 
//               final id = await db.insert("table",data);
//               print("inserted row(id:$id) on table.");//log
//         }
//       }