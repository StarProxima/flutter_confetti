import 'dart:ui';

import '../../flutter_confetti.dart';
import 'particle/confetti_particle.dart';

class TriangleParticle implements ConfettiParticle {
  @override
  void paint({
    required ConfettiPhysics physics,
    required Canvas canvas,
  }) {
    canvas.save();

    final path = Path()
      ..moveTo(physics.x.floor().toDouble(), physics.y.floor().toDouble())
      ..lineTo(physics.wobbleX.ceil().toDouble(), physics.y1.floor().toDouble())
      ..lineTo(physics.x2.floor().toDouble(), physics.wobbleY.ceil().toDouble())
      ..close();

    final paint = Paint()..color = physics.color;

    canvas.drawPath(path, paint);

    canvas.restore();
  }
}
