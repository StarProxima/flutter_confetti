import 'confetti_options.dart';
import 'utils/confetti_launcher.dart';

class ConfettiController {
  ConfettiController();

  Future<void> launch([ConfettiOptions? options]) async {
    await ConfettiLauncher.launch(this, options);
  }

  void kill() {
    ConfettiLauncher.kill(this);
  }
}
