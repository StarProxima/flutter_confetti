import 'package:flutter_confetti/src/confetti_options.dart';
import 'package:flutter_confetti/src/utils/confetti_launcher.dart';

class ConfettiController {
  ConfettiController();

  Future<void> launch([ConfettiOptions? options]) async {
    await ConfettiLauncher.launch(this, options);
  }

  void kill() {
    ConfettiLauncher.kill(this);
  }
}
