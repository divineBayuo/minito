import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:minito/features/meetings/domain/models/meeting.dart';
import 'package:minito/features/meetings/domain/models/meeting_output.dart';
import 'package:minito/features/meetings/domain/models/output_type.dart';
import 'package:minito/features/meetings/domain/models/transcript.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'meeting_local_datasource.g.dart';

// ── Table definitions ─────────────────────────────────────────────────────────
// Rule: name tables in plural (Meetings), Drift generates singular data class
// (MeetingEntry) and companion (MeetingsCompanion). No .references() — we
// enforce relations in the repository layer instead.

class MeetingEntries extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get audioFilePath => text()();
  IntColumn get durationSeconds => integer()();
  TextColumn get status => text()();
  TextColumn get errorMessage => text().nullable()();
  TextColumn get tags => text().withDefault(const Constant('[]'))();

  @override
  Set<Column> get primaryKey => {id};
}

class TranscriptEntries extends Table {
  TextColumn get id => text()();
  TextColumn get meetingId => text()(); // FK enforced in repo, not here
  TextColumn get fullText => text()();
  TextColumn get languageCode => text()();
  TextColumn get segmentsJson => text().withDefault(const Constant('[]'))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class MeetingOutputEntries extends Table {
  TextColumn get id => text()();
  TextColumn get meetingId => text()(); // FK enforced in repo, not here
  TextColumn get type => text()();
  TextColumn get markdownContent => text()();
  DateTimeColumn get generatedAt => dateTime()();
  TextColumn get modelVersion => text()();

  @override
  Set<Column> get primaryKey => {id};
}

// ── Database ──────────────────────────────────────────────────────────────────

@DriftDatabase(
  tables: [MeetingEntries, TranscriptEntries, MeetingOutputEntries],
)
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

  // ── Meetings ────────────────────────────────────────────────────────────────

  Stream<List<MeetingEntry>> watchAllMeetings() => (select(
    meetingEntries,
  )..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).watch();

  Future<MeetingEntry?> getMeetingById(String id) =>
      (select(meetingEntries)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<void> upsertMeeting(MeetingEntriesCompanion entry) =>
      into(meetingEntries).insertOnConflictUpdate(entry);

  Future<void> deleteMeetingById(String id) =>
      (delete(meetingEntries)..where((t) => t.id.equals(id))).go();

  // Add to AppDatabase in meeting_local_datasource.dart
  Future<List<MeetingEntry>> getAllMeetings() => select(meetingEntries).get();

  Future<void> updateMeetingStatus(
    String id,
    String status, {
    String? errorMessage,
  }) => (update(meetingEntries)..where((t) => t.id.equals(id))).write(
    MeetingEntriesCompanion(
      status: Value(status),
      errorMessage: Value(errorMessage),
    ),
  );

  // ── Transcripts ─────────────────────────────────────────────────────────────

  Future<TranscriptEntry?> getTranscriptByMeetingId(String meetingId) =>
      (select(
        transcriptEntries,
      )..where((t) => t.meetingId.equals(meetingId))).getSingleOrNull();

  Future<void> upsertTranscript(TranscriptEntriesCompanion entry) =>
      into(transcriptEntries).insertOnConflictUpdate(entry);

  // ── Outputs ─────────────────────────────────────────────────────────────────

  Future<List<MeetingOutputEntry>> getOutputsByMeetingId(String meetingId) =>
      (select(
        meetingOutputEntries,
      )..where((t) => t.meetingId.equals(meetingId))).get();

  Future<void> upsertOutput(MeetingOutputEntriesCompanion entry) =>
      into(meetingOutputEntries).insertOnConflictUpdate(entry);
}

// ── Mapping extensions ────────────────────────────────────────────────────────
// These convert Drift-generated row objects into your domain models.

extension MeetingRowMapper on MeetingEntry {
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

extension TranscriptRowMapper on TranscriptEntry {
  Transcript toDomain() => Transcript(
    id: id,
    meetingId: meetingId,
    fullText: fullText,
    languageCode: languageCode,
    segments: const [],
    createdAt: createdAt,
  );
}

extension OutputRowMapper on MeetingOutputEntry {
  MeetingOutput toDomain() => MeetingOutput(
    id: id,
    meetingId: meetingId,
    type: OutputType.values.byName(type),
    markdownContent: markdownContent,
    generatedAt: generatedAt,
    modelVersion: modelVersion,
  );
}
