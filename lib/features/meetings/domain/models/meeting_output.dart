import 'package:freezed_annotation/freezed_annotation.dart';
import 'output_type.dart';

part 'meeting_output.freezed.dart';
part 'meeting_output.g.dart';

// one ai-generated doc for a meeting
// the content is stored as markdown; th ui renders it via flutter_markdown
@freezed
class MeetingOutput with _$MeetingOutput {
  const factory MeetingOutput({
    required String id,
    required String meetingId,
    required OutputType type,
    // markdown content produced by claude
    required String markdownContent,
    required DateTime generatedAt,
    // which claude model version produced this output (for auditability)
    required String modelVersion,
  }) = _MeetingOutput;

  factory MeetingOutput.fromJson(Map<String, dynamic> json) =>
      _$MeetingOutputFromJson(json);
}
