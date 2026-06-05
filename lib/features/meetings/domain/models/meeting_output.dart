import 'package:freezed_annotation/freezed_annotation.dart';

import 'output_type.dart';

part 'meeting_output.freezed.dart';
part 'meeting_output.g.dart';

@freezed
abstract class MeetingOutput with _$MeetingOutput {
  const factory MeetingOutput({
    required String id,
    required String meetingId,
    required OutputType type,
    required String markdownContent,
    required DateTime generatedAt,
    required String modelVersion,
  }) = _MeetingOutput;

  factory MeetingOutput.fromJson(Map<String, dynamic> json) =>
      _$MeetingOutputFromJson(json);
}