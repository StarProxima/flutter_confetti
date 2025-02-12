import 'package:flutter/material.dart';

import 'particle_glue_batch.dart';

class ConfettiPainter extends CustomPainter {
  final List<ParticleGlueBatch> glueBatches;
  final void Function() onTick;

  ConfettiPainter({
    required super.repaint,
    required this.glueBatches,
    required this.onTick,
  });

  @override
  void paint(Canvas canvas, Size size) {
    onTick();

    for (final batch in glueBatches) {
      batch.paint(canvas, size);
    }
  }

  @override
  bool shouldRepaint(covariant ConfettiPainter oldDelegate) => true;
}
