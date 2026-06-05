// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_output.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MeetingOutput _$MeetingOutputFromJson(Map<String, dynamic> json) =>
    _MeetingOutput(
      id: json['id'] as String,
      meetingId: json['meetingId'] as String,
      type: $enumDecode(_$OutputTypeEnumMap, json['type']),
      markdownContent: json['markdownContent'] as String,
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      modelVersion: json['modelVersion'] as String,
    );

Map<String, dynamic> _$MeetingOutputToJson(_MeetingOutput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'meetingId': instance.meetingId,
      'type': _$OutputTypeEnumMap[instance.type]!,
      'markdownContent': instance.markdownContent,
      'generatedAt': instance.generatedAt.toIso8601String(),
      'modelVersion': instance.modelVersion,
    };

const _$OutputTypeEnumMap = {
  OutputType.minutes: 'minutes',
  OutputType.notes: 'notes',
  OutputType.report: 'report',
  OutputType.actionItems: 'actionItems',
  OutputType.followUpEmail: 'followUpEmail',
  OutputType.decisionsLog: 'decisionsLog',
};
