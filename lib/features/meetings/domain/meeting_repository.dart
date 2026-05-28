// contract for persisting and retrieving meetings, transcripts, and outputs
import 'package:minito/features/meetings/domain/models/meeting.dart';
import 'package:minito/features/meetings/domain/models/meeting_output.dart';
import 'package:minito/features/meetings/domain/models/transcript.dart';

abstract class MeetingRepository {
  // stream of all meetings, ordered by meeting.createdat descending
  Stream<List<Meeting>> watchMeeting();

  // returns a single meeting by ID
  Future<Meeting?> getMeeting(String id);

  // inserts or replaces a meeting record
  Future<void> saveMeeting(Meeting meeting);

  // permanently deletes the meeting and all associated outputs
  Future<void> deleteMeeting(String id);

  // returns the transcript for meetingId, or null if not yet available
  Future<Transcript?> getTranscript(String meetingId);

  // Persists a transcript produced by whisper
  Future<void> saveTranscript(Transcript transcript);

  // returns all meetingoutputs for meetingid
  Future<List<MeetingOutput>> getOutputs(String meetingId);

  // persists a single AI-generated output document
  Future<void> saveOutput(MeetingOutput output);

  // updates the meetingstatus for the given meeting
  Future<void> updateStatus(
    String meetingId,
    MeetingStatus status, {
    String? errorMessage,
  });
}
