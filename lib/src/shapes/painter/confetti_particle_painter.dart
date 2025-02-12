import 'dart:ui';

import 'package:flutter/material.dart';

import '../../confetti_physics.dart';
import '../circle.dart';
import '../square.dart';
import 'confetti_particle_painter_merger.dart';

abstract class ConfettiParticlePainter {
  void paint({
    required ConfettiParticlePhysics physics,
    required Canvas canvas,
  });

  factory ConfettiParticlePainter.merge(
    List<ConfettiParticlePainter> particles,
  ) = ConfettiParticlePainterMerger;

  factory ConfettiParticlePainter.defaultBuilder(int _) =>
      ConfettiParticlePainterMerger(
        [CircleParticle(), SquareParticle()],
      );
}
