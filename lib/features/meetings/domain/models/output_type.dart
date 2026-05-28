// all doc types that can be generated from a transcript by the AI pipeline
// adding a new type here is the only change needed in the domain layer
// a matching prompt file must be added in ai_processing/data/prompts

enum OutputType {
  minutes, notes, report, actionItems, followUpEmail, decisionsLog;

  // human-readable label shown in tabs and chips
  String get label => switch (this) {
    OutputType.minutes => 'Minutes',
    OutputType.notes => 'Notes',
    OutputType.report => 'Report',
    OutputType.actionItems => 'Action items',
    OutputType.followUpEmail => 'Follow-up email',
    OutputType.decisionsLog => 'Decisions log',
  };

  String get icon => switch (this) {
    OutputType.minutes => '📋',
    OutputType.notes => '📝',
    OutputType.report => '📊',
    OutputType.actionItems => '✅',
    OutputType.followUpEmail => '📧',
    OutputType.decisionsLog => '🗂️',
  };
}