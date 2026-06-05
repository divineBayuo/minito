import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minito/features/meetings/presentation/providers/meetings_provider.dart';
import 'package:minito/features/meetings/presentation/widgets/output_tab_view.dart';
import 'package:minito/features/meetings/presentation/widgets/processing_status.dart';

// shows a single meeting: its processing status, generated docs
// and (when completed) the full transcript in a bottom sheet

class MeetingDetailScreen extends ConsumerWidget {
  const MeetingDetailScreen({super.key, required this.meetingId});

  final String meetingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meetingAsync = ref.watch(meetingByIdProvider(meetingId));
    final outputsAsync = ref.watch(meetingOutputsProvider(meetingId));

    return meetingAsync.when(
      data: (meeting) {
        if (meeting == null) {
          return const Scaffold(
            body: Center(child: Text('Meeting not found.')),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(meeting.title),
            actions: [
              IconButton(
                onPressed: () => _showTranscript(context, ref),
                icon: const Icon(Icons.description_outlined),
                tooltip: 'View transcript',
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Pipeline progress
              ProcessingStatus(
                status: meeting.status,
                errorMessage: meeting.errorMessage,
              ),

              // meeting metadata
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Wrap(
                  spacing: 8,
                  children: [
                    Chip(
                      label: Text(
                        '${meeting.durationSeconds ~/ 60} min',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    ...meeting.tags.map(
                      (tag) => Chip(
                        label: Text(tag, style: const TextStyle(fontSize: 12)),
                      ),
                    ),
                  ],
                ),
              ),

              // output tabs
              Expanded(
                child: outputsAsync.when(
                  data: (outputs) => OutputTabView(
                    outputs: outputs,
                    meetingTitle: meeting.title,
                  ),
                  error: (e, _) => Center(child: Text('Error: $e')),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                ),
              ),
            ],
          ),
        );
      },
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }

  void _showTranscript(BuildContext context, WidgetRef ref) {
    final transcriptAsync = ref.read(meetingTranscriptProvider(meetingId));
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.95,
        minChildSize: 0.4,
        expand: false,
        builder: (_, ctrl) => Padding(
          padding: const EdgeInsets.all(20),
          child: transcriptAsync.when(
            data: (t) => t == null
                ? const Text('Transcript not yet available.')
                : SingleChildScrollView(
                    controller: ctrl,
                    child: Text(t.fullText),
                  ),
            error: (e, _) => Text('Error: $e'),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
