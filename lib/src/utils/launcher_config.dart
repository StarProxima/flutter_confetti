import 'package:flutter_confetti/src/confetti_options.dart';

class LauncherConfig {
  final Future<void> Function(ConfettiOptions? options) onLaunch;
  final void Function() onKill;

  const LauncherConfig({
    required this.onLaunch,
    required this.onKill,
  });
}
