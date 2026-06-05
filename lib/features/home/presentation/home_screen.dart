import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minito/features/home/presentation/widgets/record_card.dart';
import 'package:minito/features/meetings/presentation/providers/meetings_provider.dart';

// the default landing screen: a searchable list of all meetings
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final meetingsAsync = ref.watch(meetingsStreamProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minito'),
        actions: [
          IconButton(
            onPressed: () {
              /* settings*/
            },
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: SearchBar(
              hintText: 'Search meetings...',
              leading: const Icon(Icons.search),
              onChanged: (v) => setState(() => _query = v.toLowerCase()),
            ),
          ),
        ),
      ),
      body: meetingsAsync.when(
        data: (meetings) {
          final filtered = _query.isEmpty
              ? meetings
              : meetings
                    .where((m) => m.title.toLowerCase().contains(_query))
                    .toList();

          if (filtered.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.mic_none_rounded,
                    size: 64,
                    color: theme.colorScheme.outlineVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _query.isEmpty
                        ? 'No meetings yet.\nTap Record to start.'
                        : 'No results for "$_query"',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 80),
            itemCount: filtered.length,
            itemBuilder: (context, i) {
              final meeting = filtered[i];
              return RecordingCard(
                meeting: meeting,
                onTap: () => context.go('/meeting/${meeting.id}'),
                onDelete: () => ref
                    .read(meetingsProvider.notifier)
                    .deleteMeeting(meeting.id),
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
