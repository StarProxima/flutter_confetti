import 'dart:math';
import 'dart:ui';

import '../particle/particle_physics.dart';
import 'painter/particle_painter.dart';

class StarParticle implements ParticlePainter {
  @override
  void paint({
    required Canvas canvas,
    required ParticlePhysics physics,
  }) {
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

    canvas
      ..save()
      ..drawPath(path, paint)
      ..restore();
  }
}
