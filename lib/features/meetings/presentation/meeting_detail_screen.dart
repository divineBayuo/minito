import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minito/features/meetings/presentation/providers/meetings_provider.dart';
import 'package:minito/features/meetings/presentation/widgets/output_tab_view.dart';
import 'package:minito/features/meetings/presentation/widgets/processing_status.dart';

class MeetingDetailScreen extends ConsumerWidget {
  const MeetingDetailScreen({super.key, required this.meetingId});

  final String meetingId;

  // Bricolage Grotesque applied via a helper TextStyle
  static const _fontFamily = 'Bricolage Grotesque';

  static TextStyle _t(
    BuildContext context, {
    double size = 14,
    FontWeight weight = FontWeight.w400,
    Color? color,
  }) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: size,
    fontWeight: weight,
    color: color ?? Theme.of(context).colorScheme.onSurface,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meetingAsync = ref.watch(meetingByIdProvider(meetingId));
    final outputsAsync = ref.watch(meetingOutputsProvider(meetingId));
    final theme = Theme.of(context);

    return meetingAsync.when(
      data: (meeting) {
        if (meeting == null) {
          return Scaffold(
            backgroundColor: theme.colorScheme.surfaceContainerLowest,
            appBar: _buildAppBar(context, theme, 'Not found'),
            body: Center(
              child: Text(
                'Meeting not found.',
                style: _t(context, color: theme.colorScheme.onSurfaceVariant),
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: theme.colorScheme.surfaceContainerLowest,
          appBar: _buildAppBar(context, theme, meeting.title),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Processing status banner ─────────────────────
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: double.infinity),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ProcessingStatus(
                    status: meeting.status,
                    errorMessage: meeting.errorMessage,
                  ),
                ),
              ),

              // ── Metadata chips ───────────────────────────────
              if (meeting.durationSeconds > 0 || meeting.tags.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      if (meeting.durationSeconds > 0)
                        _MetaChip(
                          icon: Icons.timer_outlined,
                          label: '${meeting.durationSeconds ~/ 60} min',
                        ),
                      ...meeting.tags.map(
                        (tag) => _MetaChip(
                          icon: Icons.label_outline_rounded,
                          label: tag,
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 4),

              // ── Output tabs ──────────────────────────────────
              Expanded(
                child: outputsAsync.when(
                  data: (outputs) => OutputTabView(
                    outputs: outputs,
                    meetingTitle: meeting.title,
                  ),
                  error: (e, _) => Center(
                    child: Text(
                      'Failed to load outputs.',
                      style: _t(
                        context,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  loading: () => Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      error: (e, _) => Scaffold(
        backgroundColor: theme.colorScheme.surfaceContainerLowest,
        appBar: _buildAppBar(context, theme, 'Error'),
        body: Center(
          child: Text(
            'Something went wrong.',
            style: _t(context, color: theme.colorScheme.onSurfaceVariant),
          ),
        ),
      ),
      loading: () => Scaffold(
        backgroundColor: theme.colorScheme.surfaceContainerLowest,
        appBar: _buildAppBar(context, theme, ''),
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    ThemeData theme,
    String title,
  ) {
    return AppBar(
      backgroundColor: theme.colorScheme.surfaceContainerLowest,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      leadingWidth: 56,
      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: GestureDetector(
          onTap: () {
            // pop if there's something to pop, otherwise go home
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 16,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
      ),
      title: title.isEmpty
          ? null
          : Text(
              title,
              style: _t(context, size: 16, weight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: GestureDetector(
            onTap: () => _showTranscript(context),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.description_outlined,
                size: 18,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showTranscript(BuildContext context) {
    // get ref from context via ProviderScope — we read it in the builder
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Consumer(
        builder: (ctx, ref, _) {
          final theme = Theme.of(ctx);
          final transcriptAsync = ref.watch(
            meetingTranscriptProvider(meetingId),
          );

          return Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: DraggableScrollableSheet(
              initialChildSize: 0.7,
              maxChildSize: 0.95,
              minChildSize: 0.4,
              expand: false,
              builder: (_, ctrl) => Column(
                children: [
                  // drag handle
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 8),
                    child: Container(
                      width: 36,
                      height: 4,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.outlineVariant,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  // header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
                    child: Row(
                      children: [
                        Text(
                          'Transcript',
                          style: TextStyle(
                            fontFamily: _fontFamily,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Navigator.pop(ctx),
                          child: Icon(
                            Icons.close_rounded,
                            size: 20,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Divider(height: 0.5, color: theme.colorScheme.outlineVariant),

                  // content
                  Expanded(
                    child: transcriptAsync.when(
                      data: (t) => t == null
                          ? Center(
                              child: Text(
                                'Transcript not yet available.',
                                style: TextStyle(
                                  fontFamily: _fontFamily,
                                  fontSize: 14,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            )
                          : SingleChildScrollView(
                              controller: ctrl,
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                t.fullText,
                                style: TextStyle(
                                  fontFamily: _fontFamily,
                                  fontSize: 14,
                                  height: 1.7,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ),
                      error: (e, _) => Center(
                        child: Text(
                          'Failed to load transcript.',
                          style: TextStyle(
                            fontFamily: _fontFamily,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      loading: () => Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Metadata chip ────────────────────────────────────────────────────────────

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.outlineVariant, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'BricolageGrotesque',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
