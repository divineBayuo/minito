// no api constants

abstract class AppConstants {
  // app identity
  static const appName = 'Minito';

  // audio recording
  // max single recording length before auto-stop
  static const maxRecordingDurationSeconds = 7200; // 2h
  static const audioFileExtension = '.m4a';
  static const audioSubDir = 'recordings'; // inside app doc dir

  // AI Processing
  // max transcript chars sent to Claude in single prompt
  // very long meetings chunked before generation

  // hive boxes
  static const prefsBoxName = 'prefs';
  static const settingsBoxName = 'settings';

  // hive pref keys
  static const prefDefaultOutputTypes = 'default_output_types';
  static const prefThemeMode = 'theme_mode';
  static const prefLanguageCode = 'language_code';

  //sq-lite / drift
  static const dbFileName = 'minito.db';

  // pagination
  static const meetingsPageSize = 20;
}
