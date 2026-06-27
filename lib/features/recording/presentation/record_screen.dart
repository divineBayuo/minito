import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minito/core/extensions/duration_ext.dart';
import 'package:minito/features/ai_processing/presentation/providers/processing_provider.dart';
import 'package:minito/features/recording/presentation/providers/audio_recorder_provider.dart';
import 'package:minito/features/recording/presentation/widgets/audio_waveform.dart';
import 'package:minito/features/recording/presentation/widgets/recording_controls.dart';
import 'package:minito/features/meetings/presentation/providers/meetings_provider.dart';

class RecordScreen extends ConsumerWidget {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(audioRecorderProvider);
    final notifier = ref.read(audioRecorderProvider.notifier);
    final theme = Theme.of(context);

    ref.listen<RecorderState>(audioRecorderProvider, (_, next) async {
      if (next.completedRecording != null) {
        final meeting = await ref
            .read(meetingsProvider.notifier)
            .saveRecording(next.completedRecording!);
        ref.read(processingProvider.notifier).enqueue(meeting.id);
        notifier.reset();
        if (context.mounted) context.push('/meeting/${meeting.id}');
      }
      if (next.error != null) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: theme.colorScheme.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          ),
        );
      }
    });

    final elapsed = Duration(seconds: state.elapsedSeconds);
    final isRecording = state.status == RecordingStatus.recording;
    final isPaused = state.status == RecordingStatus.paused;
    final isActive = isRecording || isPaused;

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'Record meeting',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),

              // ── Status badge ─────────────────────────────────
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isRecording
                      ? theme.colorScheme.error.withOpacity(0.10)
                      : isPaused
                          ? theme.colorScheme.primary.withOpacity(0.10)
                          : theme.colorScheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isRecording
                        ? theme.colorScheme.error.withOpacity(0.20)
                        : isPaused
                            ? theme.colorScheme.primary.withOpacity(0.20)
                            : theme.colorScheme.outlineVariant,
                    width: 0.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isRecording) ...[
                      _PulsingDot(color: theme.colorScheme.error),
                      const SizedBox(width: 8),
                    ] else if (isPaused) ...[
                      Icon(
                        Icons.pause_rounded,
                        size: 12,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 6),
                    ],
                    Text(
                      switch (state.status) {
                        RecordingStatus.idle => 'Ready to record',
                        RecordingStatus.recording => 'Recording',
                        RecordingStatus.paused => 'Paused',
                        RecordingStatus.stopped => 'Saving...',
                      },
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: isRecording
                            ? theme.colorScheme.error
                            : isPaused
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 56),

              // ── Elapsed timer ────────────────────────────────
              Text(
                elapsed.toTimerString(),
                style: theme.textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w200,
                  letterSpacing: -2,
                  fontFeatures: const [FontFeature.tabularFigures()],
                  color: isActive
                      ? theme.colorScheme.onSurface
                      : theme.colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 8),

              // subtle label under timer
              Text(
                isRecording
                    ? 'Recording in progress'
                    : isPaused
                        ? 'Recording paused'
                        : 'Tap the button below to start',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 48),

              // ── Waveform ─────────────────────────────────────
              SizedBox(
                height: 80,
                //padding: const EdgeInsets.symmetric(horizontal: 8),
                child: AudioWaveform(isActive: isRecording),
              ),

              const Spacer(),

              // ── Controls ─────────────────────────────────────
              RecordingControls(
                state: state,
                onStart: notifier.start,
                onStop: notifier.stop,
                onPause: notifier.pause,
                onResume: notifier.resume,
              ),

              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Pulsing dot ──────────────────────────────────────────────────────────────

class _PulsingDot extends StatefulWidget {
  const _PulsingDot({required this.color});
  final Color color;

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: _ctrl,
        child: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.circle,
          ),
        ),
      );
}