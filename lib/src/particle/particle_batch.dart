import 'dart:ui';

import 'particle.dart';

class ParticleBatch {
  final List<Particle> particles;

  int tickLeft;

  bool get isFinished => tickLeft <= 0;

  ParticleBatch({
    required this.particles,
    required this.tickLeft,
  });

  void paint(Canvas canvas) {
    for (final particle in particles) {
      particle.painter.paint(
        physics: particle.physics,
        canvas: canvas,
      );
    }
  }

  void updatePhysics() {
    tickLeft--;

    for (final particle in particles) {
      particle.physics.update(tickLeft);
    }
  }

  void kill() {
    tickLeft = 0;
  }
}
