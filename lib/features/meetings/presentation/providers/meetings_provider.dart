import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minito/features/meetings/data/meeting_local_datasource.dart';
import 'package:minito/features/meetings/data/meeting_repository_impl.dart';
import 'package:minito/features/meetings/domain/meeting_repository.dart';
import 'package:minito/features/meetings/domain/models/meeting.dart';
import 'package:minito/features/meetings/domain/models/meeting_output.dart';
import 'package:minito/features/meetings/domain/models/transcript.dart';
import 'package:minito/features/recording/domain/models/recording.dart';
import 'package:uuid/uuid.dart';

// ── Infrastructure providers ──────────────────────────────────────────────────

final appDatabaseProvider = Provider<AppDatabase>((_) => AppDatabase());

final meetingRepositoryProvider = Provider<MeetingRepository>(
  (ref) => MeetingRepositoryImpl(ref.watch(appDatabaseProvider)),
);

// ── Read providers ────────────────────────────────────────────────────────────

final meetingsStreamProvider = StreamProvider<List<Meeting>>(
  (ref) => ref.watch(meetingRepositoryProvider).watchMeeting(),
);

final meetingByIdProvider = FutureProvider.family<Meeting?, String>((
  ref,
  id,
) async {
  return ref.watch(meetingRepositoryProvider).getMeeting(id);
});

final meetingOutputsProvider =
    FutureProvider.family<List<MeetingOutput>, String>((ref, meetingId) async {
      return ref.watch(meetingRepositoryProvider).getOutputs(meetingId);
    });

final meetingTranscriptProvider = FutureProvider.family<Transcript?, String>((
  ref,
  meetingId,
) async {
  return ref.watch(meetingRepositoryProvider).getTranscript(meetingId);
});

// ── Mutations ─────────────────────────────────────────────────────────────────
// Uses Riverpod 2 Notifier (replaces deprecated StateNotifier).
// processingProvider is NOT imported here — instead we expose a callback
// so the caller (record_screen, upload_screen) can trigger processing
// after saving. This breaks the circular dependency:
//   meetings_provider → processing_provider → meeting_repository → meetings_provider

class MeetingsNotifier extends Notifier<void> {
  final _uuid = const Uuid();

  @override
  void build() {} // no initial state needed — this notifier is action-only

  MeetingRepository get _repo => ref.read(meetingRepositoryProvider);

  /// Saves a completed live recording as a new [Meeting] and returns it.
  /// The caller is responsible for triggering AI processing afterward.
  Future<Meeting> saveRecording(Recording recording) async {
    final meeting = Meeting(
      id: _uuid.v4(),
      title: _generateTitle(recording.startedAt),
      createdAt: recording.startedAt,
      audioFilePath: recording.filePath,
      durationSeconds: recording.duration.inSeconds,
    );
    await _repo.saveMeeting(meeting);
    return meeting;
  }

  /// Imports an existing audio file as a new [Meeting] and returns it.
  /// The caller is responsible for triggering AI processing afterward.
  Future<Meeting> importAudioFile(String filePath, String originalName) async {
    final file = File(filePath);
    final stat = await file.stat();
    final meeting = Meeting(
      id: _uuid.v4(),
      title: originalName.replaceAll(RegExp(r'\.[^.]+$'), ''),
      createdAt: stat.modified,
      audioFilePath: filePath,
      durationSeconds: 0,
    );
    await _repo.saveMeeting(meeting);
    return meeting;
  }

  Future<void> deleteMeeting(String id) => _repo.deleteMeeting(id);

  // Add to MeetingsNotifier:
  Future<void> deleteAllMeetings() => _repo.deleteAllMeetings();

  Future<void> renameMeeting(String id, String newTitle) async {
    final meeting = await _repo.getMeeting(id);
    if (meeting == null) return;
    await _repo.saveMeeting(meeting.copyWith(title: newTitle));
  }

  String _generateTitle(DateTime dt) {
    final date =
        '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
    final time =
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    return 'Meeting $date $time';
  }
}

final meetingsProvider = NotifierProvider<MeetingsNotifier, void>(
  MeetingsNotifier.new,
);
