import 'dart:math';
import 'dart:ui';

import '../confetti_physics.dart';
import 'particle/confetti_particle_painter.dart';

class CircleParticle implements ConfettiParticlePainter {
  @override
  void paint({
    required Canvas canvas,
    required ConfettiParticlePhysics physics,
  }) {
    final paint = Paint()..color = physics.color;

    canvas
      ..save()
      ..translate(physics.x, physics.y)
      ..rotate(pi / 10 * physics.wobble)
      ..scale(
        (physics.x2 - physics.x1).abs() * physics.ovalScalar,
        (physics.y2 - physics.y1).abs() * physics.ovalScalar,
      )
      ..drawArc(
        Rect.fromCircle(center: const Offset(0, 0), radius: 1),
        0,
        2 * pi,
        true,
        paint,
      )
      ..restore();
  }
}
