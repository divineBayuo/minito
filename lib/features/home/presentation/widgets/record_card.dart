import 'package:flutter/material.dart';
import 'package:minito/core/extensions/duration_ext.dart';
import 'package:minito/features/meetings/domain/models/meeting.dart';

class RecordingCard extends StatelessWidget {
  const RecordingCard({
    super.key,
    required this.meeting,
    required this.onTap,
    this.onDelete,
    this.onRename,
    this.onRetry,
  });

  final Meeting meeting;
  final VoidCallback onTap;
  final VoidCallback? onDelete;
  final ValueChanged<String>? onRename;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final duration = Duration(seconds: meeting.durationSeconds).toHumanLabel();
    final statusColor = _statusColor(theme, meeting.status);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
          width: 0.5,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
          child: Row(
            children: [
              // ── Status icon ────────────────────────────────
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  _statusIcon(meeting.status),
                  color: statusColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),

              // ── Title + metadata ───────────────────────────
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meeting.title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          size: 11,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          duration,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 11,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          _formatDate(meeting.createdAt),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    // status label for in-progress / failed states
                    if (meeting.status != MeetingStatus.completed &&
                        meeting.status != MeetingStatus.pending)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _statusLabel(meeting.status),
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: statusColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // ── Overflow menu ──────────────────────────────
              PopupMenuButton<_CardAction>(
                icon: Icon(
                  Icons.more_vert_rounded,
                  size: 20,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: theme.colorScheme.outlineVariant,
                    width: 0.5,
                  ),
                ),
                elevation: 2,
                itemBuilder: (_) => [
                  _menuItem(
                    value: _CardAction.rename,
                    icon: Icons.drive_file_rename_outline_rounded,
                    label: 'Rename',
                    theme: theme,
                  ),
                  if (meeting.status == MeetingStatus.failed)
                    _menuItem(
                      value: _CardAction.retry,
                      icon: Icons.refresh_rounded,
                      label: 'Retry',
                      theme: theme,
                    ),
                  const PopupMenuDivider(height: 1),
                  _menuItem(
                    value: _CardAction.delete,
                    icon: Icons.delete_outline_rounded,
                    label: 'Delete',
                    theme: theme,
                    isDestructive: true,
                  ),
                ],
                onSelected: (action) {
                  switch (action) {
                    case _CardAction.rename:
                      _showRenameDialog(context, theme);
                    case _CardAction.retry:
                      onRetry?.call();
                    case _CardAction.delete:
                      _showDeleteConfirm(context, theme);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuItem<_CardAction> _menuItem({
    required _CardAction value,
    required IconData icon,
    required String label,
    required ThemeData theme,
    bool isDestructive = false,
  }) {
    final color = isDestructive
        ? theme.colorScheme.error
        : theme.colorScheme.onSurface;
    return PopupMenuItem(
      value: value,
      height: 40,
      child: Row(
        children: [
          Icon(icon, size: 17, color: color),
          const SizedBox(width: 10),
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(color: color),
          ),
        ],
      ),
    );
  }

  void _showRenameDialog(BuildContext context, ThemeData theme) {
    final ctrl = TextEditingController(text: meeting.title);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'Rename recording',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          style: theme.textTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: 'Recording name',
            filled: true,
            fillColor: theme.colorScheme.surfaceContainerHigh,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 1.5,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
          ),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            style: TextButton.styleFrom(
              foregroundColor: theme.colorScheme.onSurfaceVariant,
            ),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final name = ctrl.text.trim();
              if (name.isNotEmpty) onRename?.call(name);
              Navigator.pop(ctx);
            },
            style: FilledButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirm(BuildContext context, ThemeData theme) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'Delete recording?',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'This will permanently delete "${meeting.title}" and all generated documents.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            style: TextButton.styleFrom(
              foregroundColor: theme.colorScheme.onSurfaceVariant,
            ),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              onDelete?.call();
            },
            style: FilledButton.styleFrom(
              backgroundColor: theme.colorScheme.error,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Color _statusColor(ThemeData theme, MeetingStatus s) => switch (s) {
        MeetingStatus.completed => const Color(0xFF3B6D11),
        MeetingStatus.failed => theme.colorScheme.error,
        MeetingStatus.transcribing ||
        MeetingStatus.generating =>
          theme.colorScheme.primary,
        MeetingStatus.pending => theme.colorScheme.onSurfaceVariant,
      };

  IconData _statusIcon(MeetingStatus s) => switch (s) {
        MeetingStatus.completed => Icons.check_circle_outline_rounded,
        MeetingStatus.failed => Icons.error_outline_rounded,
        MeetingStatus.transcribing => Icons.transcribe_outlined,
        MeetingStatus.generating => Icons.auto_awesome_outlined,
        MeetingStatus.pending => Icons.hourglass_empty_rounded,
      };

  String _statusLabel(MeetingStatus s) => switch (s) {
        MeetingStatus.transcribing => 'Transcribing...',
        MeetingStatus.generating => 'Generating documents...',
        MeetingStatus.failed => 'Failed — tap ••• to retry',
        _ => '',
      };

  String _formatDate(DateTime dt) {
    final now = DateTime.now();
    if (dt.year == now.year &&
        dt.month == now.month &&
        dt.day == now.day) {
      return 'Today ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    }
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}

enum _CardAction { rename, retry, delete }