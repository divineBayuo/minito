// stops the active recording and returns the completed recording
import 'package:minito/core/errors/failures.dart';
import 'package:minito/features/recording/domain/audio_repository.dart';
import 'package:minito/features/recording/domain/models/recording.dart';

class StopRecording {
  const StopRecording(this._repo);
  final AudioRepository _repo;

  Future<({Recording? recording, Failure? failure})> call() async {
    try {
      final recording = await _repo.stopRecording();
      return (recording: recording, failure: null);
    } catch (e) {
      return (recording: null, failure: AudioFailure(e.toString()));
    }
  }
}
