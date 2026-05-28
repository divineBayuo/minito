import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:minito/features/meetings/domain/models/meeting.dart';
import 'package:minito/features/meetings/domain/models/meeting_output.dart';
import 'package:minito/features/meetings/domain/models/output_type.dart';
import 'package:minito/features/meetings/domain/models/transcript.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'meeting_local_datasource.g.dart';

// drift table definitions
class MeetingsTable extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get audioFilePath => text()();
  IntColumn get durationSeconds => integer()();
  TextColumn get status => text()(); // meetingstatus.name
  TextColumn get errorMessage => text().nullable()();
  TextColumn get tags =>
      text().withDefault(const Constant('[]'))(); // JSON array

  @override
  Set<Column> get primaryKey => {id};
}

class TranscriptsTable extends Table {
  TextColumn get id => text()();
  TextColumn get meetingId => text().references(MeetingsTable, #id)();
  TextColumn get fullText => text()();
  TextColumn get languageCode => text()();
  TextColumn get segmentsJson => text().withDefault(const Constant('[]'))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class MeetingOutputsTable extends Table {
  TextColumn get id => text()();
  TextColumn get meetingId => text().references(MeetingsTable, #id)();
  TextColumn get type => text()(); // OutputType.name
  TextColumn get markdownContent => text()();
  DateTimeColumn get generatedAt => dateTime()();
  TextColumn get modelVersion => text()();

  @override
  Set<Column> get primaryKey => {id};
}

// database
@DriftDatabase(tables: [MeetingsTable, TranscriptsTable, MeetingOutputsTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dir = await getApplicationDocumentsDirectory();
      final file = File(p.join(dir.path, 'minito.db'));
      return NativeDatabase.createInBackground(file);
    });
  }

  // meetings
  Stream<List<MeetingsTableData>> watchAllMeetings() => (select(
    meetingsTable,
  )..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).watch();

  Future<MeetingsTableData?> getMeetingById(String id) =>
      (select(meetingsTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<void> upsertMeeting(MeetingsTableCompanion entry) =>
      into(meetingsTable).insertOnConflictUpdate(entry);

  Future<void> deleteMeetingById(String id) =>
      (delete(meetingsTable)..where((t) => t.id.equals(id))).go();

  Future<void> updateMeetingStatus(
    String id,
    String status, {
    String? errorMessage,
  }) => (update(meetingsTable)..where((t) => t.id.equals(id))).write(
    MeetingsTableCompanion(
      status: Value(status),
      errorMessage: Value(errorMessage),
    ),
  );

  // Transcripts
  Future<TranscriptsTableData?> getTranscriptByMeetingId(String meetingId) =>
      (select(
        transcriptsTable,
      )..where((t) => t.meetingId.equals(meetingId))).getSingleOrNull();

  Future<void> upsertTranscript(TranscriptsTableCompanion entry) =>
      into(transcriptsTable).insertOnConflictUpdate(entry);

  // Outputs
  Future<List<MeetingOutputsTableData>> getOutputsByMeetingId(
    String meetingId,
  ) => (select(
    MeetingOutputsTable,
  )..where((t) => t.meetingId.equals(meetingId))).get();

  Future<void> upsertOutput(MeetingOutputsTableCompanion entry) =>
      into(MeetingOutputsTable).insertOnConflictUpdate(entry);
}

// mapping helpers
extension MeetingRowMapper on MeetingsTableData {
  Meeting toDomain() => Meeting(
    id: id,
    title: title,
    createdAt: createdAt,
    audioFilePath: audioFilePath,
    durationSeconds: durationSeconds,
    status: MeetingStatus.values.byName(status),
    errorMessage: errorMessage,
    tags: List<String>.from(jsonDecode(tags) as List),
  );
}

extension TranscriptRowMapper on TranscriptsTableData {
  Transcript toDomain() => Transcript(
    id: id,
    meetingId: meetingId,
    fullText: fullText,
    languageCode: languageCode,
    segments: const [],
    createdAt: createdAt,
  );
}

extension OutputRowMapper on MeetingOutputsTableData {
  MeetingOutput toDomain() => MeetingOutput(
    id: id,
    meetingId: meetingId,
    type: OutputType.values.byName(type),
    markdownContent: markdownContent,
    generatedAt: generatedAt,
    modelVersion: modelVersion,
  );
}
