import 'dart:ui';

import 'package:flutter_confetti/src/utils/confetti_options.dart';

import 'particle.dart';

class ParticleBatch {
  final ConfettiOptions options;
  final List<Particle> particles;

  int _tickLeft;
  int get tickLeft => _tickLeft;
  bool get isFinished => _tickLeft <= 0;

  ParticleBatch({
    required this.options,
    required this.particles,
    required int tickLeft,
  }) : _tickLeft = tickLeft;

  void paint(Canvas canvas) {
    for (final particle in particles) {
      particle.painter.paint(
        physics: particle.physics,
        canvas: canvas,
      );
    }
  }

  void updatePhysics() {
    _tickLeft--;

    for (final particle in particles) {
      particle.physics.update(_tickLeft);
    }
  }

  void stop() {
    _tickLeft = 0;
  }
}
