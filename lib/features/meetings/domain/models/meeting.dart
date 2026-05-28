import 'package:freezed_annotation/freezed_annotation.dart';

part 'meeting.freezed.dart';
part 'meeting.g.dart';

// processing status of the ai pipeline for this meeting
enum MeetingStatus {
  // audio exists but has not been sent for processing
  pending,
  // whisper currently transcribing audio
  transcribing,
  // claude generating docs from transcript
  generating,
  // all requested outputs have been produced successfully
  completed,
  // at least one pipeline step failed
  failed,
}

// the central domain object representing one recorded/uploaded meeting
@freezed
class Meeting with _$Meeting {
  const factory Meeting({
    required String id,
    required String title,
    required DateTime createdAt,

    // local filesystem path to the .m4a or uploaded file
    required String audioFilePath,

    // Duration of the audio file in seconds
    required int durationSeconds,

    // current ai processing state
    @Default(MeetingStatus.pending) MeetingStatus status,

    // error message if status is meetingstatus.failed
    String? errorMessage,

    // user-supplied tags e.g. q2, product, weekly
    @Default([]) List<String> tags,
  }) = _Meeting;

  factory Meeting.fromJson(Map<String, dynamic> json) =>
      _$MeetingFromJson(json);
}
