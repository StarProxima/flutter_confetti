import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../particle/particle_physics.dart';
import 'painter/particle_painter.dart';

class EmojiParticle implements ParticlePainter {
  final String emoji;
  final TextStyle? textStyle;

  EmojiParticle({
    required this.emoji,
    this.textStyle,
  });

  ui.Image? _cachedImage;

  Future<ui.Image> _createTextImage() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final textStyle = this.textStyle ?? const TextStyle();
    final fontSize = textStyle.fontSize ?? 18;
    final scaleFontSize = fontSize * 4;

    final textPainter = TextPainter(
      text: TextSpan(
        text: emoji,
        style: textStyle.copyWith(fontSize: scaleFontSize),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter
      ..layout()
      ..paint(canvas, Offset.zero);

    final picture = recorder.endRecording();
    final imageSize = (scaleFontSize + 10).toInt();

    return picture.toImage(imageSize, imageSize);
  }

  @override
  void paint({
    required Canvas canvas,
    required ParticlePhysics physics,
  }) {
    if (_cachedImage == null) {
      _createTextImage().then((image) {
        _cachedImage = image;
      });
      return;
    }

    final paint = Paint()
      ..color = Color.fromRGBO(255, 255, 255, physics.opacity);

    canvas
      ..save()
      ..translate(physics.x, physics.y)
      ..rotate(pi / 10 * physics.wobble)
      ..scale(0.25, 0.25)
      ..drawImage(_cachedImage!, Offset.zero, paint)
      ..restore();
  }
}
