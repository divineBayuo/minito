// compact card displayed in the meetings list on homescreen
import 'package:flutter/material.dart';
import 'package:minito/core/extensions/duration_ext.dart';
import 'package:minito/features/meetings/domain/models/meeting.dart';

class RecordingCard extends StatelessWidget {
  const RecordingCard({
    super.key,
    required this.meeting,
    required this.onTap,
    this.onDelete,
  });

  final Meeting meeting;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final duration = Duration(seconds: meeting.durationSeconds).toHumanLabel();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // status icon circle
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _statusColor(meeting.status).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _statusIcon(meeting.status),
                  color: _statusColor(meeting.status),
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),

              // Title and metadata
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meeting.title,
                      style: theme.textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$duration · ${_formatDate(meeting.createdAt)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (meeting.status != MeetingStatus.completed &&
                        meeting.status != MeetingStatus.pending)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          _statusLabel(meeting.status),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: _statusColor(meeting.status),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // overflow menu
              PopupMenuButton<String>(
                itemBuilder: (_) => [
                  const PopupMenuItem(value: 'delete', child: Text('Delete')),
                ],
                onSelected: (v) {
                  if (v == 'delete') onDelete?.call();
                },
                icon: Icon(
                  Icons.more_vert,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _statusColor(MeetingStatus s) => switch (s) {
    MeetingStatus.completed => Colors.green,
    MeetingStatus.failed => Colors.red,
    MeetingStatus.transcribing || MeetingStatus.generating => Colors.orange,
    MeetingStatus.pending => Colors.grey,
  };

  IconData _statusIcon(MeetingStatus s) => switch (s) {
    MeetingStatus.completed => Icons.check_circle_outline,
    MeetingStatus.failed => Icons.error_outline,
    MeetingStatus.transcribing => Icons.transcribe_outlined,
    MeetingStatus.generating => Icons.auto_awesome_outlined,
    MeetingStatus.pending => Icons.hourglass_empty_outlined,
  };

  String _statusLabel(MeetingStatus s) => switch (s) {
    MeetingStatus.transcribing => 'Transcribing...',
    MeetingStatus.generating => 'Generating documents...',
    MeetingStatus.failed => 'Failed',
    _ => '',
  };

  String _formatDate(DateTime dt) {
    final now = DateTime.now();
    if (dt.year == now.year && dt.month == now.month && dt.day == now.day) {
      return 'Today ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    }
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}
