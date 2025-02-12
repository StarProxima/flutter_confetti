import 'dart:ui';

import 'package:flutter/material.dart';

import '../../confetti_physics.dart';
import '../circle.dart';
import '../square.dart';
import 'confetti_particle_merger.dart';

abstract class ConfettiParticle {
  void paint({
    required ConfettiPhysics physics,
    required Canvas canvas,
  });

  factory ConfettiParticle.merge(
    List<ConfettiParticle> particles,
  ) = ConfettiParticleMerger;

  factory ConfettiParticle.defaultBuilder(int _) => ConfettiParticleMerger(
        [CircleParticle(), SquareParticle()],
      );
}
