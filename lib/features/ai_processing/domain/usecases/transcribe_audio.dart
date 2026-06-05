// delegates audio transcription to Whisper via AIrepository
import 'package:minito/core/errors/failures.dart';
import 'package:minito/features/ai_processing/domain/ai_repository.dart';

class TranscribeAudio {
  const TranscribeAudio(this._repo);
  final AIRepository _repo;

  Future<({String transcript, Failure? failure})> call (String filePath) async {
    try {
      final text = await _repo.transcribeAudio(filePath);
      return (transcript: text, failure: null);
    } catch (e) {
      return (
        transcript: '', failure: ProcessingFailure('Transcription failed: ${e.toString()}')
      );
    }
  }
}