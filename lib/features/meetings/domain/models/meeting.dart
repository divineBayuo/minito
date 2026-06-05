import 'package:freezed_annotation/freezed_annotation.dart';

part 'meeting.freezed.dart';
part 'meeting.g.dart';

// ── Enum must come AFTER all directives (imports + part statements) ──────────

enum MeetingStatus {
  pending,
  transcribing,
  generating,
  completed,
  failed,
}

@freezed
abstract class Meeting with _$Meeting {
  const factory Meeting({
    required String id,
    required String title,
    required DateTime createdAt,
    required String audioFilePath,
    required int durationSeconds,
    @Default(MeetingStatus.pending) MeetingStatus status,
    String? errorMessage,
    @Default([]) List<String> tags,
  }) = _Meeting;

  factory Meeting.fromJson(Map<String, dynamic> json) =>
      _$MeetingFromJson(json);
}