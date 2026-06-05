// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Meeting _$MeetingFromJson(Map<String, dynamic> json) => _Meeting(
  id: json['id'] as String,
  title: json['title'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  audioFilePath: json['audioFilePath'] as String,
  durationSeconds: (json['durationSeconds'] as num).toInt(),
  status:
      $enumDecodeNullable(_$MeetingStatusEnumMap, json['status']) ??
      MeetingStatus.pending,
  errorMessage: json['errorMessage'] as String?,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$MeetingToJson(_Meeting instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'createdAt': instance.createdAt.toIso8601String(),
  'audioFilePath': instance.audioFilePath,
  'durationSeconds': instance.durationSeconds,
  'status': _$MeetingStatusEnumMap[instance.status]!,
  'errorMessage': instance.errorMessage,
  'tags': instance.tags,
};

const _$MeetingStatusEnumMap = {
  MeetingStatus.pending: 'pending',
  MeetingStatus.transcribing: 'transcribing',
  MeetingStatus.generating: 'generating',
  MeetingStatus.completed: 'completed',
  MeetingStatus.failed: 'failed',
};
