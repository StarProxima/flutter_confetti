import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/painting.dart';
import '../../flutter_confetti.dart';
import 'particle/confetti_particle.dart';

class EmojiParticle implements ConfettiParticle {
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
          text: emoji, style: textStyle.copyWith(fontSize: scaleFontSize)),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset.zero);

    final picture = recorder.endRecording();
    final imageSize = (scaleFontSize + 10).toInt();

    return picture.toImage(imageSize, imageSize);
  }

  @override
  void paint({
    required ConfettiPhysics physics,
    required Canvas canvas,
  }) {
    if (_cachedImage == null) {
      _createTextImage().then((image) {
        _cachedImage = image;
      });
      return;
    }

    canvas.save();

    canvas.translate(physics.x, physics.y);
    canvas.rotate(pi / 10 * physics.wobble);
    canvas.scale(0.25, 0.25);

    final paint = Paint()
      ..color = Color.fromRGBO(255, 255, 255, physics.opacity);

    canvas.drawImage(_cachedImage!, Offset.zero, paint);

    canvas.restore();
  }
}
