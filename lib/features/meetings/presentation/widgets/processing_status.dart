// displays a linear progress indicator and status label
// reflecting where a  meeting is in the ai processing pipeline
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

    final (label, color, showProgress) = switch (status) {
      MeetingStatus.pending => ('Queued of processing', Colors.grey, false),
      MeetingStatus.transcribing => (
        'Transcribing audio...',
        Colors.blue,
        true,
      ),
      MeetingStatus.generating => (
        'Generating documents...',
        Colors.orange,
        true,
      ),
      MeetingStatus.failed => (
        errorMessage ?? 'Processing failed',
        Colors.red,
        false,
      ),
      MeetingStatus.completed => ('Done', Colors.green, false),
    };

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  status == MeetingStatus.failed
                      ? Icons.error_outline
                      : Icons.hourglass_top_rounded,
                  color: color,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(label, style: theme.textTheme.bodyMedium),
              ],
            ),
            if (showProgress) ...[
              const SizedBox(height: 12),
              LinearProgressIndicator(
                color: color,
                backgroundColor: color.withOpacity(0.12),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
