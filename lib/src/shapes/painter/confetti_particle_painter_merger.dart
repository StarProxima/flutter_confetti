import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../confetti_physics.dart';
import 'confetti_particle_painter.dart';

class ConfettiParticlePainterMerger implements ConfettiParticlePainter {
  final List<ConfettiParticlePainter> particlesPainters;

  ConfettiParticlePainterMerger(this.particlesPainters);

  static final _random = Random();

  late final particlePainter =
      particlesPainters[_random.nextInt(particlesPainters.length)];

  @override
  void paint({
    required Canvas canvas,
    required ConfettiParticlePhysics physics,
  }) {
    particlePainter.paint(canvas: canvas, physics: physics);
  }
}
