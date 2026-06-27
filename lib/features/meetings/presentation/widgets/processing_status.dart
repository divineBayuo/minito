import 'package:flutter/material.dart';
import 'package:minito/features/meetings/domain/models/meeting.dart';

class ProcessingStatus extends StatelessWidget {
  const ProcessingStatus({super.key, required this.status, this.errorMessage});

  final MeetingStatus status;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (status == MeetingStatus.completed) return const SizedBox.shrink();

    final (label, color, icon, showProgress) = switch (status) {
      MeetingStatus.pending => (
        'Queued for processing',
        theme.colorScheme.onSurfaceVariant,
        Icons.hourglass_empty_rounded,
        false,
      ),
      MeetingStatus.transcribing => (
        'Transcribing audio...',
        theme.colorScheme.primary,
        Icons.graphic_eq_rounded,
        true,
      ),
      MeetingStatus.generating => (
        'Generating documents...',
        theme.colorScheme.primary,
        Icons.auto_awesome_outlined,
        true,
      ),
      MeetingStatus.failed => (
        // strip the verbose Dio/HTTP boilerplate from the message
        _cleanError(errorMessage),
        theme.colorScheme.error,
        Icons.error_outline_rounded,
        false,
      ),
      MeetingStatus.completed => (
        'Done',
        theme.colorScheme.primary,
        Icons.check_circle_outline_rounded,
        false,
      ),
    };

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.20), width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: color, size: 18),
                const SizedBox(width: 10),
                // ✅ Expanded prevents horizontal overflow
                Expanded(
                  child: Text(
                    label,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: color,
                      fontFamily: 'Bricolage Grotesque',
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
            if (showProgress) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  color: color,
                  backgroundColor: color.withOpacity(0.15),
                  minHeight: 3,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // trims the verbose ServerException / Dio boilerplate down to something
  // a user can actually read
  String _cleanError(String? raw) {
    if (raw == null || raw.isEmpty) return 'Processing failed.';

    // pull out just the quoted message if present e.g. "Cl..." from the 401
    final quoted = RegExp(r'"([^"]{10,})"').firstMatch(raw)?.group(1);
    if (quoted != null) return quoted;

    // truncate anything excessively long
    final cleaned = raw
        .replaceAll(RegExp(r'ServerException\(\d+\):\s*'), '')
        .replaceAll(RegExp(r'https?://\S+'), '')
        .trim();

    return cleaned.length > 180 ? '${cleaned.substring(0, 180)}…' : cleaned;
  }
}
