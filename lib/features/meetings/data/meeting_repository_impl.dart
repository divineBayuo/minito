import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:minito/features/meetings/data/meeting_local_datasource.dart';
import 'package:minito/features/meetings/domain/meeting_repository.dart';
import 'package:minito/features/meetings/domain/models/meeting.dart';
import 'package:minito/features/meetings/domain/models/meeting_output.dart';
import 'package:minito/features/meetings/domain/models/transcript.dart';
import 'package:uuid/uuid.dart';

class MeetingRepositoryImpl implements MeetingRepository {
  MeetingRepositoryImpl(this._db);
  final AppDatabase _db;
  final _uuid = const Uuid();

  @override
  Stream<List<Meeting>> watchMeetings() => _db.watchAllMeetings().map(
    (rows) => rows.map((r) => r.toDomain()).toList(),
  );

  @override
  Future<Meeting?> getMeeting(String id) async {
    final row = await _db.getMeetingById(id);
    return row?.toDomain();
  }

  @override
  Future<void> saveMeeting(Meeting meeting) => _db.upsertMeeting(
    MeetingsTableCompanion(
      id: Value(meeting.id),
      title: Value(meeting.title),
      createdAt: Value(meeting.createdAt),
      audioFilePath: Value(meeting.audioFilePath),
      durationSeconds: Value(meeting.durationSeconds),
      status: Value(meeting.status.name),
      errorMessage: Value(meeting.errorMessage),
      tags: Value(jsonEncode(meeting.tags)),
    ),
  );

  @override
  Future<void> deleteMeeting(String id) => _db.deleteMeetingById(id);

  @override
  Future<Transcript?> getTranscript(String meetingId) async {
    final row = await _db.getTranscriptByMeetingId(meetingId);
    return row?.toDomain();
  }

  @override
  Future<void> saveTranscript(Transcript transcript) => _db.upsertTranscript(
    TranscriptsTableCompanion(
      id: Value(transcript.id),
      meetingId: Value(transcript.meetingId),
      fullText: Value(transcript.fullText),
      languageCode: Value(transcript.languageCode),
      createdAt: Value(transcript.createdAt),
    ),
  );

  @override
  Future<List<MeetingOutput>> getOutputs(String meetingId) async {
    final rows = await _db.getOutputsByMeetingId(meetingId);
    return rows.map((r) => r.toDomain()).toList();
  }

  @override
  Future<void> saveOutput(MeetingOutput output) => _db.upsertOutput(
    MeetingOutputsTableCompanion(
      id: Value(output.id),
      meetingId: Value(output.meetingId),
      type: Value(output.type.name),
      markdownContent: Value(output.markdownContent),
      generatedAt: Value(output.generatedAt),
      modelVersion: Value(output.modelVersion),
    ),
  );

  @override
  Future<void> updateStatus(
    String meetingId,
    MeetingStatus status, {
    String? errorMessage,
  }) => _db.updateMeetingStatus(
    meetingId,
    status.name,
    errorMessage: errorMessage,
  );
}
