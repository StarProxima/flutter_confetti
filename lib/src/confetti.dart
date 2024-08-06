import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_confetti/src/confetti_controller.dart';
import 'package:flutter_confetti/src/confetti_options.dart';
import 'package:flutter_confetti/src/confetti_physics.dart';
import 'package:flutter_confetti/src/shapes/square.dart';
import 'package:flutter_confetti/src/utils/glue.dart';
import 'package:flutter_confetti/src/utils/launcher.dart';
import 'package:flutter_confetti/src/utils/painter.dart';
import 'package:flutter_confetti/src/confetti_particle.dart';
import 'package:flutter_confetti/src/shapes/circle.dart';

typedef ParticleBuilder = ConfettiParticle Function(int index);

class Confetti extends StatefulWidget {
  /// The options used to launch the confetti.
  final ConfettiOptions? options;

  /// A builder that creates the particles.
  /// if you don't provide one, a default one will be used.
  /// the default particles are circles and squares.
  final ParticleBuilder? particleBuilder;

  /// The controller of the confetti.
  /// in general, you don't need to provide one.
  final ConfettiController? controller;

  /// A callback that will be called when the confetti finished its animation.
  final Function()? onFinished;

  const Confetti(
      {super.key,
      this.options,
      this.particleBuilder,
      this.controller,
      this.onFinished});

  @override
  State<Confetti> createState() => _ConfettiState();

  /// A quick way to launch the confetti.
  /// Notice: If your APP is not using the MaterialApp as the root widget,
  /// you can't use this method. Instead, you should use the Confetti widget directly.
  /// [context] is the context of the APP.
  /// [options] is the options used to launch the confetti.
  /// [particleBuilder] is the builder that creates the particles. if you don't
  /// provide one, a default one will be used.The default particles are circles and squares..
  static void launch(BuildContext context,
      {required ConfettiOptions options, ParticleBuilder? particleBuilder}) {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry? overlayEntry;

    overlayEntry = OverlayEntry(
        builder: (BuildContext ctx) {
          final height = MediaQuery.of(ctx).size.height;
          final width = MediaQuery.of(ctx).size.width;

          return Positioned(
            left: width * options.x,
            top: height * options.y,
            width: 2,
            height: 2,
            child: Confetti(
              options: options,
              particleBuilder: particleBuilder,
              onFinished: () {
                overlayEntry?.remove();
              },
            ),
          );
        },
        opaque: false);

    overlayState.insert(overlayEntry);
  }
}

class _ConfettiState extends State<Confetti>
    with SingleTickerProviderStateMixin {
  ConfettiOptions get options {
    return widget.options ?? const ConfettiOptions();
  }

  List<Glue> glueList = [];

  late AnimationController animationController;
  late Animation<double> animation;

  double containerWidth = 0;
  double containerHeight = 0;

  randomInt(int min, int max) {
    return Random().nextInt(max - min) + min;
  }

  addParticles() {
    final hasController = widget.controller != null;

    final colors = options.colors;
    final colorsCount = colors.length;

    final particleBuilder = widget.particleBuilder != null
        ? widget.particleBuilder!
        : (int index) => [Circle(), Square()][randomInt(0, 2)];

    List<Glue> list = [];

    for (int i = 0; i < options.particleCount; i++) {
      final color = colors[i % colorsCount];
      final glue = Glue(
          particle: particleBuilder(i),
          physics: ConfettiPhysics.fromOptions(options: options, color: color)
            ..x = hasController ? containerWidth * options.x : 1
            ..y = hasController ? containerHeight * options.y : 1);
      list.add(glue);
    }

    glueList.addAll(list);
  }

  bool updatePhysics() {
    bool finished = true;

    for (var i = 0; i < glueList.length; i++) {
      final glue = glueList[i];

      if (!glue.physics.finished) {
        glue.physics.update();

        if (finished == true) {
          finished = false;
        }
      }
    }

    return finished;
  }

  initAnimation() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);

    animation.addListener(() {
      final finished = updatePhysics();

      if (finished) {
        animationController.stop();

        if (widget.onFinished != null) {
          widget.onFinished!();
        }
      }
    });
  }

  playAnimation() {
    if (animationController.isAnimating == false) {
      animationController.repeat();
    }
  }

  launch() {
    addParticles();
    playAnimation();
  }

  @override
  void initState() {
    super.initState();

    initAnimation();

    if (widget.controller == null) {
      launch();
    } else {
      Launcher.load(widget.controller!, launch);
    }
  }

  @override
  void dispose() {
    animationController.dispose();

    if (widget.controller != null) {
      Launcher.unload(widget.controller!);
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animated = AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return CustomPaint(painter: Painter(glueList: glueList));
      },
    );

    if (widget.controller != null) {
      return LayoutBuilder(
        builder: (context, constraints) {
          containerWidth = constraints.maxWidth;
          containerHeight = constraints.maxHeight;

          return animated;
        },
      );
    } else {
      return animated;
    }
  }
}
