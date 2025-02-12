import 'dart:ui';

import 'confetti_particle.dart';

class ConfettiParticleBatch {
  final List<ConfettiParticle> particles;

  int tickLeft;

  bool get isFinished => tickLeft <= 0;

  ConfettiParticleBatch({
    required this.particles,
    required this.tickLeft,
  });

  void update() {
    tickLeft--;

    for (final glue in particles) {
      glue.physics.update(tickLeft);
    }
  }

  void paint(Canvas canvas, Size size) {
    for (final glue in particles) {
      glue.painter.paint(
        physics: glue.physics,
        canvas: canvas,
      );
    }
  }

  void kill() {
    tickLeft = 0;
  }
}
