// contract for starting, stopping, and managing audio recordings
import 'package:minito/features/recording/domain/models/recording.dart';

abstract class AudioRepository {
  // requests microphone permission if not already granted
  // returns true when permission is granted
  Future<bool> requestPermission();

  // starts recording to a new file. returns the output file path.
  // throw audioexception on failure eg. permission denied
  Future<String> startRecording();

  // stops the active recording, returns the output file path 
  // the final path, duration, file size
  Future<Recording> stopRecording();

  // pause the active recording(android); ios falls back to stop
  Future<void> pauseRecording();

  // resume a paused recording 
  Future<void> resumeRecording();

  // stream of elapsed seconds while a recording is in progress
  Stream<int> get elapsedSecondsStream;

  // whether the device microphone is currently recording
  bool get isRecording;

  // deletes the audio file at path from local storage
  Future<void> deleteRecording(String path);
}