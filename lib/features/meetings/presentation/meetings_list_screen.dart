// a full page meetings list used when the home tab is split from a
// dedicated meetings browser
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minito/features/home/presentation/widgets/record_card.dart';
import 'package:minito/features/meetings/domain/models/meeting.dart';
import 'package:minito/features/meetings/presentation/providers/meetings_provider.dart';

class MeetingsListScreen extends ConsumerStatefulWidget {
  const MeetingsListScreen({super.key, this.filterTag});

  // optional tag to filter the list
  final String? filterTag;

  @override
  ConsumerState<MeetingsListScreen> createState() => _MeetingsListScreenState();
}

class _MeetingsListScreenState extends ConsumerState<MeetingsListScreen> {
  MeetingStatus? _statusFilter;

  @override
  Widget build(BuildContext context) {
    final meetingsAsync = ref.watch(meetingsStreamProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.filterTag != null ? '#${widget.filterTag}' : 'All meetings',
        ),
        actions: [
          PopupMenuButton<MeetingStatus?>(
            icon: const Icon(Icons.filter_list),
            tooltip: 'Filter by status',
            initialValue: _statusFilter,
            onSelected: (v) => setState(() => _statusFilter = v),
            itemBuilder: (_) => [
              const PopupMenuItem(value: null, child: Text('All')),
              ...MeetingStatus.values.map(
                (s) => PopupMenuItem(value: s, child: Text(s.name)),
              ),
            ],
          ),
        ],
      ),
      body: meetingsAsync.when(
        data: (meetings) {
          var filtered = meetings;

          // tag filter
          if (widget.filterTag != null) {
            filtered = filtered
                .where((m) => m.tags.contains(widget.filterTag))
                .toList();
          }

          // status filter
          if (_statusFilter != null) {
            filtered = filtered
                .where((m) => m.status == _statusFilter)
                .toList();
          }

          if (filtered.isEmpty) {
            return Center(
              child: Text(
                'No meetings found.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 32),
            itemCount: filtered.length,
            itemBuilder: (_, i) {
              final m = filtered[i];
              return RecordingCard(
                meeting: m,
                onTap: () => context.go('/meeting/${m.id}'),
                onDelete: () =>
                    ref.read(meetingsProvider.notifier).deleteMeeting(m.id),
              );
            },
          );
        },
        error: (e, _) => Center(child: Text('Error: $e')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
