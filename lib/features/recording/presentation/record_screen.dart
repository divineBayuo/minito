import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minito/core/extensions/duration_ext.dart';
import 'package:minito/features/ai_processing/presentation/providers/processing_provider.dart';
import 'package:minito/features/recording/presentation/providers/audio_recorder_provider.dart';
import 'package:minito/features/recording/presentation/widgets/audio_waveform.dart';
import 'package:minito/features/recording/presentation/widgets/recording_controls.dart';
import 'package:minito/features/meetings/presentation/providers/meetings_provider.dart';

// the main screen for capturing a new meeting audio recording
// shows a live wavefrom, elapsed timer, and start/pause/stop controls

class RecordScreen extends ConsumerWidget {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(audioRecorderProvider);
    final notifier = ref.read(audioRecorderProvider.notifier);
    final theme = Theme.of(context);

    // when recording stops, save the meeting and go to detail
    ref.listen<RecorderState>(audioRecorderProvider, (_, next) async {
      if (next.completedRecording != null) {
        // 1. save meeting
        final meeting = await ref
            .read(meetingsProvider.notifier)
            .saveRecording(next.completedRecording!);

        // 2. trigger processing separately - no circular dependency
        ref.read(processingProvider.notifier).enqueue(meeting.id);
        
        notifier.reset();
        if (context.mounted) context.go('/meeting/${meeting.id}');
      }
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!), backgroundColor: Colors.red),
        );
      }
    });

    final elapsed = Duration(seconds: state.elapsedSeconds);

    return Scaffold(
      appBar: AppBar(title: const Text('Record meeting')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          children: [
            // status badge
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: state.status == RecordingStatus.recording
                    ? Colors.red.withValues(alpha: 0.12)
                    : theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (state.status == RecordingStatus.recording)
                    _PulsingDot(color: Colors.red),
                  const SizedBox(width: 8),
                  Text(switch (state.status) {
                    RecordingStatus.idle => 'Ready to record',
                    RecordingStatus.recording => 'Recording',
                    RecordingStatus.paused => 'Paused',
                    RecordingStatus.stopped => 'Recording saved',
                  }, style: theme.textTheme.labelLarge),
                ],
              ),
            ),

            const SizedBox(height: 48),

            // elapsed timer
            Text(
              elapsed.toTimerString(),
              style: theme.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w200,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),

            const SizedBox(height: 48),

            // waveform
            SizedBox(
              height: 80,
              child: AudioWaveform(
                isActive: state.status == RecordingStatus.recording,
              ),
            ),

            const Spacer(),

            // controls
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
    );
  }
}

// live indicator
class _PulsingDot extends StatefulWidget {
  final Color color;
  const _PulsingDot({required this.color});

  @override
  State<_PulsingDot> createState() => __PulsingDotState();
}

class __PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
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
      decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle),
    ),
  );
}
