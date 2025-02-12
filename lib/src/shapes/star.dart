import 'dart:math';
import 'dart:ui';

import '../confetti_physics.dart';
import 'particle/confetti_particle.dart';

class StarParticle implements ConfettiParticle {
  @override
  void paint({
    required ConfettiPhysics physics,
    required Canvas canvas,
  }) {
    canvas.save();

    final innerRadius = 4 * physics.scalar;
    final outerRadius = 8 * physics.scalar;
    double rot = pi / 2 * 3;
    double x = physics.x;
    double y = physics.y;
    int spikes = 5;
    final step = pi / spikes;

    final path = Path()..moveTo(x, y);

    while (spikes-- >= 0) {
      x = physics.x + cos(rot) * outerRadius;
      y = physics.y + sin(rot) * outerRadius;
      path.lineTo(x, y);
      rot += step;

      x = physics.x + cos(rot) * innerRadius;
      y = physics.y + sin(rot) * innerRadius;
      path.lineTo(x, y);
      rot += step;
    }

    path.close();

    final paint = Paint()..color = physics.color;

    canvas.drawPath(path, paint);

    canvas.restore();
  }
}
