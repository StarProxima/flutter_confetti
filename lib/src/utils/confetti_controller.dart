import 'confetti_options.dart';
import 'confetti_launcher.dart';

class ConfettiController {
  ConfettiController();

  /// launch the confetti
  Future<void> launch([ConfettiOptions? options]) async {
    await ConfettiLauncher.launch(this, options);
  }

  /// kill the confetti
  void kill() {
    ConfettiLauncher.kill(this);
  }
}
