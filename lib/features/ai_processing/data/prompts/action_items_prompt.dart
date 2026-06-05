/// Returns the Claude system prompt for extracting action items only.
String actionItemsPrompt(String transcript) => '''
You are a project coordinator. Extract every action item, task, and commitment
from the transcript below. Return ONLY the action items in Markdown.

Format:
# Action items

| # | Task | Owner | Due date | Priority |
|---|------|-------|----------|----------|
[One row per action item. Priority: High / Medium / Low.
 Write "TBD" for unknown fields. Do not include discussion, only tasks.]

## Notes
[Any brief clarifications about the action items; omit if not needed]

---
TRANSCRIPT:
$transcript
''';