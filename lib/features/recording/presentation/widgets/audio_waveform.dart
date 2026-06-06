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
    final color = widget.color ?? Theme.of(context).colorScheme.primary;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return CustomPaint(
          painter: _WaveformPainter(
            progress: _controller.value,
            isActive: widget.isActive,
            barCount: widget.barCount,
            color: color,
          ),
        );
      },
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
      ..color = isActive ? color : color.withValues(alpha: 0.25)
      ..style = PaintingStyle.fill;

    final barWidth = size.width / (barCount * 2 - 1);
    final maxBarHeight = size.height;

    for (int i = 0; i < barCount; i++) {
      final phase = (i / barCount) * 2 * pi;
      final wave = sin(progress * 2 * pi + phase);
      // idle: flat bars, active: animated wave with random like variation
      final heightFactor = isActive
          ? 0.15 + 0.75 * ((wave + 1) / 2) * (0.4 + 0.6 * ((i % 5) / 5))
          : 0.08;
      final barHeight = maxBarHeight * heightFactor;
      final x = i * barWidth * 2;
      final y = (maxBarHeight - barHeight) / 2;

      final rrect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, barWidth, barHeight),
        Radius.circular(barWidth / 2),
      );
      canvas.drawRRect(rrect, paint);
    }
  }

  @override
  bool shouldRepaint(_WaveformPainter old) =>
      old.progress != progress || old.isActive != isActive;
}
