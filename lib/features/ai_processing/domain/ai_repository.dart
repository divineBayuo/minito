// contract for both transcription (Whisper) and doc gen (Cluade)
import 'package:minito/features/meetings/domain/models/output_type.dart';

abstract class AIRepository {
  /// Transcribes the audio file at filepath using Whisper.
  /// Returns the full transcript text.
  /// Throws serverexception on API failure.
  Future<String> transcribeAudio(String filePath);

  // sends transcript to Claude and returns generated markdown
  // for the given outputtype
  Future<String> generateDocument({
    required String transcript,
    required OutputType outputType,
  });
}
