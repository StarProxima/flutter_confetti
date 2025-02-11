import 'package:flutter_confetti/src/confetti_controller.dart';
import 'package:flutter_confetti/src/confetti_options.dart';
import 'package:flutter_confetti/src/utils/launcher_config.dart';

class ConfettiLauncher {
  static final Map<ConfettiController, LauncherConfig> _bullets = {};

  static void load(
    ConfettiController controller,
    LauncherConfig launcherConfig,
  ) {
    _bullets[controller] = launcherConfig;
  }

  static void launch(ConfettiController controller, ConfettiOptions? options) {
    _bullets[controller]?.onLaunch(options);
  }

  static void kill(ConfettiController controller) {
    _bullets[controller]?.onKill();
  }

  static void unload(ConfettiController controller) {
    _bullets.remove(controller);
  }
}
