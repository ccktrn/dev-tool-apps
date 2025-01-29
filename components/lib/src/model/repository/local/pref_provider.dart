



import 'package:shared_preferences/shared_preferences.dart';

//  shared-preference provider
class PrefProvider {

  static late SharedPreferences _pref; 

  

  static Future<void> init() async{
    _pref = await SharedPreferences.getInstance();
  }



  // app state
  static bool get firstRun => _pref.getBool("firstRun") ?? true;
  static set firstRun (bool v) => _pref.setBool("firstRun",v);
  
  static int? get lastNvId => _pref.getInt("lastNvId");
  static set lastNvId (int? v) => v==null ? _pref.remove("lastNvId") : _pref.setInt("lastNvId",v) ;
  
  static int? get lastEpId => _pref.getInt("lastEpId");
  static set lastEpId (int? v) => v==null ? _pref.remove("lastEpId") : _pref.setInt("lastEpId",v) ;

  // theme conf
  static String get themeColor => _pref.getString("themeColor") ?? "purple";
  static set themeColor (String v) => _pref.setString("themeColor",v);
  
  static String get themeMode => _pref.getString("themeMode") ?? "system";
  static set themeMode (String v)=>_pref.setString("themeMode",v);
  //view conf
  static double get viewFontsize => _pref.getDouble("viewFontsize") ?? 0;
  static set viewFontsize (double v)=>_pref.setDouble("viewFontsize",v);
  
  static double get viewSpacing => _pref.getDouble("viewSpacing") ?? 1;
  static set viewSpacing (double v)=>_pref.setDouble("viewSpacing",v);
  // custom conf
  static String get defaultURL => _pref.getString("defaultURL") ?? "https://www.google.co.jp/";
  static set defaultURL (String v)=>_pref.setString("defaultURL",v);
  
  static List<String> get customButtons => _pref.getStringList("customButtons") ?? [];
  static set customButtons (List<String> v) => _pref.setStringList("customButtons",v);

}