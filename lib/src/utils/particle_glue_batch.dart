import 'dart:ui';

import 'particle_glue.dart';

class ParticleGlueBatch {
  final List<ParticleGlue> glues;

  int tickLeft;

  bool get isFinished => tickLeft <= 0;

  ParticleGlueBatch({
    required this.glues,
    required this.tickLeft,
  });

  void update() {
    tickLeft--;

    for (final glue in glues) {
      glue.physics.update(tickLeft);
    }
  }

  void paint(Canvas canvas, Size size) {
    for (final glue in glues) {
      glue.particle.paint(
        physics: glue.physics,
        canvas: canvas,
      );
    }
  }

  void kill() {
    tickLeft == 0;
  }
}
