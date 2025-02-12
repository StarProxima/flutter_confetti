import 'particle_physics.dart';
import '../shapes/painter/particle_painter.dart';

class Particle {
  final ParticlePainter painter;
  final ParticlePhysics physics;

  const Particle({
    required this.painter,
    required this.physics,
  });
}
