import 'confetti_options.dart';

class ConfettiLauncherConfig {
  final Future<void> Function(ConfettiOptions? options) onLaunch;
  final void Function() onKill;

  const ConfettiLauncherConfig({
    required this.onLaunch,
    required this.onKill,
  });
}
