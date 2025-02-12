import 'package:flutter/material.dart';

import '../particle/particle_batch.dart';

class ConfettiPainter extends CustomPainter {
  final List<ParticleBatch> batches;
  final void Function() onTick;

  ConfettiPainter({
    required super.repaint,
    required this.batches,
    required this.onTick,
  });

  @override
  void paint(Canvas canvas, Size size) {
    onTick();

    for (final batch in batches) {
      batch.paint(canvas);
    }
  }

  @override
  bool shouldRepaint(covariant ConfettiPainter oldDelegate) => true;
}
