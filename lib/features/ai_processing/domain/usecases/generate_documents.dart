import 'package:minito/core/errors/failures.dart';
import 'package:minito/features/meetings/domain/models/output_type.dart';
import '../ai_repository.dart';

typedef GeneratedDoc = ({OutputType type, String markdown});

/// Calls Claude once per requested [OutputType] and returns all results.
/// Partial successes are returned; individual failures are collected separately.
class GenerateDocuments {
  const GenerateDocuments(this._repo);
  final AIRepository _repo;

  Future<({
    List<GeneratedDoc> outputs,
    List<({OutputType type, Failure failure})> errors,
  })> call({
    required String transcript,
    required List<OutputType> outputTypes,
  }) async {
    final outputs = <GeneratedDoc>[];
    final errors = <({OutputType type, Failure failure})>[];

    for (final type in outputTypes) {
      try {
        final markdown = await _repo.generateDocument(
          transcript: transcript,
          outputType: type,
        );
        outputs.add((type: type, markdown: markdown));
      } catch (e) {
        errors.add((
          type: type,
          failure: ProcessingFailure('Failed to generate ${type.label}: $e'),
        ));
      }
    }

    return (outputs: outputs, errors: errors);
  }
}