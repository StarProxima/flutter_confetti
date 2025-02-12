import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'confetti_options.dart';

class ConfettiParticlePhysics {
  Color color;
  double wobble;
  double wobbleSpeed;
  double velocity;
  double angle2D;
  double tiltAngle;
  double decay;
  double drift;
  double gravity;
  double scalar;
  double ovalScalar;
  double wobbleX;
  double wobbleY;
  double tiltSin;
  double tiltCos;
  double random;
  double waveIntensity;
  bool flat;

  double opacity = 1;
  double x = 0;
  double y = 0;
  double x1 = 0;
  double x2 = 0;
  double y1 = 0;
  double y2 = 0;

  final Color initialColor;
  final int totalTicks;
  final int opacityTicks;

  static final _random = Random();

  late final _randomDouble = _random.nextDouble();

  ConfettiParticlePhysics({
    required this.x,
    required this.y,
    required this.wobble,
    required this.wobbleSpeed,
    required this.velocity,
    required this.angle2D,
    required this.tiltAngle,
    required this.color,
    required this.decay,
    required this.drift,
    required this.random,
    required this.tiltSin,
    required this.wobbleX,
    required this.wobbleY,
    required this.gravity,
    required this.ovalScalar,
    required this.scalar,
    required this.waveIntensity,
    required this.flat,
    required this.tiltCos,
    required this.totalTicks,
    required this.opacityTicks,
  }) : initialColor = color;

  factory ConfettiParticlePhysics.fromOptions(
    ConfettiOptions options, {
    required double x,
    required double y,
  }) {
    final radAngle = options.angle * (pi / 180);
    final radSpread = options.spread * (pi / 180);

    final driftSpread = options.driftSpread;

    final color = options.colors[_random.nextInt(options.colors.length)];

    return ConfettiParticlePhysics(
      color: color,
      x: x,
      y: y,
      wobble: _random.nextDouble() * 10,
      wobbleSpeed:
          options.wobbleSpeed ?? min(0.11, _random.nextDouble() * 0.1 + 0.05),
      velocity: options.startVelocity * 0.5 +
          _random.nextDouble() * options.startVelocity,
      angle2D: -radAngle + (0.5 * radSpread - _random.nextDouble() * radSpread),
      tiltAngle: (_random.nextDouble() * (0.75 - 0.25) + 0.25) * pi,
      decay: options.decay,
      drift: options.drift +
          (driftSpread != 0
              ? _random.nextDouble() * driftSpread - driftSpread / 2
              : 0),
      random: _random.nextDouble() + 2,
      tiltSin: 0,
      tiltCos: 0,
      wobbleX: 0,
      wobbleY: 0,
      gravity: options.gravity * 3,
      ovalScalar: 0.6,
      scalar: options.scalar,
      waveIntensity: options.waveIntensity,
      flat: options.flat,
      totalTicks: options.ticks,
      opacityTicks: options.opacityTicks,
    );
  }

  void update(int tickLeft) {
    if (tickLeft < opacityTicks) {
      opacity = tickLeft / opacityTicks;
      color = color.withOpacity(opacity * initialColor.opacity);
    }

    final wave = waveIntensity != 0
        ? sin(2 * pi * _randomDouble +
            (tickLeft * waveIntensity * (_randomDouble + 0.1) / 20))
        : 0.0;

    x += cos(angle2D) * velocity + drift + wave;
    y += sin(angle2D) * velocity + gravity;

    velocity *= decay;

    if (flat) {
      wobble = 0;
      wobbleX = x + (10 * scalar);
      wobbleY = y + (10 * scalar);

      tiltSin = 0;
      tiltCos = 0;
      random = 1;
    } else {
      wobble += wobbleSpeed;
      wobbleX = x + 10 * scalar * cos(wobble);
      wobbleY = y + 10 * scalar * sin(wobble);

      tiltAngle += 0.1;
      tiltSin = sin(tiltAngle);
      tiltCos = cos(tiltAngle);
      random = _random.nextDouble() + 2;
    }

    x1 = x + random * tiltCos;
    y1 = y + random * tiltSin;
    x2 = wobbleX + random * tiltCos;
    y2 = wobbleY + random * tiltSin;
  }
}
