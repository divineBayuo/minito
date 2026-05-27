// helpers for exporting, sharing, and managing output doc files
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

abstract class FileUtils {
  // return the directory used for exported doc
  // (minutes, reports, etc)
  static Future<Directory> getExportsDir() async {
    final docs = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(docs.path, 'exports'));
    if (!dir.existsSync()) await dir.create(recursive: true);
    return dir;
  }

  // writes content to a .txt file and opens the share sheet
  // filename should not include the extension
  static Future<void> shareAsText({
    required String content,
    required String fileName,
  }) async {
    final dir = await getExportsDir();
    final file = File(p.join(dir.path, '$fileName.txt'));
    await file.writeAsString(content);
    await Share.shareXFiles([XFile(file.path)], subject: fileName);
  }

  // writes content to a .md file and opens the share sheet
  static Future<void> shareAsMarkdown({
    required String content,
    required String fileName,
  }) async {
    final dir = await getExportsDir();
    final file = File(p.join(dir.path, '$fileName.md'));
    await file.writeAsString(content);
    await Share.shareXFiles([XFile(file.path)], subject: fileName);
  }

  // copies the content to a temp file and returns its path
  // useful for passing to platform-specific PDF generators
  static Future<String> writeTempFile({
    required String content,
    required String name,
    required String extension,
  }) async {
    final tmp = await getTemporaryDirectory();
    final file = File(p.join(tmp.path, '$name.$extension'));
    await file.writeAsString(content);
    return file.path;
  }

  // delete all files in the exports directory. called from settings
  static Future<void> clearExports() async {
    final dir = await getExportsDir();
    for (final entity in dir.listSync()) {
      if (entity is File) await entity.delete();
    }
  }
}
