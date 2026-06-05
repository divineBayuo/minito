import 'package:freezed_annotation/freezed_annotation.dart';

part 'recording.freezed.dart';
part 'recording.g.dart';

class DurationConverter implements JsonConverter<Duration, int> {
  const DurationConverter();

  @override
  Duration fromJson(int json) => Duration(microseconds: json);

  @override
  int toJson(Duration object) => object.inMicroseconds;
}

@freezed
abstract class Recording with _$Recording {
  const factory Recording({
    required String filePath,
    @DurationConverter() required Duration duration,
    required DateTime startedAt,
    @Default(0) int fileSizeBytes,
  }) = _Recording;

  factory Recording.fromJson(Map<String, dynamic> json) =>
      _$RecordingFromJson(json);
}