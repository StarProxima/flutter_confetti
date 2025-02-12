import 'dart:ui';

import 'package:flutter/material.dart';

import '../../particle/particle_physics.dart';
import '../circle.dart';
import '../square.dart';
import 'particle_painter_merger.dart';

abstract class ParticlePainter {
  void paint({
    required ParticlePhysics physics,
    required Canvas canvas,
  });

  factory ParticlePainter.merge(
    List<ParticlePainter> particles,
  ) = ParticlePainterMerger;

  factory ParticlePainter.defaultBuilder(int _) => ParticlePainterMerger(
        [CircleParticle(), SquareParticle()],
      );
}
