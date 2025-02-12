import 'dart:ui';

import '../confetti_physics.dart';
import 'particle/confetti_particle.dart';

class TriangleParticle implements ConfettiParticle {
  @override
  void paint({
    required ConfettiPhysics physics,
    required Canvas canvas,
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
