import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_confetti/src/confetti_controller.dart';
import 'package:flutter_confetti/src/confetti_options.dart';
import 'package:flutter_confetti/src/confetti_physics.dart';
import 'package:flutter_confetti/src/utils/particle_glue.dart';
import 'package:flutter_confetti/src/utils/confetti_launcher.dart';
import 'package:flutter_confetti/src/utils/confetti_launcher_config.dart';
import 'package:flutter_confetti/src/utils/confetti_painter.dart';
import 'package:flutter_confetti/src/utils/particle_glue_batch.dart';

import 'shapes/particle/confetti_particle.dart';

typedef ParticleBuilder = ConfettiParticle Function(int index);

class Confetti extends StatefulWidget {
  final ConfettiController controller;
  final ConfettiOptions? options;
  final ParticleBuilder particleBuilder;
  final void Function()? onReady;
  final void Function(ConfettiOptions options)? onLaunch;
  final void Function()? onFinished;
  final bool instant;
  final Widget? child;

  const Confetti({
    super.key,
    required this.controller,
    this.options,
    this.particleBuilder = ConfettiParticle.defaultBuilder,
    this.onReady,
    this.onLaunch,
    this.onFinished,
    this.instant = false,
    this.child,
  });

  @override
  State<Confetti> createState() => _ConfettiState();

  static ConfettiController launch(
    BuildContext context, {
    required ConfettiOptions options,
    ParticleBuilder particleBuilder = ConfettiParticle.defaultBuilder,
    void Function(OverlayEntry overlayEntry)? insertInOverlay,
    void Function(OverlayEntry overlayEntry)? onFinished,
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
      opaque: false,
    );

    if (insertInOverlay != null) {
      insertInOverlay(overlayEntry);
    } else {
      Overlay.of(context).insert(overlayEntry);
    }

    return controller;
  }
}

class _ConfettiState extends State<Confetti>
    with SingleTickerProviderStateMixin {
  ConfettiOptions get options => widget.options ?? const ConfettiOptions();

  List<ParticleGlueBatch> glueBatches = [];

  List<Timer> timers = [];

  late AnimationController animationController;
  late Size size;

  void addParticles(ConfettiOptions options) {
    playAnimation();

    widget.onLaunch?.call(options);

    double x = options.x * size.width;
    double y = options.y * size.height;

    final glues = <ParticleGlue>[];

    for (int i = 0; i < options.particleCount; i++) {
      final physic = ConfettiPhysics.fromOptions(
        options,
        x: x,
        y: y,
      );

      final glue = ParticleGlue(
        particle: widget.particleBuilder(i),
        physics: physic,
      );

      glues.add(glue);
    }

    final batch = ParticleGlueBatch(
      glues: glues,
      tickLeft: options.ticks,
    );

    glueBatches.add(batch);
  }

  void initAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
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
    for (var batch in glueBatches) {
      batch.kill();
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

  void onTick() {
    glueBatches.removeWhere((batch) => batch.isFinished);

    for (final batch in glueBatches) {
      batch.update();
    }

    if (glueBatches.isEmpty) {
      animationController.stop();

      widget.onFinished?.call();
    }
  }

  @override
  void initState() {
    super.initState();

    initAnimation();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        size = (context as Element).size!;

        widget.onReady?.call();
        if (widget.instant) launch(null);
      },
    );

    ConfettiLauncher.load(
      widget.controller,
      ConfettiLauncherConfig(
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
        ConfettiLauncherConfig(
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
    return CustomPaint(
      willChange: true,
      painter: ConfettiPainter(
        repaint: animationController,
        glueBatches: glueBatches,
        onTick: onTick,
      ),
      child: widget.child ?? const SizedBox.expand(),
    );
  }
}
