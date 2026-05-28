import 'package:freezed_annotation/freezed_annotation.dart';

part 'transcript.freezed.dart';
part 'transcript.g.dart';

// a single timed word or phrase segment from Whisper's verbose JSON output
@freezed
class TranscriptSegment with _$TranscriptSegment {
  const factory TranscriptSegment({
    required int id,
    required double,
    start,
    required double end,
    required String text,
    // whisper confidence score 0.0 - 1.0
    @Default(1.0) double avgLogprob,
  }) = _TranscriptSegment;

  factory TranscriptSegment.fromJson(Map<String, dynamic> json) =>
      _$TranscriptSegmentFromJson(json);
}

// the full transcrirption result for a meeting
@freezed
class Transcript with _$Transcript {
  const factory Transcript({
    required String id,
    required String meetingId,
    required String fullText,
    required String languageCode,
    @Default([]) List<TranscriptSegment> segments,
    required DateTime createdAt,
  }) = _Transcript;

  factory Transcript.fromJson(Map<String, dynamic> json) =>
      _$TranscriptFromJson(json);
}
