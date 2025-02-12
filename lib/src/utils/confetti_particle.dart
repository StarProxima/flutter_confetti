import '../confetti_physics.dart';
import '../shapes/particle/confetti_particle_painter.dart';

class ConfettiParticle {
  final ConfettiParticlePainter painter;
  final ConfettiParticlePhysics physics;

  const ConfettiParticle({
    required this.painter,
    required this.physics,
  });
}