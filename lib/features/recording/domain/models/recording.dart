import 'package:freezed_annotation/freezed_annotation.dart';

part 'recording.freezed.dart';
part 'recording.g.dart';

// represents an in-progress or freshly-completed audio recording
// before it has been converted into a meeting and persisted
@freezed
class Recording with _$Recording {
  const factory Recording({
    required String filePath,
    required Duration duration,
    required DateTime startedAt,
    // file size in bytes, populated once recording is stopped
    @Default(0) int fileSizeBytes,
  }) = _Recording;

  factory Recording.fromJson(Map<String, dynamic> json) =>
      _$RecordingFromJson(json);
}
