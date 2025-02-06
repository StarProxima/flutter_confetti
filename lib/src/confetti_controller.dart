import 'package:flutter_confetti/src/utils/launcher.dart';

class ConfettiController {
  /// launch the confetti
  void launch() {
    ConfettiLauncher.launch(this);
  }

  /// kill the confetti
  void kill() {
    ConfettiLauncher.kill(this);
  }
}
