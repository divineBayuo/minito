// request mic permission if needed then start new recording
// return the file path of the new recording or an audiofailure
import 'package:minito/core/errors/failures.dart';
import 'package:minito/features/recording/domain/audio_repository.dart';

class StartRecording {
  const StartRecording(this._repo);
  final AudioRepository _repo;

  Future<({String filePath, Failure? failure})> call() async {
    try {
      final granted = await _repo.requestPermission();
      if (!granted) {
        return (
          filePath: '',
          failure: const AudioFailure('Microphone permission denied'),
        );
      }
      final path = await _repo.startRecording();
      return (filePath: path, failure: null);
    } catch (e) {
      return (filePath: '', failure: AudioFailure(e.toString()));
    }
  }
}
