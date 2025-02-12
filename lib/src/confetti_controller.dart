import 'package:flutter_confetti/src/confetti_options.dart';
import 'package:flutter_confetti/src/utils/confetti_launcher.dart';

class ConfettiController {
  const ConfettiController();

  /// launch the confetti
  Future<void> launch([ConfettiOptions? options]) async {
    await ConfettiLauncher.launch(this, options);
  }

  /// kill the confetti
  void kill() {
    ConfettiLauncher.kill(this);
  }
}
