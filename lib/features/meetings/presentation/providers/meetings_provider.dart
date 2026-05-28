import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:minito/features/meetings/data/meeting_local_datasource.dart';
import 'package:minito/features/meetings/data/meeting_repository_impl.dart';
import 'package:minito/features/meetings/domain/meeting_repository.dart';
import 'package:minito/features/meetings/domain/models/meeting.dart';
import 'package:minito/features/meetings/domain/models/meeting_output.dart';
import 'package:minito/features/meetings/domain/models/transcript.dart';
import 'package:minito/features/recording/domain/models/recording.dart';
import 'package:uuid/uuid.dart';

// infrastructure providers
final appDatabaseProvider = Provider<AppDatabase>((_) => AppDatabase());

final meetingRepositoryProvider = Provider<MeetingRepository>(
  (ref) => MeetingRepositoryImpl(ref.watch(appDatabaseProvider)),
);

// meeting list
// stream of all meetings, newest first
final meetingsStreamProvider = StreamProvider<List<Meeting>>(
  (ref) => ref.watch(meetingRepositoryProvider).watchMeeting(),
);

// single meeting
final meetingByIdProvider = FutureProvider.family<Meeting?, String>((
  ref,
  id,
) async {
  return ref.watch(meetingRepositoryProvider).getMeeting(id);
});

// all outputs (minutes, notes, ...) for a single meeting
final meetingOutputsProvider =
    FutureProvider.family<List<MeetingOutput>, String>((ref, meetingId) async {
      return ref.watch(meetingRepositoryProvider).getOutputs(meetingId);
    });

// Transcript for a single meeting
final meetingTranscriptProvider = FutureProvider.family<Transcript?, String>((
  ref,
  meetingId,
) async {
  return ref.watch(meetingRepositoryProvider).getTranscript(meetingId);
});

// mutations
// exposes save/import/delete actions
class MeetingsNotifier extends StateNotifier<void> {
  MeetingsNotifier(this._repo, this._ref) : super(null);

  final MeetingRepository _repo;
  final Ref _ref;
  final _uuid = const Uuid();

  // called after a live recording
  // creates the meeting record and kicks off ai processing
  Future<Meeting> saveRecording(Recording recording) async {
    final meeting = Meeting(
      id: _uuid.v4(),
      title: _generateTitle(recording.startedAt),
      createdAt: recording.startedAt,
      audioFilePath: recording.filePath,
      durationSeconds: recording.duration.inSeconds,
    );
    await _repo.saveMeeting(meeting);
    _ref.read(processingProvider.notifier).enqueue(meeting.id);
    return meeting;
  }

  // called when the user picks existing file via upload screen
  Future<Meeting> importAudioFile(String filePath, String orginalName) async {
    final file = File(filePath);
    final stat = await file.stat();
    final duration = Duration.zero; // duration unknown for imported files
    final meeting = Meeting(
      id: _uuid.v4(),
      title: originalName.replaceAll(RegExp(r'\.[^.]+$'), ''),
      createdAt: stat.modified,
      audioFilePath: filePath,
      durationSeconds: duration.inSeconds,
    );
    await _repo.saveMeeting(meeting);
    _ref.read(processingProvider.notifier).enqueue(meeting.id);
    return meeting;
  }

  Future<void> deleteMeeting(String id) => _repo.deleteMeeting(id);

  String _generateTitle(DateTime dt) {
    final date =
        '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
    final time =
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    return 'Meeting $date $time';
  }
}

final meetingsProvider = StateNotifierProvider<MeetingsNotifier, void>(
  (ref) => MeetingsNotifier(ref.watch(meetingRepositoryProvider), ref),
);
