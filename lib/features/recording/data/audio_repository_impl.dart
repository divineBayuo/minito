import 'package:minito/features/recording/data/audio_local_datasource.dart';
import 'package:minito/features/recording/domain/audio_repository.dart';
import 'package:minito/features/recording/domain/models/recording.dart';

class AudioRepositoryImpl implements AudioRepository {
  AudioRepositoryImpl(this._dataSource);
  final AudioLocalDatasource _dataSource;

  @override
  Future<bool> requestPermission() => _dataSource.hasPermission();

  @override
  Future<String> startRecording() => _dataSource.startRecording();

  @override
  Future<Recording> stopRecording() => _dataSource.stopRecording();

  @override
  Future<void> pauseRecording() => _dataSource.pauseRecording();

  @override
  Future<void> resumeRecording() => _dataSource.resumeRecording();

  @override
  Stream<int> get elapsedSecondsStream => _dataSource.elapsedSecondsStream;

  @override
  bool get isRecording => _dataSource.isRecording;

  @override
  Future<void> deleteRecording(String path) =>
      // delegate to the audioutils helper so deletion logic is centralised
      Future(() => throw UnimplementedError('deleteRecording'));
}
