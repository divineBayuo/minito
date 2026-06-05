// concrete implementation of ai repo
// delegates all calls to airemotedatasource, keeping data source
// swappabale, e.g. replacing whisper with google speech later requires
// only a new datasource and a swap here, nothing else changes
import 'package:minito/features/ai_processing/data/ai_remote_datasource.dart';
import 'package:minito/features/ai_processing/domain/ai_repository.dart';
import 'package:minito/features/meetings/domain/models/output_type.dart';

class AiRepositoryImpl implements AIRepository {
  AiRepositoryImpl(this._dataSource);

  final AiRemoteDatasource _dataSource;

  @override
  Future<String> transcribeAudio(String filePath) =>
      _dataSource.transcribeAudio(filePath);

  @override
  Future<String> generateDocument({
    required String transcript,
    required OutputType outputType,
  }) => _dataSource.generateDocument(
    transcript: transcript,
    outputType: outputType,
  );
}
