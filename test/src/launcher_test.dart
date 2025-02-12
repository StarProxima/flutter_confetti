import 'package:flutter_confetti/src/confetti_controller.dart';
import 'package:flutter_confetti/src/utils/confetti_launcher.dart';
import 'package:flutter_confetti/src/utils/confetti_launcher_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('callback should be called', () {
    final key = ConfettiController();
    int counter = 0;
    ConfettiLauncher.load(
        key,
        ConfettiLauncherConfig(
            onLaunch: (_) async {
              counter++;
            },
            onKill: () {}));
    ConfettiLauncher.launch(key, null);
    expect(counter, equals(1));
  });

  test('callback should not be called after unload', () {
    final key = ConfettiController();
    int counter = 0;

    ConfettiLauncher.load(
        key,
        ConfettiLauncherConfig(
            onLaunch: (_) async {
              counter++;
            },
            onKill: () {}));

    ConfettiLauncher.unload(key);
    ConfettiLauncher.launch(key, null);

    expect(counter, equals(0));
  });
}
