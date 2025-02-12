import 'dart:async';

import 'package:flutter/material.dart';

import 'confetti_controller.dart';
import 'confetti_options.dart';
import 'confetti_physics.dart';
import 'shapes/particle/confetti_particle_painter.dart';
import 'utils/confetti_launcher.dart';
import 'utils/confetti_launcher_config.dart';
import 'utils/confetti_painter.dart';
import 'utils/confetti_particle.dart';
import 'utils/confetti_particle_batch.dart';

typedef ParticleBuilder = ConfettiParticlePainter Function(int index);

class Confetti extends StatefulWidget {
  /// The controller of the confetti.
  /// in general, you don't need to provide one.
  final ConfettiController? controller;

  /// The options used to launch the confetti.
  final ConfettiOptions? options;

  /// A builder that creates the particles.
  /// if you don't provide one, a default one will be used.
  /// the default particles are circles and squares.
  final ParticleBuilder particleBuilder;

  final void Function(ConfettiController controller, ConfettiOptions options)?
      onReady;

  final void Function(ConfettiOptions options)? onLaunch;

  /// A callback that will be called when the confetti finished its animation.
  final void Function()? onFinished;

  /// if true, the confetti will be launched instantly as soon as it is created.
  /// the default value is false.
  final bool instant;

  final Widget? child;

  const Confetti({
    super.key,
    this.controller,
    this.options,
    this.particleBuilder = ConfettiParticlePainter.defaultBuilder,
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
  /// [insertInOverlay] is a callback that will be called to insert the confetti into the overlay.
  static ConfettiController launch(
    BuildContext context, {
    required ConfettiOptions options,
    ParticleBuilder particleBuilder = ConfettiParticlePainter.defaultBuilder,
    void Function(OverlayEntry overlayEntry)? insertInOverlay,
    void Function(OverlayEntry overlayEntry)? onFinished,
  }) {
    OverlayEntry? overlayEntry;
    final controller = ConfettiController();

    overlayEntry = OverlayEntry(
      builder: (context) {
        final height = MediaQuery.of(context).size.height;
        final width = MediaQuery.of(context).size.width;

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

  List<ConfettiParticleBatch> batches = [];

  List<Timer> timers = [];

  late ConfettiController controller;

  late AnimationController animationController;
  late Size size;

  void addParticles(ConfettiOptions options) {
    playAnimation();

    widget.onLaunch?.call(options);

    final x = options.x * size.width;
    final y = options.y * size.height;

    final particles = <ConfettiParticle>[];

    for (int i = 0; i < options.particleCount; i++) {
      final physic = ConfettiParticlePhysics.fromOptions(
        options,
        x: x,
        y: y,
      );

      final particle = ConfettiParticle(
        painter: widget.particleBuilder(i),
        physics: physic,
      );

      particles.add(particle);
    }

    final batch = ConfettiParticleBatch(
      particles: particles,
      tickLeft: options.ticks,
    );

    batches.add(batch);
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

      if (!context.mounted) {
        return;
      }
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

    if (minDuration != null) {
      await Future.delayed(minDuration);
    }
  }

  void kill() {
    for (final batch in batches) {
      batch.kill();
    }

    for (final timer in timers) {
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
    batches.removeWhere((batch) => batch.isFinished);

    for (final batch in batches) {
      batch.update();
    }

    if (batches.isEmpty) {
      animationController.stop();

      widget.onFinished?.call();
    }
  }

  @override
  void initState() {
    super.initState();

    initAnimation();

    controller = widget.controller ?? ConfettiController();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        size = (context as Element).size!;

        widget.onReady?.call(controller, options);

        if (widget.instant) {
          launch(null);
        }
      },
    );

    ConfettiLauncher.load(
      controller,
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
      ConfettiLauncher.unload(controller);

      controller = widget.controller ?? ConfettiController();

      ConfettiLauncher.load(
        controller,
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

    ConfettiLauncher.unload(controller);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      willChange: true,
      painter: ConfettiPainter(
        repaint: animationController,
        batches: batches,
        onTick: onTick,
      ),
      child: widget.child ?? const SizedBox.expand(),
    );
  }
}
