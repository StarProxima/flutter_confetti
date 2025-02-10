import 'dart:math';
import 'dart:ui';

import 'package:flutter_confetti/src/confetti_particle.dart';
import 'package:flutter_confetti/src/confetti_physics.dart';

class Quadrangle implements ConfettiParticle {
  final double distortionX;
  final double distortionY;
  static final _random = Random();

  final double dx1;
  final double dy1;
  final double dx2;
  final double dy2;

  Quadrangle({this.distortionX = 2.0, this.distortionY = 2.0})
      : dx1 = (_random.nextDouble() * 2 - 1) * distortionX,
        dy1 = (_random.nextDouble() * 2 - 1) * distortionY,
        dx2 = (_random.nextDouble() * 2 - 1) * distortionX,
        dy2 = (_random.nextDouble() * 2 - 1) * distortionY;

  @override
  void paint({
    required ConfettiPhysics physics,
    required Canvas canvas,
  }) {
    canvas.save();

    final paint = Paint()..color = physics.color;

    final path = Path()
      ..moveTo(
        physics.x + dx1,
        physics.y + dy1,
      )
      ..lineTo(
        physics.wobbleX + dx2,
        physics.y1 + dy1,
      )
      ..lineTo(
        physics.x2 + dx2,
        physics.y2 + dy2,
      )
      ..lineTo(
        physics.x1 + dx1,
        physics.wobbleY + dy2,
      )
      ..close();

    canvas.drawPath(path, paint);
    canvas.restore();
  }
}
