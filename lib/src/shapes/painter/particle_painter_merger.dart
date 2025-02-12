import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../particle/particle_physics.dart';
import 'particle_painter.dart';

class ParticlePainterMerger implements ParticlePainter {
  final List<ParticlePainter> painters;

  ParticlePainterMerger(this.painters);

  static final _random = Random();

  late final particlePainter = painters[_random.nextInt(painters.length)];

  @override
  void paint({
    required Canvas canvas,
    required ParticlePhysics physics,
  }) {
    particlePainter.paint(canvas: canvas, physics: physics);
  }
}
