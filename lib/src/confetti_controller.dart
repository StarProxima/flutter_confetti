import 'package:flutter_confetti/src/confetti_options.dart';
import 'package:flutter_confetti/src/utils/launcher.dart';

class ConfettiController {
  /// launch the confetti
  void launch([ConfettiOptions? options]) {
    ConfettiLauncher.launch(this, options);
  }

  /// kill the confetti
  void kill() {
    ConfettiLauncher.kill(this);
  }
}
