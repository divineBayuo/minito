// helpers for audio file naming and directory management
import 'dart:io';

import 'package:minito/core/constants/app_constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// helpers for audio file naming and directory management
abstract class AudioUtils {
  // returns (creating if needed) the directory
  // where recordings are stored
  static Future<Directory> getRecordingsDir() async {
    final docs = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(docs.path, AppConstants.audioSubDir));
    if (!dir.existsSync()) await dir.create(recursive: true);
    return dir;
  }

  // generate unique file path for new recording
  // format: <documents>/recordings/<timestamp>.m4a
  static Future<String> generateRecordingPath() async {
    final dir = await getRecordingsDir();
    final name =
        '${DateTime.now().millisecondsSinceEpoch}${AppConstants.audioFileExtension}';
    return p.join(dir.path, name);
  }

  // returns file size in megabytes, rounded to 1dp
  static double fileSizeMb(String filePath) {
    final file = File(filePath);
    if (!file.existsSync()) return 0;
    return file.lengthSync() / (1024 * 1024);
  }

  // deletes an audio file, silent if already missing
  static Future<void> deleteRecording(String filePath) async {
    final file = File(filePath);
    if (file.existsSync()) await file.delete();
  }

  // returns true when the file at the path exists and is not empty
  static bool isValidAudioFile(String path) {
    final file = File(path);
    return file.existsSync() && file.lengthSync() > 0;
  }

  // supported upload extensions
  static const List<String> allowedUploadExtensions = [
    'm4a',
    'mp3',
    'wav',
    'aac',
    'ogg',
  ];

  static bool isAllowedExtension(String path) {
    final ext = p.extension(path).replaceFirst('.', '').toLowerCase();
    return allowedUploadExtensions.contains(ext);
  }
}
