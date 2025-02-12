import '../confetti_physics.dart';
import '../shapes/particle/confetti_particle.dart';

class ParticleGlue {
  final ConfettiParticle particle;
  final ConfettiPhysics physics;

  const ParticleGlue({
    required this.particle,
    required this.physics,
  });
}
