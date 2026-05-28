// wraps the record package into a clean API consumed by audiorepositoty impl
import 'dart:async';
import 'dart:io';

import 'package:minito/core/errors/exceptions.dart';
import 'package:minito/core/utils/audio_utils.dart';
import 'package:minito/features/recording/domain/models/recording.dart';
import 'package:record/record.dart';

class AudioLocalDatasource {
  AudioLocalDatasource() : _recorder = AudioRecorder();

  final AudioRecorder _recorder;
  String? _currentPath;
  DateTime? _startedAt;
  final _elapsedController = StreamController<int>.broadcast();
  Timer? _timer;

  Stream<int> get elapsedSecondsStream => _elapsedController.stream;

  bool get isRecording => _recorder.isRecording() as bool;

  Future<bool> hasPermission() async => _recorder.hasPermission();

  Future<String> startRecording() async {
    if (await _recorder.isRecording()) {
      throw const AudioException(
        message: 'A recording is already in progress.',
      );
    }

    final path = await AudioUtils.generateRecordingPath();
    _currentPath = path;
    _startedAt = DateTime.now();

    await _recorder.start(
      const RecordConfig(
        encoder: AudioEncoder.aacLc,
        bitRate: 128000,
        sampleRate: 44100,
      ),
      path: path,
    );

    // tick elapsed-seconds stream every second
    _timer?.cancel();
    int elapsed = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      elapsed++;
      _elapsedController.add(elapsed);
    });
    return path;
  }

  Future<Recording> stopRecording() async {
    _timer?.cancel();
    await _recorder.stop();

    final path = _currentPath;
    final startedAt = _startedAt;
    if (path == null || startedAt == null) {
      throw const AudioException(message: 'No active recording to stop.');
    }

    final duration = DateTime.now().difference(startedAt);
    final size = File(path).existsSync() ? File(path).lengthSync() : 0;

    _currentPath = null;
    _startedAt = null;

    return Recording(
      filePath: path,
      duration: duration,
      startedAt: startedAt,
      fileSizeBytes: size,
    );
  }

  Future<void> pauseRecording() => _recorder.pause();
  Future<void> resumeRecording() => _recorder.resume();

  Future<void> dispose() async {
    _timer?.cancel();
    await _elapsedController.close();
    await _recorder.dispose();
  }
}
