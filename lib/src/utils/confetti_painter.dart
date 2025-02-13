import 'package:flutter/material.dart';

import '../particle/particle_batch.dart';

class ConfettiPainter extends CustomPainter {
  final List<ParticleBatch> batches;

  ConfettiPainter({
    required super.repaint,
    required this.batches,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final batch in batches) {
      batch.paint(canvas);
    }
  }

  @override
  bool shouldRepaint(covariant ConfettiPainter oldDelegate) => true;
}
