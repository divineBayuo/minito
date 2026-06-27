// displays an animated bar-chart wavefrom during recording
// the bars animate up/down using a sine wave offset to simulate live audio
// in a prod build, replace the simulation with real amplitude data
// from the record package's onAmplitude stream

import 'dart:math';
import 'package:flutter/material.dart';

class AudioWaveform extends StatefulWidget {
  const AudioWaveform({
    super.key,
    this.isActive = false,
    this.barCount = 32,
    this.color,
  });

  final bool isActive;
  final int barCount;
  final Color? color;

  @override
  State<AudioWaveform> createState() => _AudioWaveformState();
}

class _AudioWaveformState extends State<AudioWaveform>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final waveformColor = widget.color ?? theme.colorScheme.primary;

    // ✅ No fixed height here — let the parent (SizedBox in RecordScreen)
    // control the height. SizedBox.expand fills whatever space is given.
    return SizedBox.expand(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return CustomPaint(
            // ✅ size: Size.infinite tells CustomPaint to fill its parent
            // constraint rather than collapsing to zero
            size: Size.infinite,
            painter: _WaveformPainter(
              progress: _controller.value,
              isActive: widget.isActive,
              barCount: widget.barCount,
              color: waveformColor,
            ),
          );
        },
      ),
    );
  }
}

class _WaveformPainter extends CustomPainter {
  const _WaveformPainter({
    required this.progress,
    required this.isActive,
    required this.barCount,
    required this.color,
  });

  final double progress;
  final bool isActive;
  final int barCount;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isActive
          ? color.withValues(alpha: 0.95)
          : color.withValues(alpha: 0.18)
      ..style = PaintingStyle.fill;

    const gap = 3.0;
    final barWidth = (size.width - (barCount - 1) * gap) / barCount;
    final maxBarHeight = size.height;

    for (int i = 0; i < barCount; i++) {
      final phase = (i / barCount) * 2 * pi;
      final wave = sin(progress * 2 * pi + phase);
      final centerBias =
          1 - ((i - barCount / 2).abs() / (barCount / 2));
      final heightFactor = isActive
          ? (0.18 + 0.55 * ((wave + 1) / 2) * (0.45 + centerBias * 0.55))
          : 0.12;

      final barHeight = maxBarHeight * heightFactor;
      final x = i * (barWidth + gap);
      final y = (maxBarHeight - barHeight) / 2;

      final rrect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, barWidth, barHeight),
        Radius.circular(barWidth / 2),
      );

      // glow layer (active only)
      if (isActive) {
        final glowStrength =
            (0.06 + 0.18 * heightFactor).clamp(0.06, 0.22);
        final glowPaint = Paint()
          ..color = color.withValues(alpha: glowStrength)
          ..style = PaintingStyle.fill
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
        canvas.drawRRect(rrect, glowPaint);
      }

      canvas.drawRRect(rrect, paint);
    }
  }

  @override
  bool shouldRepaint(_WaveformPainter old) =>
      old.progress != progress || old.isActive != isActive;
}