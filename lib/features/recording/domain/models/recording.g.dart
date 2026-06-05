// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recording.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Recording _$RecordingFromJson(Map<String, dynamic> json) => _Recording(
  filePath: json['filePath'] as String,
  duration: const DurationConverter().fromJson(
    (json['duration'] as num).toInt(),
  ),
  startedAt: DateTime.parse(json['startedAt'] as String),
  fileSizeBytes: (json['fileSizeBytes'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$RecordingToJson(_Recording instance) =>
    <String, dynamic>{
      'filePath': instance.filePath,
      'duration': const DurationConverter().toJson(instance.duration),
      'startedAt': instance.startedAt.toIso8601String(),
      'fileSizeBytes': instance.fileSizeBytes,
    };
