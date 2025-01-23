import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;//is web(not Native)

import 'package:path_provider/path_provider.dart';


class StrageProvider {
  static late String _localPath;//app local dir
  static late String _textDirPath; //epText dir 



  static Future<void> init ()async {
    if(kIsWeb){
      _localPath = "";//un use
    }else{
      final dir = await getApplicationDocumentsDirectory();
      _localPath = dir.path;
      _textDirPath = "$_localPath/epTexts";
      final textDir = Directory(_textDirPath);
      if(! await textDir.exists()){
        textDir.create();
      }
    }
  } 




  static Future<bool> saveText (String filename ,String contents) async {
    if(kIsWeb){ //web
      final localStorage = await SharedPreferences.getInstance();
      return localStorage.setString(filename, contents);

    }else{ //Native
      final file = File("$_textDirPath/$filename");
      await file.writeAsString(contents);
      return file.exists(); // true
    }
  }
  static Future<bool> deleteText (String filename) async {
    if(kIsWeb){ //web
      final localStorage = await SharedPreferences.getInstance();
      return localStorage.remove(filename);

    }else{ //Native
      final file = File("$_textDirPath/$filename");
      await file.delete();
      return !(await file.exists()); // true
    }
  }
  static Future<String?> readText (String filename) async {
    try{
      if(kIsWeb){ //web
        final localStorage = await SharedPreferences.getInstance();
        return localStorage.getString(filename);

      }else{ //Native
        final file = File("$_textDirPath/$filename");
        return file.readAsString();
      }
    }catch(e){
      return "$e";
    }
  }
}