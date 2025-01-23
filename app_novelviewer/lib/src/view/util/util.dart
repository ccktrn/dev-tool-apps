
import 'package:intl/intl.dart';

//formatter
class FormatText {
  static String dt2str(DateTime? dt)=> dt!=null ? DateFormat("yyyy/MM/dd").format(dt):"y/M/d";
}