import 'package:app_novelviewer/src/importer.dart';
import 'package:app_novelviewer/src/model/repository/local/storage_provider.dart';

Future<String?> getText(Episode ep) async {
  return StrageProvider.readText(Episode.epFilename(ep.novelId!, ep.id!));
}
