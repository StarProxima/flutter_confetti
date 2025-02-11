import 'dart:math';
import 'dart:ui';

import 'package:flutter_confetti/src/confetti_particle.dart';
import 'package:flutter_confetti/src/confetti_physics.dart';

class Quadrangle implements ConfettiParticle {
  final double distortionX;
  final double distortionY;
  static final _random = Random();

  double get _r => _random.nextDouble() * 2 - 1;

  late final double dx1 = _r * distortionX;
  late final double dy1 = _r * distortionY;
  late final double dx2 = _r * distortionX;
  late final double dy2 = _r * distortionY;
  late final double dx3 = _r * distortionX;
  late final double dy3 = _r * distortionY;
  late final double dx4 = _r * distortionX;
  late final double dy4 = _r * distortionY;

  Quadrangle({this.distortionX = 2.0, this.distortionY = 2.0});

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
        physics.wobbleX + dx3,
        physics.y1 + dy3,
      )
      ..lineTo(
        physics.x2 + dx2,
        physics.y2 + dy2,
      )
      ..lineTo(
        physics.x1 + dx4,
        physics.wobbleY + dy4,
      )
      ..close();

    canvas.drawPath(path, paint);

    canvas.restore();
  }
}
