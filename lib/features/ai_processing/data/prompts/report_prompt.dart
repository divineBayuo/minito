/// Returns the Claude system prompt for generating an executive meeting report.
String reportPrompt(String transcript) => '''
You are a senior business analyst. Based on the meeting transcript, write a
structured executive report in Markdown.

Format:
# Executive Meeting Report

**Date:** [from transcript or "Unknown"]
**Purpose:** [one sentence describing the meeting purpose]

## Executive summary
[3–5 sentences covering the meeting's most important outcomes]

## Discussion highlights
### [Topic 1 title]
[Paragraph summary of the discussion and key viewpoints]

### [Topic 2 title]
[Continue for each major topic]

## Risk and issues identified
[Bullet list; omit section if none]

## Decisions and rationale
[Numbered list — decision followed by brief rationale]

## Recommended next steps
[Numbered priority list]

---
TRANSCRIPT:
$transcript
''';