import 'dart:ui';

import '../particle/particle_physics.dart';
import 'painter/particle_painter.dart';

class TriangleParticle implements ParticlePainter {
  @override
  void paint({
    required Canvas canvas,
    required ParticlePhysics physics,
  }) {
    final path = Path()
      ..moveTo(physics.x.floor().toDouble(), physics.y.floor().toDouble())
      ..lineTo(physics.wobbleX.ceil().toDouble(), physics.y1.floor().toDouble())
      ..lineTo(physics.x2.floor().toDouble(), physics.wobbleY.ceil().toDouble())
      ..close();

    final paint = Paint()..color = physics.color;

    canvas
      ..save()
      ..drawPath(path, paint)
      ..restore();
  }
}
