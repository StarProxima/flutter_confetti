import 'package:flutter/material.dart';

const List<Color> defaultColors = [
  Color(0xFF26ccff),
  Color(0xFFa25afd),
  Color(0xFFff5e7e),
  Color(0xFFfcff42),
  Color(0xFFffa62d),
  Color(0xFFff36ff),
];

class ConfettiOptions {
  final int particleCount;
  final double angle;
  final double spread;
  final double startVelocity;
  final double decay;
  final double gravity;
  final double drift;
  final double driftSpread;
  final double? wobbleSpeed;
  final int ticks;
  final int opacityTicks;
  final double x;
  final double y;
  final List<Color> colors;
  final double scalar;
  final double waveIntensity;
  final double waveFactor;
  final Duration? launchDelay;
  final Duration? launchPeriod;
  final Duration? launchInterval;
  final int? launchCount;
  final bool flat;

  const ConfettiOptions({
    this.colors = defaultColors,
    this.particleCount = 50,
    this.angle = 90,
    this.spread = 45,
    this.startVelocity = 45,
    this.decay = 0.9,
    this.gravity = 1,
    this.drift = 0,
    this.driftSpread = 0,
    this.flat = false,
    this.wobbleSpeed,
    this.scalar = 1,
    this.x = 0.5,
    this.y = 0.5,
    this.ticks = 200,
    this.opacityTicks = 75,
    this.waveIntensity = 0,
    this.waveFactor = 1,
    this.launchDelay,
    this.launchPeriod,
    this.launchInterval,
    this.launchCount,
  })  : assert(decay >= 0),
        assert(ticks > 0);

  ConfettiOptions copyWith({
    int? particleCount,
    double? angle,
    double? spread,
    double? startVelocity,
    double? decay,
    double? gravity,
    double? drift,
    bool? flat,
    double? scalar,
    double? x,
    double? y,
    int? ticks,
    double? driftSpread,
    double? wobbleSpeed,
    int? opacityTicks,
    double? waveIntensity,
    double? waveFactor,
    List<Color>? colors,
    Duration? launchDelay,
    Duration? launchPeriod,
    Duration? launchInterval,
    int? launchCount,
  }) =>
      ConfettiOptions(
        particleCount: particleCount ?? this.particleCount,
        angle: angle ?? this.angle,
        spread: spread ?? this.spread,
        startVelocity: startVelocity ?? this.startVelocity,
        decay: decay ?? this.decay,
        gravity: gravity ?? this.gravity,
        drift: drift ?? this.drift,
        flat: flat ?? this.flat,
        scalar: scalar ?? this.scalar,
        x: x ?? this.x,
        y: y ?? this.y,
        ticks: ticks ?? this.ticks,
        driftSpread: drift ?? this.driftSpread,
        wobbleSpeed: wobbleSpeed ?? this.wobbleSpeed,
        waveIntensity: waveIntensity ?? this.waveIntensity,
        waveFactor: waveFactor ?? this.waveFactor,
        opacityTicks: opacityTicks ?? this.opacityTicks,
        colors: colors ?? this.colors,
        launchDelay: launchDelay ?? this.launchDelay,
        launchPeriod: launchPeriod ?? this.launchPeriod,
        launchInterval: launchInterval ?? this.launchInterval,
        launchCount: launchCount ?? this.launchCount,
      );
}
