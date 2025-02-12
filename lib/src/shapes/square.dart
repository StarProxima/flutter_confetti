import 'dart:ui';

import 'package:flutter_confetti/src/confetti_particle.dart';
import 'package:flutter_confetti/src/confetti_physics.dart';

class Square implements ConfettiParticle {
  @override
  void paint({
    required ConfettiPhysics physics,
    required Canvas canvas,
  }) {
    canvas.save();

    final path = Path()
      ..moveTo(
        physics.x.floor().toDouble(),
        physics.y.floor().toDouble(),
      )
      ..lineTo(
        physics.wobbleX.floor().toDouble(),
        physics.y1.floor().toDouble(),
      )
      ..lineTo(
        physics.x2.floor().toDouble(),
        physics.y2.floor().toDouble(),
      )
      ..lineTo(
        physics.x1.floor().toDouble(),
        physics.wobbleY.floor().toDouble(),
      )
      ..close();

    final paint = Paint()..color = physics.color;

    canvas.drawPath(path, paint);

    canvas.restore();
  }
}
