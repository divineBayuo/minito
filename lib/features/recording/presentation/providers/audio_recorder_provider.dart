// infrastucture providers
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:minito/features/recording/data/audio_local_datasource.dart';
import 'package:minito/features/recording/data/audio_repository_impl.dart';
import 'package:minito/features/recording/domain/audio_repository.dart';
import 'package:minito/features/recording/domain/models/recording.dart';
import 'package:minito/features/recording/domain/usecases/start_recording.dart';
import 'package:minito/features/recording/domain/usecases/stop_recording.dart';

final audioDataSourceProvider = Provider<AudioLocalDatasource>(
  (_) => AudioLocalDatasource(),
);

final AudioRepositoryProvider = Provider<AudioRepository>(
  (ref) => AudioRepositoryImpl(ref.watch(audioDataSourceProvider)),
);

// recording state
enum RecordingStatus { idle, recording, paused, stopped }

class RecorderState {
  final RecordingStatus status;
  final int elapsedSeconds;
  final Recording? completedRecording;
  final String? error;

  const RecorderState({
    this.status = RecordingStatus.idle,
    this.elapsedSeconds = 0,
    this.completedRecording,
    this.error,
  });

  RecorderState copyWith({
    RecordingStatus? status,
    int? elapsedSeconds,
    Recording? completedRecording,
    String? error,
  }) => RecorderState(
    status: status ?? this.status,
    elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
    completedRecording: completedRecording ?? this.completedRecording,
    error: error,
  );

  bool get isActive =>
      status == RecordingStatus.recording || status == RecordingStatus.paused;
}

// manages the live recording session and exposes start/stop/pause actions
class AudioRecorderNotifier extends StateNotifier<RecorderState> {
  AudioRecorderNotifier(this._repo) : super(const RecorderState()) {
    _startUseCase = StartRecording(_repo);
    _stopUseCase = StopRecording(_repo);
  }

  final AudioRepository _repo;
  late final StartRecording _startUseCase;
  late final StopRecording _stopUseCase;
  StreamSubscription<int>? _elapsedSub;

  Future<void> start() async {
    final result = await _startUseCase();
    if (result.failure != null) {
      state = state.copyWith(error: result.failure!.message);
      return;
    }
    _elapsedSub = _repo.elapsedSecondsStream.listen(
      (s) => state = state.copyWith(elapsedSeconds: s),
    );
    state = state.copyWith(
      status: RecordingStatus.recording,
      elapsedSeconds: 0,
    );
  }

  Future<void> stop() async {
    await _elapsedSub?.cancel();
    final result = await _stopUseCase();
    if (result.failure != null) {
      state = state.copyWith(error: result.failure!.message);
      return;
    }
    state = state.copyWith(
      status: RecordingStatus.stopped,
      completedRecording: result.recording,
    );
  }

  Future<void> pause() async {
    await _repo.pauseRecording();
    state = state.copyWith(status: RecordingStatus.paused);
  }

  Future<void> resume() async {
    await _repo.resumeRecording();
    state = state.copyWith(status: RecordingStatus.recording);
  }

  void reset() {
    state = const RecorderState();
  }

  @override
  void dispose() {
    _elapsedSub?.cancel();
    super.dispose();
  }
}

final audioRecorderProvider =
    StateNotifierProvider<AudioRecorderNotifier, RecorderState>(
      (ref) => AudioRecorderNotifier(ref.watch(AudioRepositoryProvider)),
    );
