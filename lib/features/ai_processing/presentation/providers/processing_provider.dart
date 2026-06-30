import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minito/core/constants/api_constants.dart';
import 'package:minito/features/ai_processing/data/ai_remote_datasource.dart';
import 'package:minito/features/ai_processing/data/ai_repository_impl.dart';
import 'package:minito/features/ai_processing/domain/ai_repository.dart';
import 'package:minito/features/ai_processing/domain/usecases/generate_documents.dart';
import 'package:minito/features/ai_processing/domain/usecases/transcribe_audio.dart';
import 'package:minito/features/meetings/domain/meeting_repository.dart';
import 'package:minito/features/meetings/domain/models/meeting.dart';
import 'package:minito/features/meetings/domain/models/meeting_output.dart';
import 'package:minito/features/meetings/domain/models/output_type.dart';
import 'package:minito/features/meetings/domain/models/transcript.dart';
import 'package:minito/features/meetings/presentation/providers/meetings_provider.dart';
import 'package:uuid/uuid.dart';

// infrastructure provider
final aiDataSourceProvider = Provider<AiRemoteDatasource>(
  (_) => AiRemoteDatasource(),
);

final aiRepositoryProvider = Provider<AIRepository>(
  (ref) => AiRepositoryImpl(ref.watch(aiDataSourceProvider)),
);

// processing state
class ProcessingState {
  final Set<String> activeJobs;
  final Map<String, String> failedJobs;

  const ProcessingState({
    this.activeJobs = const {},
    this.failedJobs = const {},
  });

  bool isProcessing(String meetingId) => activeJobs.contains(meetingId);

  ProcessingState copyWith({
    Set<String>? activeJobs,
    Map<String, String>? failedJobs,
  }) => ProcessingState(
    activeJobs: activeJobs ?? this.activeJobs,
    failedJobs: failedJobs ?? this.failedJobs,
  );
}

// notifier
// uses Riverpod 2 Notifier
// reads meetingRepositoryProvider directly via ref
// because we import meetings_prover only for provider

class ProcessingNotifier extends Notifier<ProcessingState> {
  final _uuid = const Uuid();

  static const _defaultOutputTypes = [
    OutputType.minutes,
    OutputType.notes,
    OutputType.actionItems,
  ];

  @override
  ProcessingState build() => const ProcessingState();

  MeetingRepository get _meetingRepo => ref.read(meetingRepositoryProvider);

  AIRepository get _aiRepo => ref.read(aiRepositoryProvider);

  Future<void> enqueue(String meetingId) async {
    if (state.isProcessing(meetingId)) return;

    state = state.copyWith(activeJobs: {...state.activeJobs, meetingId});

    try {
      await _runPipeline(meetingId);
    } finally {
      state = state.copyWith(
        activeJobs: Set.from(state.activeJobs)..remove(meetingId),
      );
    }
  }

  Future<void> _runPipeline(String meetingId) async {
    final meeting = await _meetingRepo.getMeeting(meetingId);
    if (meeting == null) return;

    // step 1 - transcribe

    await _meetingRepo.updateStatus(meetingId, MeetingStatus.transcribing);

    final transcribeResult = await TranscribeAudio(_aiRepo)(
      meeting.audioFilePath,
    );

    if (transcribeResult.failure != null) {
      await _meetingRepo.updateStatus(
        meetingId,
        MeetingStatus.failed,
        errorMessage: transcribeResult.failure!.message,
      );
      state = state.copyWith(
        failedJobs: {
          ...state.failedJobs,
          meetingId: transcribeResult.failure!.message,
        },
      );
      return;
    }

    await _meetingRepo.saveTranscript(
      Transcript(
        id: _uuid.v4(),
        meetingId: meetingId,
        fullText: transcribeResult.transcript,
        languageCode: 'en',
        createdAt: DateTime.now(),
      ),
    );

    // step 2 - generate docs
    await _meetingRepo.updateStatus(meetingId, MeetingStatus.generating);

    final generateResult = await GenerateDocuments(_aiRepo)(
      transcript: transcribeResult.transcript,
      outputTypes: _defaultOutputTypes,
    );

    for (final doc in generateResult.outputs) {
      await _meetingRepo.saveOutput(
        MeetingOutput(
          id: _uuid.v4(),
          meetingId: meetingId,
          type: doc.type,
          markdownContent: doc.markdown,
          generatedAt: DateTime.now(),
          //modelVersion: 'claude-sonnet-4-20250514',
          modelVersion: ApiConstants.geminiModel,
        ),
      );
    }

    // step 3 - final status
    if (generateResult.errors.isNotEmpty && generateResult.outputs.isEmpty) {
      final msg = generateResult.errors
          .map((e) => e.failure.message)
          .join('; ');
      await _meetingRepo.updateStatus(
        meetingId,
        MeetingStatus.failed,
        errorMessage: msg,
      );
      state = state.copyWith(failedJobs: {...state.failedJobs, meetingId: msg});
    } else {
      await _meetingRepo.updateStatus(meetingId, MeetingStatus.completed);
    }
  }
}

final processingProvider =
    NotifierProvider<ProcessingNotifier, ProcessingState>(
      ProcessingNotifier.new,
    );
