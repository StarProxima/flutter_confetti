import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_confetti/flutter_confetti.dart';

import 'confetti_particle.dart';

class ConfettiParticleMerger implements ConfettiParticle {
  final List<ConfettiParticle> particles;

  ConfettiParticleMerger(this.particles);

  static final _random = Random();

  late final particle = particles[_random.nextInt(particles.length)];

  @override
  void paint({required ConfettiPhysics physics, required Canvas canvas}) {
    particle.paint(physics: physics, canvas: canvas);
  }
}
