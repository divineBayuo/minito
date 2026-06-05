import 'package:freezed_annotation/freezed_annotation.dart';

part 'transcript.freezed.dart';
part 'transcript.g.dart';

@freezed
abstract class TranscriptSegment with _$TranscriptSegment {
  const factory TranscriptSegment({
    required int id,
    required double start,
    required double end,
    required String text,
    @Default(1.0) double avgLogprob,
  }) = _TranscriptSegment;

  factory TranscriptSegment.fromJson(Map<String, dynamic> json) =>
      _$TranscriptSegmentFromJson(json);
}

@freezed
abstract class Transcript with _$Transcript {
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