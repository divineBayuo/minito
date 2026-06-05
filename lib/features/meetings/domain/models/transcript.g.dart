// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transcript.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TranscriptSegment _$TranscriptSegmentFromJson(Map<String, dynamic> json) =>
    _TranscriptSegment(
      id: (json['id'] as num).toInt(),
      start: (json['start'] as num).toDouble(),
      end: (json['end'] as num).toDouble(),
      text: json['text'] as String,
      avgLogprob: (json['avgLogprob'] as num?)?.toDouble() ?? 1.0,
    );

Map<String, dynamic> _$TranscriptSegmentToJson(_TranscriptSegment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start': instance.start,
      'end': instance.end,
      'text': instance.text,
      'avgLogprob': instance.avgLogprob,
    };

_Transcript _$TranscriptFromJson(Map<String, dynamic> json) => _Transcript(
  id: json['id'] as String,
  meetingId: json['meetingId'] as String,
  fullText: json['fullText'] as String,
  languageCode: json['languageCode'] as String,
  segments:
      (json['segments'] as List<dynamic>?)
          ?.map((e) => TranscriptSegment.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$TranscriptToJson(_Transcript instance) =>
    <String, dynamic>{
      'id': instance.id,
      'meetingId': instance.meetingId,
      'fullText': instance.fullText,
      'languageCode': instance.languageCode,
      'segments': instance.segments,
      'createdAt': instance.createdAt.toIso8601String(),
    };
