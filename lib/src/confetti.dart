import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_confetti/src/confetti_controller.dart';
import 'package:flutter_confetti/src/confetti_options.dart';
import 'package:flutter_confetti/src/confetti_physics.dart';
import 'package:flutter_confetti/src/shapes/square.dart';
import 'package:flutter_confetti/src/utils/glue.dart';
import 'package:flutter_confetti/src/utils/launcher.dart';
import 'package:flutter_confetti/src/utils/launcher_config.dart';
import 'package:flutter_confetti/src/utils/painter.dart';
import 'package:flutter_confetti/src/confetti_particle.dart';
import 'package:flutter_confetti/src/shapes/circle.dart';

typedef ParticleBuilder = ConfettiParticle Function(int index);

class Confetti extends StatefulWidget {
  /// The controller of the confetti.
  /// in general, you don't need to provide one.
  final ConfettiController controller;

  /// The options used to launch the confetti.
  final ConfettiOptions? options;

  /// A builder that creates the particles.
  /// if you don't provide one, a default one will be used.
  /// the default particles are circles and squares.
  final ParticleBuilder? particleBuilder;

  final void Function()? onReady;

  final void Function(ConfettiOptions options)? onLaunch;

  /// A callback that will be called when the confetti finished its animation.
  final void Function()? onFinished;

  /// if true, the confetti will be launched instantly as soon as it is created.
  /// the default value is false.
  final bool instant;

  final Widget? child;

  const Confetti({
    super.key,
    required this.controller,
    this.options,
    this.particleBuilder,
    this.onReady,
    this.onLaunch,
    this.onFinished,
    this.instant = false,
    this.child,
  });

  @override
  State<Confetti> createState() => _ConfettiState();

  /// A quick way to launch the confetti.
  /// Notice: If your APP is not using the MaterialApp as the root widget,
  /// you can't use this method. Instead, you should use the Confetti widget directly.
  /// [context] is the context of the APP.
  /// [options] is the options used to launch the confetti.
  /// [particleBuilder] is the builder that creates the particles. if you don't
  /// provide one, a default one will be used.The default particles are circles and squares..
  /// [onFinished] is a callback that will be called when the confetti finished its animation.
  static ConfettiController launch(
    BuildContext context, {
    required ConfettiOptions options,
    ParticleBuilder? particleBuilder,
    Function(OverlayEntry overlayEntry)? onFinished,
  }) {
    OverlayEntry? overlayEntry;
    final controller = ConfettiController();

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
              controller: controller,
              options: options.copyWith(x: 0.5, y: 0.5),
              particleBuilder: particleBuilder,
              onFinished: () {
                if (onFinished != null) {
                  onFinished(overlayEntry!);
                } else {
                  overlayEntry?.remove();
                }
              },
              instant: true,
            ),
          );
        },
        opaque: false);

    Overlay.of(context).insert(overlayEntry);

    return controller;
  }
}

class _ConfettiState extends State<Confetti>
    with SingleTickerProviderStateMixin {
  ConfettiOptions get options => widget.options ?? const ConfettiOptions();

  List<Glue> glueList = [];

  List<Timer> timers = [];

  late AnimationController animationController;
  late double containerWidth;
  // late double containerHeight;

  int randomInt(int min, int max) {
    return Random().nextInt(max - min) + min;
  }

  ConfettiParticle defaultParticleBuilder(int index) =>
      [Circle(), Square()][randomInt(0, 2)];

  void addParticles(ConfettiOptions options) {
    playAnimation();

    widget.onLaunch?.call(options);

    final colors = options.colors;
    final colorsCount = colors.length;

    final particleBuilder = widget.particleBuilder ?? defaultParticleBuilder;

    double x = options.x * containerWidth;
    double y = options.y * containerWidth;

    for (int i = 0; i < options.particleCount; i++) {
      final color = colors[i % colorsCount];
      final physic = ConfettiPhysics.fromOptions(options: options, color: color)
        ..x = x
        ..y = y;

      final glue = Glue(particle: particleBuilder(i), physics: physic);

      glueList.add(glue);
    }
  }

  void initAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    animationController.addListener(() async {
      final finished = glueList.every((element) => element.physics.isFinished);

      if (finished) {
        animationController.stop();

        widget.onFinished?.call();
      }
    });
  }

  void playAnimation() {
    if (!animationController.isAnimating) {
      animationController.repeat();
    }
  }

  Future<void> launch(ConfettiOptions? confettiOptions) async {
    final options = confettiOptions ?? this.options;

    final delay = options.launchDelay;
    if (delay != null) {
      await Future.delayed(delay);

      if (!context.mounted) return;
    }

    setupTimerForOptions(options);

    addParticles(options);

    final launchPeriod = options.launchPeriod;

    final launchInterval = options.launchInterval;
    final launchCount = options.launchCount;

    final durationFromCount = launchInterval != null && launchCount != null
        ? Duration(milliseconds: launchInterval.inMilliseconds * launchCount)
        : null;

    final Duration? minDuration;

    if (launchPeriod == null) {
      minDuration = durationFromCount;
    } else if (durationFromCount == null) {
      minDuration = launchPeriod;
    } else if (launchPeriod < durationFromCount) {
      minDuration = launchPeriod;
    } else {
      minDuration = durationFromCount;
    }

    if (minDuration != null) await Future.delayed(minDuration);
  }

  void kill() {
    for (var glue in glueList) {
      glue.physics.kill();
    }

    for (var timer in timers) {
      timer.cancel();
    }
  }

  void setupTimerForOptions(ConfettiOptions options) {
    final interval = options.launchInterval;

    if (interval != null) {
      final timer = Timer.periodic(
        interval,
        (timer) {
          final launchPeriod = options.launchPeriod;
          if (launchPeriod != null) {
            final timerDuration = Duration(
              milliseconds: interval.inMilliseconds * timer.tick,
            );

            if (timerDuration >= launchPeriod) {
              timer.cancel();
              return;
            }
          }

          final launchCount = options.launchCount;
          if (launchCount != null) {
            if (timer.tick >= launchCount) {
              timer.cancel();
              return;
            }
          }

          addParticles(options);
        },
      );

      timers.add(timer);
    }
  }

  @override
  void initState() {
    super.initState();

    initAnimation();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        widget.onReady?.call();
        if (widget.instant) launch(null);
      },
    );

    ConfettiLauncher.load(
      widget.controller,
      LauncherConfig(
        onLaunch: launch,
        onKill: kill,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant Confetti oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      ConfettiLauncher.unload(oldWidget.controller);
      ConfettiLauncher.load(
        widget.controller,
        LauncherConfig(
          onLaunch: launch,
          onKill: kill,
        ),
      );
    }
  }

  @override
  void dispose() {
    animationController.dispose();

    kill();

    ConfettiLauncher.unload(widget.controller);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      containerWidth = constraints.maxWidth;
      // containerHeight = constraints.maxHeight;

      return CustomPaint(
        willChange: true,
        painter: Painter(
          glueList: glueList,
          listenable: animationController,
        ),
        child: widget.child ?? const SizedBox.expand(),
      );
    });
  }
}
