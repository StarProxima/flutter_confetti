import 'package:flutter_confetti/src/confetti_particle.dart';
import 'package:flutter_confetti/src/confetti_physics.dart';

class ParticleGlue {
  final ConfettiParticle particle;
  final ConfettiPhysics physics;

  const ParticleGlue({
    required this.particle,
    required this.physics,
  });
}
