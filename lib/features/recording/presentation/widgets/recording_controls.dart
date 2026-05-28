// the primary control row on the Record Screen
// shows start -> Pause/Stop when recording, stop alone when paused
import 'package:flutter/material.dart';
import 'package:minito/features/recording/presentation/providers/audio_recorder_provider.dart';

class RecordingControls extends StatelessWidget {
  const RecordingControls({
    super.key,
    required this.state,
    required this.onStart,
    required this.onStop,
    required this.onPause,
    required this.onResume,
  });

  final RecorderState state;
  final VoidCallback onStart;
  final VoidCallback onStop;
  final VoidCallback onPause;
  final VoidCallback onResume;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: switch (state.status) {
        RecordingStatus.idle || RecordingStatus.stopped => [
          _BigButton(
            icon: Icons.mic_rounded,
            label: 'Record',
            color: Colors.red,
            onTap: onStart,
          ),
        ],
        RecordingStatus.recording => [
          _BigButton(
            icon: Icons.pause_rounded,
            label: 'Pause',
            color: colorScheme.secondary,
            onTap: onPause,
          ),
          const SizedBox(width: 24),
          _BigButton(
            icon: Icons.stop_rounded,
            label: 'Stop',
            color: Colors.red,
            onTap: onStop,
          ),
        ],
        RecordingStatus.paused => [
          _BigButton(
            icon: Icons.play_arrow_rounded,
            label: 'Resume',
            color: colorScheme.primary,
            onTap: onResume,
          ),
          const SizedBox(width: 24),
          _BigButton(
            icon: Icons.stop_rounded,
            label: 'Stop',
            color: Colors.red,
            onTap: onStop,
          ),
        ],
      },
    );
  }
}

class _BigButton extends StatelessWidget {
  const _BigButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 2),
            ),
            child: Icon(icon, color: color, size: 34),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(color: color, fontSize: 13)),
      ],
    );
  }
}
