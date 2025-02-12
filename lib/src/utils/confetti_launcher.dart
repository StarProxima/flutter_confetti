import 'confetti_controller.dart';
import 'confetti_options.dart';
import 'confetti_launcher_config.dart';

class ConfettiLauncher {
  static final Map<ConfettiController, ConfettiLauncherConfig> _bullets = {};

  static void load(
    ConfettiController controller,
    ConfettiLauncherConfig launcherConfig,
  ) {
    _bullets[controller] = launcherConfig;
  }

  static Future<void> launch(
    ConfettiController controller,
    ConfettiOptions? options,
  ) async {
    await _bullets[controller]?.onLaunch(options);
  }

  static void kill(ConfettiController controller) {
    _bullets[controller]?.onKill();
  }

  static void unload(ConfettiController controller) {
    _bullets.remove(controller);
  }
}
