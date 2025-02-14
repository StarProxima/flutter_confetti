import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/confetti_controller.dart';
import '../utils/confetti_options.dart';
import '../particle/particle_physics.dart';
import '../shapes/painter/particle_painter.dart';
import '../utils/confetti_painter.dart';
import '../particle/particle.dart';
import '../particle/particle_batch.dart';

typedef ParticleBuilder = ParticlePainter Function(int index);

typedef ConfettiOnReady = void Function(
  ConfettiController controller,
  ConfettiOptions options,
);

typedef ConfettiOnLaunch = void Function(
  ConfettiOptions options,
  ParticleBatch batch,
);

class Confetti extends StatefulWidget {
  final ConfettiController? controller;
  final ConfettiOptions? options;
  final ParticleBuilder particleBuilder;
  final ConfettiOnReady? onReady;
  final ConfettiOnLaunch? onLaunch;
  final void Function()? onFinished;
  final bool instant;
  final Widget? child;

  const Confetti({
    super.key,
    this.controller,
    this.options,
    this.particleBuilder = ParticlePainter.defaultBuilder,
    this.onReady,
    this.onLaunch,
    this.onFinished,
    this.instant = false,
    this.child,
  });

  @override
  State<Confetti> createState() => ConfettiState();

  static ConfettiController launch(
    BuildContext context, {
    required ConfettiOptions options,
    ParticleBuilder particleBuilder = ParticlePainter.defaultBuilder,
    void Function(OverlayEntry overlayEntry)? insertInOverlay,
    final ConfettiOnReady? onReady,
    final ConfettiOnLaunch? onLaunch,
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
            particleBuilder: particleBuilder,
            options: options.copyWith(x: 0.5, y: 0.5),
            instant: true,
            onReady: onReady,
            onLaunch: onLaunch,
            onFinished: () {
              if (onFinished != null) {
                onFinished(overlayEntry!);
              } else {
                overlayEntry?.remove();
              }
            },
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

class ConfettiState extends State<Confetti>
    with SingleTickerProviderStateMixin {
  static const tickRate = 60;
  static const tickTime = Duration(
    milliseconds: 1000 ~/ tickRate,
  );

  List<ParticleBatch> batches = [];
  List<Timer> launchTimers = [];
  Timer? tickTimer;

  late ConfettiController controller;
  late Size size;
  late AnimationController animationController;

  ConfettiOptions get options => widget.options ?? const ConfettiOptions();

  void playAnimation() {
    if (!animationController.isAnimating) {
      animationController.repeat();
    }

    final tickTimer = this.tickTimer;
    if (tickTimer == null || !tickTimer.isActive) {
      this.tickTimer = Timer.periodic(
        tickTime,
        (_) {
          onTick();
        },
      );
    }
  }

  void onTick() {
    batches.removeWhere((batch) => batch.isFinished);

    for (final batch in batches) {
      batch.updatePhysics();
    }

    if (batches.isEmpty) {
      tickTimer?.cancel();

      Future(() {
        if (!mounted) return;

        animationController.stop();
      });
    }
  }

  void addParticles(ConfettiOptions options) {
    final x = options.x * size.width;
    final y = options.y * size.height;

    final particles = <Particle>[];

    for (int i = 0; i < options.particleCount; i++) {
      final physics = ParticlePhysics.fromOptions(
        options,
        x: x,
        y: y,
      );

      final painter = widget.particleBuilder(i);

      final particle = Particle(
        painter: painter,
        physics: physics,
      );

      particles.add(particle);
    }

    final batch = ParticleBatch(
      options: options,
      particles: particles,
      tickLeft: options.ticks,
    )..updatePhysics();

    batches.add(batch);

    widget.onLaunch?.call(options, batch);

    playAnimation();
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

    setupLaunchTimer(options);

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

  void setupLaunchTimer(ConfettiOptions options) {
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

      launchTimers.add(timer);
    }
  }

  void clear() {
    for (final timer in launchTimers) {
      timer.cancel();
    }

    for (final batch in batches) {
      batch.stop();
    }

    tickTimer?.cancel();

    setState(onTick);
  }

  @override
  void initState() {
    super.initState();

    controller = widget.controller ?? ConfettiController();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        size = (context as Element).size!;

        widget.onReady?.call(controller, options);

        if (widget.instant) {
          launch(null);
        }
      },
    );

    controller.attach(this);
  }

  @override
  void didUpdateWidget(covariant Confetti oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      controller.dettach();

      controller = widget.controller ?? ConfettiController();

      controller.attach(this);
    }
  }

  @override
  void dispose() {
    clear();

    widget.onFinished?.call();

    controller.dettach();

    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      willChange: true,
      painter: ConfettiPainter(
        repaint: animationController,
        batches: batches,
      ),
      child: widget.child ?? const SizedBox.expand(),
    );
  }
}
